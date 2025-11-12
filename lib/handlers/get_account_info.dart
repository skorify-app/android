import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiAccountResponse {
  final Map<String, dynamic> result;
  final bool success;

  ApiAccountResponse({required this.result, required this.success});
}

Future<ApiAccountResponse> getAccountInfo(String session) async {
  final String completeURL = 'https://skorify-api.hosea.dev/account/info';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Session': session,
  };

  try {
    final res = await http.get(Uri.parse(completeURL), headers: headers);

    final Map<String, dynamic> jsonResponse = jsonDecode(res.body);

    return ApiAccountResponse(result: jsonResponse['account'], success: true);
  } catch (err) {
    final Map<String, dynamic> error = {
      'message': 'Maaf, terjadi kesalahan pada sistem',
    };
    return ApiAccountResponse(result: error, success: false);
  }
}
