import './networking_service.dart';

const apiKey = 'B1821EB3-68C1-417F-9B1A-166066AA99B1';

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

class CoinDataService {
  Future<dynamic> getExchangeRateData(String currency) async {
    NetworkingService networkingService = NetworkingService(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apiKey=$apiKey');
    var result = await networkingService.getData();
    return result;
  }
}
