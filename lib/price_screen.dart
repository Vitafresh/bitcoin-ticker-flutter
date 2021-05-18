import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'services/api_model.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  // String selectedCrypto = 'BTC';
  double exchangeValueBTC = 0.0;
  double exchangeValueETH = 0.0;
  double exchangeValueLTH = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    getExchangeData('USD');
    super.initState();
  }

  void getExchangeData(String currency) async {
    // WeatherModel weatherModel = WeatherModel();
    //var weatherData = weatherModel.getLocationWeather();
    print('=========== getgetExchangeData ============');
    print('CURRENCY=$currency');
    ApiModel apiModel = ApiModel();
    var exchangeData;

    exchangeData = await apiModel.getExchange('BTC', currency);
    setState(() {
      exchangeValueBTC=exchangeData['rate'];
    });

    exchangeData = await apiModel.getExchange('ETH', currency);
    setState(() {
      exchangeValueETH=exchangeData['rate'];
    });

    exchangeData = await apiModel.getExchange('LTC', currency);
    setState(() {
      exchangeValueLTH=exchangeData['rate'];
    });
  }


  // Dropdown List of currencies for Android interface
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String cur in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(cur),
        value: cur,
      );
      dropdownItems.add(newItem);
    }
    ;

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        print('VALUE=$value');
        setState(() {
          selectedCurrency = value;
        });
        getExchangeData(value);
      },
    );
    // items: [
    //   DropdownMenuItem(
    //     child: Text('USD'),
    //     value: 'USD',
    //   ),
    //   DropdownMenuItem(
    //     child: Text('EUR'),
    //     value: 'EUR',
    //   ),
    // ],
  }

  // Picker List of currencies for iOS interface
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String cur in currenciesList) {
      pickerItems.add(Text(cur));
    }
    ;

    return CupertinoPicker(
      //backgroundColor: Colors.lightBlueAccent,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      //iOS Platform
      return iOSPicker();
    } else if (Platform.isAndroid) {
      //Android Platform
      return androidDropdown();
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $exchangeValueBTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $exchangeValueETH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $exchangeValueLTH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getPicker() : androidDropdown(),
            //child: getPicker(),

            // child: DropdownButton<String>(
            //   value: selectedCurrency,
            //   items: getDropdownItems(),
            //   onChanged: (value) {
            //     print(value);
            //     setState(() {
            //       selectedCurrency = value;
            //     });
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
