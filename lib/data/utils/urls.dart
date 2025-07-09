class Urls{
  static String baseUrl = 'http://35.73.30.144:2005/api/v1' ;
  static String registerUrl = '$baseUrl/Registration' ;
  static String loginUrl = '$baseUrl/Login' ;
  static String forgotPasswordEmailVerifyUrl(String email) => '$baseUrl/RecoverVerifyEmail/$email' ;
  static String forgotPasswordEmailVerifyPin(String email, String pin) => '$baseUrl/RecoverVerifyOtp/$email/$pin' ;
  static String resetPassword = '$baseUrl/RecoverResetPassword' ;
  static String updateProfile = '$baseUrl/ProfileUpdate' ;



  static String createTask = '$baseUrl/createTask' ;

}