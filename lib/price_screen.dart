import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String url = 'https://rest.coinapi.io/v1/exchangerate/BTC?apikey=A12560FD-CB9F-4D5D-9BCD-15ACA8A5AF28';

  String currency = 'INR';
  var dropDownList = [ for (int i=0; i < currenciesList.length; i++ )
    DropdownMenuItem(
      child: Text(currenciesList[i]),
      value: currenciesList[i],
    ),];

  var rateCurrencyBTC;
  var rateCurrencyETH;
  var rateCurrencyLTC;
  List currencies = [];
  List rates = [] ;


  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response = await http.get(url);
    var internetData = jsonDecode(response.body);
    print(internetData);
    for (int i = 0; i < internetData['rates'].length; i++) {
      rates.add(internetData['rates'][i]["rate"]);
      currencies.add(internetData['rates'][i]["asset_id_quote"]);
    }
    setState(() {
      rateCurrencyBTC = rates[currencies.indexOf(currency)];
      rateCurrencyETH = rates[currencies.indexOf(currency)]/rates[currencies.indexOf('ETH')];
      rateCurrencyLTC = rates[currencies.indexOf(currency)]/rates[currencies.indexOf('LTC')];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
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
                  '1 BTC = $rateCurrencyBTC $currency',
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
                  '1 ETH = $rateCurrencyETH $currency',
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
                  '1 LTC = $rateCurrencyLTC $currency',
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
            child: DropdownButton<String>(
              value: currency,
                items: dropDownList,
              onChanged: (value){
                  setState(() {
                    currency = value;
                    rateCurrencyBTC = rates[currencies.indexOf(currency)];
                    rateCurrencyETH = rates[currencies.indexOf(currency)]/rates[currencies.indexOf('ETH')];
                    rateCurrencyLTC = rates[currencies.indexOf(currency)]/rates[currencies.indexOf('LTC')];

                  });
              },
            ),
          ),

        ],
      ),
    );
  }
}

