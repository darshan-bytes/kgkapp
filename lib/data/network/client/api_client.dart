/// All api endpoints are defined here
class ApiClient {
  ApiClient._();

  static const String apiBaseUrl = 'https://api.kgk.magnetoinfotech.com/v1';

  static const String loginUser = '$apiBaseUrl/auth/front-sign-in';
  static const String signUpUser = '$apiBaseUrl/oauth/signup';
  static const String userProfile = '$apiBaseUrl/user/profile';
  static const String socialLogin = '$apiBaseUrl/oauth/social-signin';
}
