import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/user.dart';

class UserRepository {
  final url = 'https://479a-138-94-52-230.sa.ngrok.io/api/login';
  var client;

  UserRepository() {
    client = Dio(BaseOptions(
      baseUrl: url,
      connectTimeout: 50000,
      receiveTimeout: 3000,
    ));
  }

  Future<bool> login(username, password) async {
    try {
      final response = await client.post(url, data: {
        'user': username,
        'pass': password,
      });
      if (response.data['token'] != null) {
        final user = User(response.data['user'], response.data['token']);
        return this.setUser(user);
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> setUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString('token', user.token);
      prefs.setString('name', user.name);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final token = prefs.getString('token');
      final name = prefs.getString('name');

      return User(name!, token!);
    } catch (e) {
      return User('', '');
    }
  }

  Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.remove('token');
      prefs.remove('name');

      return true;
    } catch (e) {
      return false;
    }
  }
}
