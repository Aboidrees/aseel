import 'package:woocommerce_client/woocommerce_client.dart';

extension CalculateDiscount on Product {
  int calculateDiscount() {
    double regularPrice = double.tryParse(this.regularPrice ?? '0') ?? 0;
    double salePrice = double.tryParse(this.salePrice ?? '0') ?? regularPrice;
    double discount = regularPrice - salePrice;
    if (discount <= 0.0) return 0;

    double discountPercent = (discount / regularPrice) * 100;
    return discountPercent.round();
  }
}
