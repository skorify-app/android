import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skorify/handlers/post_data.dart';

Future<ApiResponse> logout(Object data) async {
  final String completeURL = 'https://skorify-api.hosea.dev/account/logout';
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final String body = jsonEncode(data);

  try {
    final res = await http.delete(
      Uri.parse(completeURL),
      headers: headers,
      body: body,
    );
    final Map<String, dynamic> jsonResponse = jsonDecode(res.body);

    String result;
    bool success = true;

    // If request is accepted
    if (res.statusCode == 200) {
      result = 'Berhasil keluar akun.';
    } else {
      success = false;
      result = jsonResponse['message'];
    }

    // If not accepted
    return ApiResponse(result: result, success: success);
  } catch (err) {
    return ApiResponse(
      result: 'Maaf, terjadi kesalahan pada sistem.',
      success: false,
    );
  }
}
