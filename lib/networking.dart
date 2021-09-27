import 'package:http/http.dart' as http;
import 'dart:convert';

const String url = 'https://rest.coinapi.io/v1/exchangerate/';
const String apikey = 'EAA6DD72-E5B6-4903-99D2-20E6E8BA7059';

class Networking {
  Future<String> getResponse(String currency, String coin) async {
    http.Response response =
        await http.get('${url}$coin/$currency?apikey=$apikey');
    String val = response.body;
    var price = jsonDecode(val)["rate"];
    int money = price.toInt();
    return money.toString();
  }
}
