import 'package:dio/dio.dart';
import '../../utils/constants.dart';
import '../models/AuthenticatedUser.dart';

class UserService {
  static Future<AuthenticatedUser> authentication(data) async {
    var result =
        await Dio().post(Constant.BASE_URL + 'authentication', data: data);
    return AuthenticatedUser.fromJson(result.data);
  }

  static Future<User> create(data) async {
    var response = await Dio().post(Constant.BASE_URL + 'users', data: data);
    print(data);
    return User.fromJson(response.data);
  }
}
