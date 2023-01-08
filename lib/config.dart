class Config {
  static const String key = 'ck_d8d861d047f9b1e18b59a9fd885f2df06a023a91';
  static const String secret = 'cs_1ccf15d1ac7de1629e3caf615fd227e203a577e4';
  static const String _baseApiUrl = 'https://store.aboidrees.dev/wp-json';

  // Services URLS
  static const String jwtApiUrl = '$_baseApiUrl/jwt-auth/v1';
  static const String wcStoreApiUrl = '$_baseApiUrl/wc/v3';
  static const String ccCartApiUrl = '$_baseApiUrl/cocart/v2/cart';

  // static const String ccStoreApiUrl = '$_baseApiUrl/cocart/v2/store';

  static const String newArrivalTag = '75';
  static const String topSellTag = '76';
  static const String offersTag = '77';
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
