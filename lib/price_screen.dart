import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //TODO 6: Update the default currency to AUD, the first item in the currencyList.
  String selectedCurrency = 'USD';
  String cryptoType = 'BTC';

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownMenu = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var newItem = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );

      //OR
      // for (String currency in currenciesList) {
      // var newItem = DropdownMenuItem(
      //   child: Text(currency),
      //   value: currency,
      // );

      dropDownMenu.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownMenu,
      //[
      //   DropdownMenuItem(
      //     child: Text('USD'),
      //     value: 'USD',
      //   ),
      //   DropdownMenuItem(
      //     child: Text('EUR'),
      //     value: 'EUR',
      //   ),
      //   DropdownMenuItem(
      //     child: Text('GBP'),
      //     value: 'GBP',
      //   ),
      // ],
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value!;
            getData(); //Call getData() when the dropdown changes.
          },
        );
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> currencyItems = [];
    for (String currency in currenciesList) {
      currencyItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        //TODO 1: Save the selected currency to the property selectedCurrency
        //TODO 2: Call getData() when the picker/dropdown changes.
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: currencyItems,
    );
  }

  String bitcoinValue = '?';

  void getData() async {
    try {
      double data = await CoinData().getCoinData(selectedCurrency, cryptoType);
      setState(() {
        //the await on bitcoinValue is to wait for the data
        bitcoinValue = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

//TODO: Create a method here called getData() to get the coin data from coin_data.dart
  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget getDeviceType() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropDown();
    } else {
      return SizedBox();
    }
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      //TODO: Update the Text Widget with the live bitcoin data here.
                      //TODO 5: Update the currency name depending on the selectedCurrency.
                      '1 $cryptoType = $bitcoinValue $selectedCurrency',
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
                padding: EdgeInsets.fromLTRB(18.0, 10, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      //TODO: Update the Text Widget with the live bitcoin data here.
                      //TODO 5: Update the currency name depending on the selectedCurrency.
                      '1 $cryptoType = $bitcoinValue $selectedCurrency',
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
                padding: EdgeInsets.fromLTRB(18.0, 10, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      //TODO: Update the Text Widget with the live bitcoin data here.
                      //TODO 5: Update the currency name depending on the selectedCurrency.
                      '1 $cryptoType = $bitcoinValue $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDeviceType(),
          ),
        ],
      ),
    );
  }
}
