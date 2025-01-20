import 'package:kgk/kgk.dart';

part 'setting_detail_event.dart';

part 'setting_detail_state.dart';

class SettingDetailBloc extends Bloc<SettingDetailEvent, SettingDetailState> {
  UserType userType = UserType.b2cUser;

  ProductDetailsModel? productDetails;

  final CarouselSliderController controller = CarouselSliderController();

  final List<String> imgList = [];

  String productName = '';
  String? settingId;

  SettingDetailBloc() : super(SettingDetailInitial()) {
    on<SettingDetailInitialEvent>(_onSettingDetailInitialEvent);
  }

  Future<void> _onSettingDetailInitialEvent(SettingDetailInitialEvent event, Emitter<SettingDetailState> emit) async {
    getScreenIdentifier(event.context);

    /// assigning current userType
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    imgList.clear();
    await getSettingDetails(event.context, settingId);
    emit(const SettingDetailLoadedState());
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      settingId = data[RoutesData.settingId];
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
          DiyStyleListModel item = r.product!;
          if (item.imageSketch.isNotNullNorEmpty) {
            imgList.clear();
            imgList.add(item.imageSketch ?? '');
          }
          productName = item.longDescription ?? '';

          productDetails = ProductDetailsModel(
            suid: item.suid,
            productId: item.suid,
            imageUrl: item.imageSketch,
            subTitle: item.autoDescription,
            originalPrice: item.finalPrice?.toString().setCurrency,
            offerPrice: item.discountPrice?.toString().setCurrency,
            finalPrice: item.discountPrice?.toString().setCurrency,
            commodity: Commodity.diy,
            businessCategoryName: item.businessCategoryName ?? "",
            colorsCode: [item.metalColor1HexCode ?? ""],
            components: item.components,
            productSku: item.styleNumber,
          );
        }
      },
    );
  }
}
