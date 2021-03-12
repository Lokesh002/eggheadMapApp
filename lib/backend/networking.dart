import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

class Networking {
  String ip = 'http://3.22.225.184/api/sign-in';

  Future postDataByUser(var body) async {
    String fullURL = ip;
    print('fullurl: $fullURL');
    print(body.toString());
    http.Response postResponse = await http.post(fullURL,
        headers: {
          "Content-Type": "application/json",
        },
        body: convert.jsonEncode(body));

    if (postResponse.statusCode == 200) {
      String data = postResponse.body;
      var decodedData = convert.jsonDecode(data);
      print(decodedData);
      return decodedData;
    } else {
      print(postResponse.statusCode);
    }
    return null;
  }
}
