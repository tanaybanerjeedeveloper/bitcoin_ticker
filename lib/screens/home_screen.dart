import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
//importing services
import '../services/coin_data_service.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CoinDataService coinDataService = CoinDataService();
  var currencyRate = '?';
  var currency = 'USD';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  //this func gets the data from the api and updates the state with the data.
  void _getData() async {
    var data = await coinDataService.getExchangeRateData(currency);
    setState(() {
      currencyRate = data["rate"].toStringAsFixed(0);
    });
  }

  DropdownButton<String> _getMaterialDropDownButton() {
    return DropdownButton<String>(
      value: currency,
      items: currenciesList.map((item) {
        return DropdownMenuItem(
          child: Text(item),
          value: item,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          currency = value;
        });
        print(currency);
        _getData();
      },
    );
  }

  CupertinoPicker _getCupertinoPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          currency = currenciesList[selectedIndex];
        });
      },
      children: currenciesList.map((item) {
        return Text(item);
      }).toList(),
    );
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
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 BTC = $currencyRate $currency',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150.0,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Platform.isIOS
                    ? _getCupertinoPicker()
                    : _getMaterialDropDownButton(),
              ),
            ),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
