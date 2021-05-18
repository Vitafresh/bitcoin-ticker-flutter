import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkingHelper {
  NetworkingHelper(this.url);

  var url;

  Future getData() async {
    //api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=5e8752a808837d9b64aa7990b885a9f9
    //https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=5e8752a808837d9b64aa7990b885a9f9
    //https://virtserver.swaggerhub.com/okovalyov/wms-termintal/1.0/tasks

    // Another example from https://ayusch.com/how-to-make-an-api-call-in-flutter-rest-api/
    // https://github.com/Ayusch/flutter-api-calls
    // var response = await http.get(
    //     Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
    //     headers: {"Accept": "application/json"});



    // var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
    //   'lat': latitude.toString(),
    //   'lon': longitude.toString(),
    //   'appid': kApiKEY
    // });

    //print('url=$url');  //For debug only

    http.Response response;
    try {
      //response = await http.get(url);

      // response = await http.get(url,
      //     headers: {"Accept":"application/json"});

      response = await http.get(url,
          headers: {"Accept":"application/json; charset=utf-8"});

    } catch (e) {
      print('Exception: ');
      print(e);
      return null;
    }

    if (response.statusCode == 200) {
      //Server responded normally
      // return response.body; //For debugging

      // //For English charset only
      // var data = response.body;
      // return jsonDecode(data);

      //Used to decode cyrillic charset symbols
      var dataBodyBytes = response.bodyBytes;
      var jsonDecoded = jsonDecode(utf8.decode(dataBodyBytes));
      return jsonDecoded;
    } else {
      print('Response code: ' + response.statusCode.toString());
      return null;
    }
  } // getData()
}
