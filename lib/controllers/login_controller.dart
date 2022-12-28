import 'package:flutter/cupertino.dart';
import '/repositories/user_repository.dart';

class LoginController {
  // final userRepository =
  final state = ValueNotifier<LoginState>(LoginState.initial);
  final userRepository = UserRepository();

  Future login(String username, String password) async {
    state.value = LoginState.loading;
    if (await userRepository.login(username, password)) {
      state.value = LoginState.success;
    } else {
      state.value = LoginState.error;
    }
  }
}

enum LoginState { initial, loading, success, error }
