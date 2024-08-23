import 'package:kgk/kgk.dart';

class DiamondRepository extends ApiService {
  final BuildContext context;

  DiamondRepository(this.context);

  //For Getting Diamond Details by ID
  Future<Either<ErrorResponse, DiamondDataModel>?> getDiamondDetailById(String id) async {
    context.setAppLoading(true);
    var response = await getMethod<DiamondDataModel>(
      ApiClient.diamondDetails(id),
      query: {ApiKey.view: true},
      withCurrencyHeader: true,
    );
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }
}
