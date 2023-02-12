import 'package:blog/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskService {
  static Future<Task?> create(data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';
    print("create task data-----------------$data\n");
    var response = await Dio().post('${Constant.BASE_URL}todos',
        data: data,
        options: Options(headers: {"authorization": "Bearer $token"}));
    // print("create task response data-------------${response.data}\n");
    return Task.fromJson(response.data);
  }

  static Future<List<Task>> fetch({queryParameters}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    var response = await Dio().get('${Constant.BASE_URL}todos',
        queryParameters: queryParameters,
        options: Options(headers: {"authorization": "Bearer $token"}));
    // return (response.data['data'] as List).map((x) => taskFromJson(x)).toList();

    return (response.data as List).map((x) => Task.fromJson(x)).toList();
  }

  static Future<Task> get(id, {queryParameters}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    var response = await Dio().get('${Constant.BASE_URL}posts/$id',
        queryParameters: queryParameters,
        options: Options(headers: {"authorization": "Bearer $token"}));

    return Task.fromJson(response.data);
  }

  static Future<Task> patch(id, data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    var response = await Dio().patch('${Constant.BASE_URL}todos/$id',
        data: data,
        options: Options(headers: {"authorization": "Bearer $token"}));
    print("pacth all----------- ${response.data}");
    return Task.fromJson(response.data);
  }

  static Future<Task> delete(id, data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    var response = await Dio().delete('${Constant.BASE_URL}posts/$id',
        options: Options(headers: {"authorization": "Bearer $token"}));

    return Task.fromJson(response.data);
  }
}
