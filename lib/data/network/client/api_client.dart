/// All api endpoints are defined here
class ApiClient {
  ApiClient._();

  static const String apiBaseUrl = 'http://dev2.spaceo.in/project/laravel_basecode/code/public/api/v1';

  static const String loginUser = '/oauth/login';
  static const String signUpUser = '/oauth/signup';
  static const String userProfile = '/user/profile';
  static const String socialLogin = '/oauth/social-signin';
}
