import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/services/networking.dart';

class ApiModel{
  //  ======== URL format Example  ==================================================
  // https://rest.coinapi.io/v1/exchangerate/BTC/USD
  // var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
  //   'q': 'Kherson',
  //   'units': 'metric',
  //   'appid': '5e8752a808837d9b64aa7990b885a9f9' //ApiKEY to api.openweathermap.org
  // });
  //  ======== URL format Example (end) =============================================

  static const kApiKEY='E2347CD1-5146-4C6F-B4B6-9A78C2145468';

  // ======== Testing server ========================
  // https://rest.coinapi.io/v1/exchangerate/BTC/USD
  static const kServerDomainUrl='rest.coinapi.io';
  static const kUrlMainPath = '/v1/exchangerate';
  // ======== Testing server ========================

  Future<dynamic>getServerData(var url) async{
    // Get JSON Data from server
    NetworkingHelper netHelper = NetworkingHelper(url);
    var serverData = await netHelper.getData();
    print(serverData);
    return serverData;
  }



  Future<dynamic>getExchange(String crypto, String currency) async {
    //https://virtserver.swaggerhub.com/okovalyov/wms-termintal/1.0/tasks
    print('=========== getTasksList ============');
    String apiName='/$crypto/$currency';
    var url = Uri.https(kServerDomainUrl, '$kUrlMainPath$apiName', {
      'apikey' : kApiKEY,
    }
    );
    print('url=$url');
    return await getServerData(url);
  }


}