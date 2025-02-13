import 'package:kgk/kgk.dart';
import 'dart:developer' as kgk_logger;

class BranchService {
  static final BranchService _instance = BranchService._internal();

  // Stream controller for deep link data
  final _deepLinkStreamController = StreamController<BranchLinkDataModel>.broadcast();
  StreamSubscription? _deepLinkSubscription;

  Stream<BranchLinkDataModel> get deepLinkStream => _deepLinkStreamController.stream;

  // Singleton factory constructor
  factory BranchService() {
    return _instance;
  }

  BranchService._internal();

  static const String branchLinkType = 'branch_link_type';
  static const String linkExtraData = 'extra_data';
  static const String clickedBranchLink = '+clicked_branch_link';

  // Initialize Branch SDK
  Future<void> initialize() async {
    try {
      await FlutterBranchSdk.init(enableLogging: true);
      // Listen to deep link data stream
      _deepLinkSubscription = FlutterBranchSdk.listSession().listen(
        (Map<dynamic, dynamic> data) {
          kgk_logger.log('🔗 Branch Deep Link Data: ${jsonEncode(data)}');
          if (data.containsKey(clickedBranchLink) && data[clickedBranchLink] == true) {
            if (data[linkExtraData].runtimeType != Map) {
              data[linkExtraData] = data[linkExtraData]?.toString().customStringToJson;
            }

            BranchLinkDataModel branchLinkData = BranchLinkDataModel.fromJson(data[linkExtraData]);
            _deepLinkStreamController.add(branchLinkData);
          }
        },
        onError: (error) {
          kgk_logger.log('❌ Branch Deep Link Error: $error', error: error);
        },
      );
    } catch (e) {
      kgk_logger.log('❌ Failed to initialize Branch SDK: $e', error: e);
    }
  }

  // Create a dynamic link
  Future<BranchResponse> createDeepLink({
    required String title,
    required String description,
    required String destination,
    BranchLinkDataModel? extraData,
    String imageUrl = '',
  }) async {
    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: destination,
      title: title,
      contentDescription: description,
      imageUrl: imageUrl,
      contentMetadata: BranchContentMetaData(),
    );

    kgk_logger.log('Branch link title: $title');
    if (extraData != null) {
      buo.contentMetadata ??= BranchContentMetaData();
      buo.contentMetadata?.addCustomMetadata(linkExtraData, extraData.toJson());
    }

    BranchLinkProperties linkProperties = BranchLinkProperties(
      // Below are static for now but it will be modified in future when we have more use cases
      channel: 'app',
      feature: 'sharing',
    );

    try {
      BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: buo,
        linkProperties: linkProperties,
      );
      kgk_logger.log('Branch link created: ${response.toString()}');
      return response;
    } catch (e) {
      kgk_logger.log('Failed to create Branch link: $e', error: e);
      return BranchResponse.error(errorCode: '500', errorMessage: APPStrings.failedToCreateSharingLink.tr);
    }
  }

  // Get first referring params
  Future<Map<dynamic, dynamic>> getFirstReferringParams() async {
    try {
      return await FlutterBranchSdk.getFirstReferringParams();
    } catch (e) {
      kgk_logger.log('❌ Failed to get first referring params: $e', error: e);
      return {};
    }
  }

  // Get latest Referring params
  Future<Map<dynamic, dynamic>> getLatestReferringParams() async {
    try {
      return await FlutterBranchSdk.getLatestReferringParams();
    } catch (e) {
      kgk_logger.log('❌ Failed to get latest referring params: $e', error: e);
      return {};
    }
  }

  // Dispose resources
  void dispose() {
    _deepLinkStreamController.close();
    _deepLinkSubscription?.cancel();
  }
}
