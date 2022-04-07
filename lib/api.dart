import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:developer';
import 'dart:io';

const apiCategory = {
  'name': 'Currency',
  'route': 'currency',
};

class Api {
  final _httpClient = HttpClient();
  final _url = 'flutter.udacity.com';

  Future<List?> getUnits(String? category) async {
    final uri = Uri.https(_url, '/$category');
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['units'] == null) {
      log('Error retrieving units.');
      return null;
    }
    return jsonResponse['units'];
  }

  Future<double?> convert(String? category, String amount, String? fromUnit, String? toUnit) async {
    final uri = Uri.https(_url, '/$category/convert', {'amount': amount, 'from': fromUnit, 'to': toUnit});

    try {
      final jsonResponse = await _getJson(uri);

      try {
        return jsonResponse?['conversion'].toDouble();
      } on Exception catch (e) {
        log('Error: $e $jsonResponse["message"]');
        return null;
      }
    } on Exception catch (e) {
      log('Error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }
      // The response is sent as a Stream of bytes that we need to convert to a
      // `String`.
      final responseBody = await httpResponse.transform(utf8.decoder).join();
      log('responseBody: $responseBody');
      // Finally, the string is parsed into a JSON object.
      return json.decode(responseBody);
    } on Exception catch (e) {
      log('$e');
      return null;
    }
  }
}
