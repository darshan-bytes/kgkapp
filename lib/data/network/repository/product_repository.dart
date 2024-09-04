import 'package:kgk/kgk.dart';

class ProductRepository extends ApiService {
  final BuildContext context;

  ProductRepository(this.context);

  //For Getting Product Details by ID
  Future<Either<ErrorResponse, JewelleryDataModel>?> getProductDetailById(String id) async {
    context.setAppLoading(true);
    var response = await getMethod<JewelleryDataModel>(
      ApiClient.productDetails(id),
      query: {ApiKey.view: true},
      withCurrencyHeader: true,
    );
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }
}
