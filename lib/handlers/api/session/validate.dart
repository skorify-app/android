import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<EmptyAPIResult> validateSession(String session) async {
  final String completeURL = 'https://skorify-api.hosea.dev/session/validate';
  final Map<String, String> headers = {'Session': session};

  try {
    final res = await http.get(Uri.parse(completeURL), headers: headers);

    if (res.statusCode != 200) {
      // Session is invalid (doesn't exist, fake, or deleted)
      return EmptyAPIResult(error: 'INVALID', success: false);
    }

    return EmptyAPIResult(error: '', success: true);
  } catch (err) {
    return EmptyAPIResult(
      error: 'Maaf, terjadi kesalahan pada sistem',
      success: false,
    );
  }
}
