import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<StringAPIResult> logout(String sessionId) async {
  final String completeURL = 'https://skorify-api.hosea.dev/account/logout';
  final Map<String, String> headers = {'Session': sessionId};

  try {
    final res = await http.delete(Uri.parse(completeURL), headers: headers);

    String result;
    bool success = true;

    // If request is accepted
    if (res.statusCode == 204) {
      result = 'Berhasil keluar akun.';
    } else {
      success = false;
      result = 'Maaf, terjadi kesalahan pada sistem.';
    }

    // If not accepted
    return StringAPIResult(result: result, success: success);
  } catch (err) {
    return StringAPIResult(
      result: 'Maaf, terjadi kesalahan pada sistem.',
      success: false,
    );
  }
}
