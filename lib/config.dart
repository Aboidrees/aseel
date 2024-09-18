class Config {
  static const String key = 'ck_e94e58827d60aad3f610856bc5dfb46b7c90e1e6';
  static const String secret = 'cs_16940a53cbb6e99d0fcb4d554a402693fec653aa';
  static const String _baseApiUrl = 'http://192.168.18.39:8080/wp-json';
  static const String token = "";

  // Services URLS
  static const String jwtApiUrl = '$_baseApiUrl/jwt-auth/v1';
  static const String wcStoreApiUrl = '$_baseApiUrl/wc/v3';
  static const String ccCartApiUrl = '$_baseApiUrl/cocart/v2/cart';

  // static const String ccStoreApiUrl = '$_baseApiUrl/cocart/v2/store';

  static const String newArrivalTag = '31';
  static const String topSellTag = "32";
  static const String offersTag = '30';
}

class EndPoints {
  static const String token = '${Config.jwtApiUrl}/token';
  static const String customers = '${Config.wcStoreApiUrl}/customers';
  static const String products = '${Config.wcStoreApiUrl}/products';
  static const String categories = '${Config.wcStoreApiUrl}/products/categories';

  static String productVariations({required String productId, String variationId = ""}) {
    return '${Config.wcStoreApiUrl}/products/$productId/variations/$variationId';
  }

  // Co-Cart
  static const String getCart = Config.ccCartApiUrl;
  static const String getCartItems = '${Config.ccCartApiUrl}/items';
  static const String addToCart = '${Config.ccCartApiUrl}/add-item';
  static const String cartItemsCount = '${Config.ccCartApiUrl}/count';

  // CRUD operation for one item => GET (fetch) - POST (update) - DELETE (remove) - PUT ()
  static String cartItem(key) => '${Config.ccCartApiUrl}/item/$key';
}
