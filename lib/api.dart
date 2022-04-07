import 'dart:io';
import 'dart:convert' show json, utf8;
import 'dart:async';

class Api {

  final httpClient = HttpClient();
  final url = 'flutter.udacity.com';

  Future<double?> convert(String category, String amount, String fromUnit, String toUnit) async {
    final uri = Uri.https(url, '/$category/convert',
        {'amount': amount, 'from': fromUnit, 'to': toUnit});

    final httpRequest = await httpClient.getUrl(uri);
    final httpResponse = await httpRequest.close();

    if (httpResponse.statusCode != HttpStatus.ok) {
      return null;
    }

    final responseBody = await httpResponse.transform(utf8.decoder).join();
    final jsonResponse = json.decode(responseBody);
    return jsonResponse['conversion'].toDouble();
  }
}