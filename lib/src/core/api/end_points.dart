class EndPoints {
  EndPoints._();
  // ============== Base URL ===================
  static const String baseUrl = "https://todo.iraqsapp.com";

  // ============== Auth ===================
  static const String signUp = "/auth/register";
  static const String signIn = "/auth/login";
  static const String refreshToken = "/auth/refresh-token";
  static const String signOut = "/auth/logout";

  // ============== Task ===================
  static const String createTask = "/todos";
}
