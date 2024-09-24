//2. Import the required packages.
//import 'dart:ffi';
//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'A8D67819-0468-4257-BDC2-DA9D18121E5D';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  //TODO 3: Update getCoinData to take the selectedCurrency as an input.
  //int rate = 0;
  //TODO: Create your getCoinData() method here.

  Future getCoinData(String currencyType, String cryptoType) async {
    //TODO 4: Update the URL to use the selectedCurrency input.

    http.Response response = await http
        .get(Uri.parse('$coinAPIURL/$cryptoType/$currencyType?apikey=$apiKey'));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'prblem with the request';
    }
  }
}
