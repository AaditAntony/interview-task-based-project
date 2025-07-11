import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login_model.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<LoginModel>>(
      (ref) => LoginViewModel(),
    );

class LoginViewModel extends StateNotifier<AsyncValue<LoginModel>> {
  LoginViewModel() : super(AsyncValue.data(LoginModel(token: '')));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    const url = 'https://reqres.in/api/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'reqres-free-v1',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final loginModel = LoginModel.fromJson(data);

        // Store token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', loginModel.token);

        state = AsyncValue.data(loginModel);
      } else {
        state = AsyncValue.error('Login failed', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error('Something went wrong: $e', StackTrace.current);
    }
  }
}
