import 'package:http/http.dart' as http;
import 'dart:convert';

class MicroCmsService {

  Future<dynamic> getDeStressListJson(String url, String apiKey) async {
    dynamic jsonData;
    await http.get(url, headers: {"X-API-KEY": apiKey}).then((response) {
      jsonData = json.decode(response.body);
    });
    return jsonData;
  }

}