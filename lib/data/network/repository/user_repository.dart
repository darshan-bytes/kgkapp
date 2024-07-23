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

  /// Fetches a list of business types from the server.
  ///
  /// This method sends a GET request to retrieve the business types available.
  /// It shows a loading indicator while the request is in progress by setting
  /// the application's loading state to true. Once the request is complete,
  /// it hides the loading indicator by setting the loading state to false.
  ///
  /// The response is wrapped in an `Either` type to handle both success and failure cases.
  /// On success, it returns a `Right` containing a list of `BusinessType`.
  /// On failure, it returns a `Left` containing an `ErrorResponse`.
  ///
  /// Returns:
  ///   A `Future` that resolves to an `Either<ErrorResponse, List<BusinessType>>?`.
  ///   It may return null if the response from the server is null.
  Future<Either<ErrorResponse, List<BusinessType>>?> getBusinessTypes() async {
    context.setAppLoading(true);
    var response = await getMethod<BusinessType>(ApiClient.businessTypes);
    context.setAppLoading(false);
    return response?.fold((error) => Left(error), (businessTypes) => Right(businessTypes as List<BusinessType>));
  }

  /// Fetches a list of office locations from the server.
  ///
  /// This method sends a GET request to retrieve the office locations available.
  /// It shows a loading indicator while the request is in progress by setting
  /// the application's loading state to true. Once the request is complete,
  /// it hides the loading indicator by setting the loading state to false.
  ///
  /// The response is wrapped in an `Either` type to handle both success and failure cases.
  /// On success, it returns a `Right` containing a list of `OfficeLocation`.
  /// On failure, it returns a `Left` containing an `ErrorResponse`.
  ///
  /// Returns:
  ///   A `Future` that resolves to an `Either<ErrorResponse, List<OfficeLocation>>?`.
  ///   It may return null if the response from the server is null.
  Future<Either<ErrorResponse, List<OfficeLocation>>?> getOfficeLocations() async {
    context.setAppLoading(true);
    var response = await getMethod<OfficeLocation>(ApiClient.officeLocations);
    context.setAppLoading(false);
    return response?.fold((error) => Left(error), (officeLocations) => Right(officeLocations as List<OfficeLocation>));
  }
}
