import 'package:kgk/kgk.dart';

part 'setting_detail_event.dart';

part 'setting_detail_state.dart';

class SettingDetailBloc extends Bloc<SettingDetailEvent, SettingDetailState> {
  late AppBloc appBloc;
  UserType userType = UserType.b2cUser;
  ProductDetailsModel? productDetails;
  DiyStyleListModel? diyStyleListModel;
  final CarouselSliderController controller = CarouselSliderController();

  final List<String> imgList = [];

  String productName = '';
  String? settingId;

  ScreenIdentifier? screenIdentifier;

  SettingDetailBloc() : super(SettingDetailInitial()) {
    on<SettingDetailInitialEvent>(_onSettingDetailInitialEvent);
  }

  Future<void> _onSettingDetailInitialEvent(SettingDetailInitialEvent event, Emitter<SettingDetailState> emit) async {
    getScreenIdentifier(event.context);
    appBloc = BlocProvider.of<AppBloc>(event.context);

    /// assigning current userType
    userType = appBloc.userType;
    imgList.clear();
    await getSettingDetails(event.context, settingId);
    emit(const SettingDetailLoadedState());
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      settingId = data[RoutesData.settingId];
      screenIdentifier = data[RoutesData.isPageFor];
    }
  }

  Future<void> getSettingDetails(BuildContext context, String? settingId) async {
    Either<ErrorResponse, DiyFinalDetailsModel>? response = await AppRepository(context).getDiySettingDetails(settingId ?? '');
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        if (r.product != null) {
          diyStyleListModel = r.product!;
          if (diyStyleListModel != null) {
            if (diyStyleListModel!.imageSketch.isNotNullNorEmpty) {
              imgList.clear();
              imgList.add(diyStyleListModel!.imageSketch ?? '');
            }
            productName = diyStyleListModel!.longDescription ?? '';

            productDetails = ProductDetailsModel(
              suid: diyStyleListModel!.suid,
              productId: diyStyleListModel!.suid,
              imageUrl: diyStyleListModel!.imageSketch,
              subTitle: diyStyleListModel!.autoDescription,
              originalPrice: diyStyleListModel!.finalPrice?.toString().setCurrency,
              finalPrice: diyStyleListModel!.discountPrice?.toString().setCurrency,
              commodity: Commodity.diy,
              businessCategoryName: diyStyleListModel!.businessCategoryName ?? "",
              colorsCode: [diyStyleListModel!.metalColor1HexCode ?? ""],
              components: diyStyleListModel!.components,
              productSku: diyStyleListModel!.styleNumber,
            );
          }
        }
      },
    );
  }

  void handleSelectSetting(BuildContext context) {
    appBloc.diyStyleForDIY = diyStyleListModel;
    final String route = screenIdentifier == ScreenIdentifier.jewelleryForDIY ? AppRoutes.stoneListingPage : AppRoutes.completeProductPage;
    final Map<RoutesData, dynamic> arguments = {
      RoutesData.settingId: settingId,
      RoutesData.isPageFor:
          screenIdentifier == ScreenIdentifier.jewelleryForDIY ? ScreenIdentifier.jewelleryForDIY : ScreenIdentifier.diamondForDIY,
    };
    context.pushNamed(route, arguments: arguments);
  }
}
