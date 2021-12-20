import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkingService {
  final String url;
  NetworkingService(this.url);

  Future<dynamic> getData() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = response.body;
      print(jsonDecode(data));
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
