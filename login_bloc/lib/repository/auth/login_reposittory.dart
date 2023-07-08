class LoginRepository {
  Future login() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Login failed');
  }
}
