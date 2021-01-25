import 'package:http/http.dart' as http;
import 'dart:convert';

class MicroCmsService {

  Future<dynamic> getDeStressJson(String url, String apiKey) async {
    dynamic deStressJson;
    await http.get(url, headers: {"X-API-KEY": apiKey}).then((response) {
      deStressJson = json.decode(response.body);
    });
    return deStressJson;
  }

}