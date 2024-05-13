class HttpOptions {
  static HttpOptions? _instance;

  HttpOptions._internal() {
    _instance = this;
  }

  static get instance => _instance ?? HttpOptions._internal();

  String baseUrl = 'https://api.paghiram.top/Api';
  int connectTimeout = 15000;
  int receiveTimeout = 15000;
  int sendTimeout = 15000;

  get headers {
    Map<String, String> header = {};
    header['Content-type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
    return header;
  }
}
