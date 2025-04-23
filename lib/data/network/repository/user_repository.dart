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
  Future<Either<ErrorResponse, CommonResponse>?> getLanguageLabels({bool showLoader = false, String? language}) async {
    if (showLoader) {
      context.setAppLoading(true);
    }
    var response = await getMethod<Map<String, dynamic>>(
      ApiClient.languageLabels,
      headers: {ApiKey.acceptLanguage: language ?? APPStrings.languageEn},
      query: {ApiKey.fromMobile: true},
      withFullResponse: true,
    );
    if (showLoader) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (languageLabels) => Right(languageLabels as CommonResponse));
  }

  //getFrontendLinks
  Future<Either<ErrorResponse, Map<String, dynamic>>?> getFrontendLinks() async {
    var response = await getMethod<Map<String, dynamic>>(ApiClient.frontendLinks);
    return response?.fold((error) => Left(error), (frontendLinks) {
      return Right(frontendLinks);
    });
  }

  // For User SignUp
  Future<Either<ErrorResponse, CommonResponse>?> signUpCustomer(Map<String, dynamic> params) async {
    context.setAppLoading(true);
    var response = await postMethod<Map<String, dynamic>>(ApiClient.signUpCustomer, params, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For QR Code Login
  Future<Either<ErrorResponse, UserResponse>?> verifyQrCodeForAuth(Map<String, dynamic> params) async {
    var response = await postMethod<UserResponse>(ApiClient.verifyQrCodeForAuth, params);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Validate Email
  Future<Either<ErrorResponse, CommonResponse>?> validateEmail(Map<String, dynamic> params) async {
    var response = await postMethod<Map<String, dynamic>>(ApiClient.checkDuplicationEmail, params, withFullResponse: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse>?> validatePhoneNumber({
    required String code,
    required String phoneNumber,
    String? userId,
  }) async {
    var response = await getMethod<Map<String, dynamic>>(
      ApiClient.checkDuplicationPhoneNumber(code, phoneNumber),
      query: userId.isNotNullNorEmpty ? {ApiKey.userId: userId} : null,
      withFullResponse: true,
    );
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, List<CscDetails>>?> getCscMastersList() async {
    context.setAppLoading(true);
    var response = await getMethod<CscDetails>(ApiClient.cscMastersList);
    context.setAppLoading(false);
    return response?.fold((error) => Left(error), (cscMastersList) => Right(cscMastersList as List<CscDetails>));
  }

  Future<Either<ErrorResponse, CommonResponse<UserIdDetails>>?> editUserProfile(
    Map<String, dynamic> params, {
    required List<String> images,
  }) async {
    context.setAppLoading(true);
    var response = await putMultipartMethod<UserIdDetails>(
      ApiClient.editUserProfile,
      params,
      withFullResponse: true,
      files: images.map((e) => ModelMultiPartFile(filePath: e, apiKey: ApiKey.files)).toList(),
    );
    context.setAppLoading(false);
    return response?.fold((ErrorResponse l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse>?> changePasswordApi(Map<String, dynamic> params) async {
    var response = await postMethod<CommonResponse>(ApiClient.changePassword, params, withFullResponse: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For User Logout
  Future<Either<ErrorResponse, CommonResponse>?> logoutUser(Map<String, dynamic> params) async {
    context.setAppLoading(true);
    var response = await postMethod<CommonResponse>(ApiClient.logoutUser, params, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// delete account
  Future<Either<ErrorResponse, CommonResponse>?> deleteAccount() async {
    context.setAppLoading(true);
    var response = await deleteMethod<CommonResponse>(ApiClient.deleteUser, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse>?> resendEmailOtp({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await postMethod<Map<String, dynamic>>(ApiClient.resendEmailOtp, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse<UserResponse>>?> verifyEmailOtp({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await postMethod<UserResponse>(ApiClient.verifyEmailOtp, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse<UserIdDetails>>?> getUserProfile() async {
    var response = await getMethod<UserIdDetails>(ApiClient.getUserProfile, withFullResponse: true);
    return response?.fold((ErrorResponse l) => Left(l), (r) => Right(r));
  }
}
