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
}
