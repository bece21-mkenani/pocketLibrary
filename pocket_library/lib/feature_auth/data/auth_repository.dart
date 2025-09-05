import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pocket_library/constants/endpoints.dart';
import 'package:pocket_library/constants/strings.dart';

class AuthRepository {
  final _client = http.Client();
  final _headers = {'Content-Type': 'application/json'};

  Future<Map<String, dynamic>> register({
    required String fullName,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(
          '${AppStrings.baseUrl}${Endpoints.auth}/${Endpoints.register}',
        ),
        headers: _headers,
        body: jsonEncode({
          'fullName': fullName,
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        throw Exception('${AppStrings.serverError}: ${response.body}');
      }
    } catch (e) {
      throw Exception('${AppStrings.unExpectedError}.: ${e.toString()}');
    }
  }


  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('${AppStrings.baseUrl}${Endpoints.auth}/${Endpoints.verifyOtp}'),
        headers: _headers,
        body: jsonEncode({
          'phone': phone,
          'otp': otp,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Server error: ${response.body}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred.: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('${AppStrings.baseUrl}${Endpoints.auth}/${Endpoints.login}'),
        headers: _headers,
        body: jsonEncode({'phone': phone, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('${AppStrings.serverError}: ${response.body}');
      }
    } catch (e) {
      throw Exception('${AppStrings.unExpectedError}.: ${e.toString()}');
    }
  }
}
