import 'package:kgk/kgk.dart';

class UserRepository extends ApiService {
  final BuildContext context;

  UserRepository(this.context);

  //For User Login
  Future<Either<ErrorResponse, UserResponse>?> loginUser(Map<String, dynamic> params) async {
    context.setAppLoading(true);
    var response = await postMethod<UserResponse>(ApiClient.loginUser, params);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  //For ForgotPassword
  Future<Either<ErrorResponse, CommonResponse>?> forgotPassword(Map<String, dynamic> params) async {
    context.setAppLoading(true);
    var response = await postMethod<ForgotPasswordModel>(ApiClient.forgotPassword, params, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  // For User SignUp with Business Type
  Future<Either<ErrorResponse, List<BusinessType>>?> getBusinessTypes() async {
    context.setAppLoading(true);
    var response = await getMethod<BusinessType>(ApiClient.businessTypes);
    context.setAppLoading(false);
    return response?.fold((error) => Left(error), (businessTypes) => Right(businessTypes as List<BusinessType>));
  }

  // For User SignUp with Office Location
  Future<Either<ErrorResponse, List<OfficeLocation>>?> getOfficeLocations() async {
    context.setAppLoading(true);
    var response = await getMethod<OfficeLocation>(ApiClient.officeLocations);
    context.setAppLoading(false);
    return response?.fold((error) => Left(error), (officeLocations) => Right(officeLocations as List<OfficeLocation>));
  }

  // get Currency List
  Future<Either<ErrorResponse, List<CurrencyListModel>>?> getCurrencies() async {
    var response = await getMethod<CurrencyListModel>(ApiClient.currencies);
    return response?.fold((error) => Left(error), (currencies) => Right(currencies as List<CurrencyListModel>));
  }

  // get Language Labels
  Future<Either<ErrorResponse, CommonResponse>?> getLanguageLabels({bool showLoader = false}) async {
    if (showLoader) {
      context.setAppLoading(true);
    }
    var response = await getMethod<Map<String, dynamic>>(ApiClient.languageLabels, withFullResponse: true);
    if (showLoader) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (languageLabels) => Right(languageLabels as CommonResponse));
  }

  // For User SignUp
  Future<Either<ErrorResponse, CommonResponse>?> signUpCustomer(Map<String, dynamic> params) async {
    context.setAppLoading(true);
    var response = await postMethod<CommonResponse>(ApiClient.signUpCustomer, params, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }
}
