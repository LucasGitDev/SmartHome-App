import 'package:dio/dio.dart';
import '/repositories/user_repository.dart';

class SystemRepository {
  final String ledUrl = 'https://479a-138-94-52-230.sa.ngrok.io/api/led';
  final String buttonUrl =
      'https://479a-138-94-52-230.sa.ngrok.io/api/button/status';

  String token = '';

  var userRespository = UserRepository();

  SystemRepository() {
    userRespository.getUser().then((value) {
      token = value.token;
    });
  }

  Future<bool> setLed(status) async {
    try {
      if (token == '') {
        token = (await userRespository.getUser()).token;
      }
      final response = await Dio().post(ledUrl,
          data: {
            'value': status ? 1 : 0,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.data['value'] != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getLed() async {
    try {
      if (token == '') {
        token = (await userRespository.getUser()).token;
      }
      final response = await Dio().get(ledUrl + '/status',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.data['value'] != null) {
        return response.data['value'] == 1;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getButton() async {
    try {
      if (token == '') {
        token = (await userRespository.getUser()).token;
      }
      final response = await Dio().get(buttonUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.data['value'] != null) {
        return response.data['value'] == 1 ? true : false;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
