import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String cryptoCurrency;
  final String currencyRate;
  final String currency;

  CryptoCard(
      {@required this.cryptoCurrency,
      @required this.currencyRate,
      @required this.currency});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoCurrency = $currencyRate $currency',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
      ),
    );
  }
}
