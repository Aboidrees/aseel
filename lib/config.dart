class Config {
  static const String _baseApiUrl = "https://store.aboidrees.dev/wp-json";
  static const String key = "ck_d8d861d047f9b1e18b59a9fd885f2df06a023a91";
  static const String secret = "cs_1ccf15d1ac7de1629e3caf615fd227e203a577e4";

  // Services URLS
  static const String storeApiUrl = "$_baseApiUrl/wc/v3/";
  static const String tokenUrl = "$_baseApiUrl/jwt-auth/v1/token";

  static const String newArrivalTag = '75';
  static const String topSellTag = '76';
  static const String offersTag = '77';

  // static String customerURL = "customers";
}

class EndPoints {
  static const String customers = "customers";
  static const String categories = 'products/categories';
  static const String products = 'products';
}
