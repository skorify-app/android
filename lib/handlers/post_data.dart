import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiResponse {
  final String result; // Bisa berupa error message atau session id
  final bool success;

  ApiResponse({required this.result, required this.success});
}

Future<ApiResponse> postData(String path, Object data) async {
  final String completeURL = 'https://skorify-api.hosea.dev/$path';
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final String body = jsonEncode(data);

  try {
    final res = await http.post(
      Uri.parse(completeURL),
      headers: headers,
      body: body,
    );
    final Map<String, dynamic> jsonResponse = jsonDecode(res.body);

    String result;
    bool success = true;

    // If request is accepted
    if (res.statusCode == 200) {
      result = jsonResponse['sessionId'];
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
