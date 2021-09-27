import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'networking.dart';
import 'refractor.dart';

Networking network = Networking();

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String val = 'USD';
  String currencyBTC;
  String currencyETH;
  String currencyLTC;
  String curBTC = ".......";
  String curETH = ".......";
  String curLTC = ".......";

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String j in currenciesList) {
      pickerItems.add(Text(j));
    }
    CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (val) {
          print(val);
          setState(() {
            val = val;
          });
        },
        children: pickerItems);
  }

  DropdownButton<String> androiddropdown() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (String i in currenciesList) {
      Widget curr = DropdownMenuItem(
        child: Text(i),
        value: i,
      );
      dropdownitems.add(curr);
    }

    return DropdownButton<String>(
        items: dropdownitems,
        value: val,
        onChanged: (value) async {
          await getall(value);
          setState(() {
            val = value;
            curBTC = currencyBTC;
            curETH = currencyETH;
            curLTC = currencyLTC;
          });
        });
  }

  @override
  Future getall(String val) async {
    currencyBTC = await network.getResponse(val, 'BTC');
    currencyETH = await network.getResponse(val, 'ETH');
    currencyLTC = await network.getResponse(val, 'LTC');
  }

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
            child: Column(
              children: [
                CardCurrency(cur: curBTC, val: val, coin: 'BTC'),
                CardCurrency(cur: curETH, val: val, coin: 'ETH'),
                CardCurrency(cur: curLTC, val: val, coin: 'LTC'),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androiddropdown() : iosPicker(),
          ),
        ],
      ),
    );
  }
}
