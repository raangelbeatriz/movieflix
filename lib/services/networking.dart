import 'package:http/http.dart'
    as http; //I gave this package the name http so now I can use anything that is by using the word http
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      //Response response = await Dio().get('url');
      if (response.statusCode == 200) {
        //String data = response.body;
        //return jsonDecode(data);
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
