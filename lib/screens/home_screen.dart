import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
//importing services
import '../services/coin_data_service.dart';
//importing widgets
import '../widgets/crypto_card.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CoinDataService coinDataService = CoinDataService();
  // var selectedCurrency = 'AUD';
  var currency = 'USD';
  var isWaiting = true;
  Map<String, dynamic> mapOfResults = {};

  @override
  void initState() {
    super.initState();
    _getData();
  }

  //this func gets the data from the api and updates the state with the data.
  void _getData() async {
    isWaiting = true;
    try {
      var data = await coinDataService.getExchangeRateData(currency);
      isWaiting = false;
      setState(() {
        mapOfResults = data;
      });
    } catch (e) {
      print('error $e');
    }
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

  // Column _getCryptoCards() {
  //   List<CryptoCard> cryptoCards = [];
  //   cryptoList.map((e) => null)
  // }

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
              child: Column(
                children: cryptoList.map((item) {
                  return CryptoCard(
                      cryptoCurrency: item,
                      currencyRate: (isWaiting) ? '?' : mapOfResults[item],
                      currency: currency);
                }).toList(),
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
