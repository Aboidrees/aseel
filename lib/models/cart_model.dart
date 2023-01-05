import 'dart:convert';

class AddToCartModel {
  String id;
  String quantity;
  Map<String, String>? variation;
  Map<String, String>? itemData;

  AddToCartModel({required this.id, required this.quantity, this.variation, this.itemData});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'id': id.toString(),
      'quantity': quantity.toString(),
    };
    if (variation != null) map['variation'] = variation;
    if (variation != null) map['item_data'] = itemData;
    return map;
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'].toString(),
      quantity: map['quantity'].toString(),
      variation: map['itemData'] as Map<String, String>?,
      itemData: map['item_data'] as Map<String, String>?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCartModel.fromJson(String source) => AddToCartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddToCartModel(id: $id, quantity: $quantity, variation: $variation, itemData: $itemData)';
  }
}

class CartDetailsModel {
  String? id;
  List<CartItemModel>? items;
  Map<String, dynamic>? totals;

  CartDetailsModel({
    this.id,
    this.items,
    this.totals,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'items': items?.map((x) => x.toMap()).toList(),
      'totals': totals as Map<String, dynamic>,
    };
  }

  factory CartDetailsModel.fromMap(Map<String, dynamic> map) {
    return CartDetailsModel(
      id: map['cart_key'].toString(),
      items: List<CartItemModel>.from(map['items'].map((x) => CartItemModel.fromMap(x as Map<String, dynamic>))),
      totals: map['totals'] != null ? Map<String, dynamic>.from((map['totals'] as Map<String, dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartDetailsModel.fromJson(String source) => CartDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CartDetailsModel(id: $id, items: $items, totals: $totals)';
}

class CartItemModel {
  String key;
  int id;
  String name;
  int quantity;
  double price;
  double total;
  String thumbnail;

  CartItemModel({
    required this.key,
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
    required this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_key': key,
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'total': total,
      'thumbnail': thumbnail,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      key: map['item_key'] ?? '',
      id: int.tryParse(map['id'].toString()) ?? 0,
      name: map['name'].toString(),
      quantity: int.tryParse(map['quantity']['value'].toString()) ?? 0,
      price: (double.tryParse(map['price']) ?? 0) / 100,
      total: double.tryParse(map['totals']['total'].toString()) ?? 0.0,
      thumbnail: map['featured_image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) => CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItemModel(id: $id, name: $name, quantity: $quantity, price: $price, total: $total, thumbnail: $thumbnail)';
  }
}

var x = {
  "cart_hash": "81ee0a9f9419fff7532f22c8b17dcf48",
  "cart_key": "1",
  "currency": {
    "currency_code": "QAR",
    "currency_symbol": "ر.ق",
    "currency_minor_unit": 2,
    "currency_decimal_separator": ",",
    "currency_thousand_separator": ".",
    "currency_prefix": "",
    "currency_suffix": " ر.ق"
  },
  "customer": {
    "billing_address": {
      "billing_email": "m.alshf3ee@gmail.com",
      "billing_first_name": "",
      "billing_last_name": "",
      "billing_country": "QA",
      "billing_address_1": "",
      "billing_city": "",
      "billing_state": "",
      "billing_postcode": "",
      "billing_phone": ""
    },
    "shipping_address": {
      "shipping_first_name": "",
      "shipping_last_name": "",
      "shipping_country": "QA",
      "shipping_address_1": "",
      "shipping_city": "",
      "shipping_state": "",
      "shipping_postcode": ""
    }
  },
  "items": [
    {
      "item_key": "006f52e9102a8d3be2fe5614f42ba989",
      "id": 168,
      "name": "فرشة تسريح",
      "title": "فرشة تسريح",
      "price": "250000",
      "quantity": {"value": 3, "min_purchase": 1, "max_purchase": -1},
      "totals": {"subtotal": "7500", "subtotal_tax": 0, "total": 75, "tax": 0},
      "slug": "%d9%81%d8%b1%d8%b4%d8%a9-%d8%aa%d8%b3%d8%b1%d9%8a%d8%ad",
      "meta": {
        "product_type": "simple",
        "sku": "",
        "dimensions": {"length": "", "width": "", "height": "", "unit": "cm"},
        "weight": 0,
        "variation": []
      },
      "backorders": "",
      "cart_item_data": [],
      "featured_image": "https://store.aboidrees.dev/wp-content/uploads/2016/08/dummy-prod-1-300x300.jpg"
    },
    {
      "item_key": "149e9677a5989fd342ae44213df68868",
      "id": 170,
      "name": "Fluro Big Pullover Designers Remix",
      "title": "Fluro Big Pullover Designers Remix",
      "price": "290000",
      "quantity": {"value": 2, "min_purchase": 1, "max_purchase": -1},
      "totals": {"subtotal": "5800", "subtotal_tax": 0, "total": 58, "tax": 0},
      "slug": "fluro-big-pullover-designers-remix",
      "meta": {
        "product_type": "simple",
        "sku": "",
        "dimensions": {"length": "", "width": "", "height": "", "unit": "cm"},
        "weight": 0,
        "variation": []
      },
      "backorders": "",
      "cart_item_data": [],
      "featured_image": "https://store.aboidrees.dev/wp-content/uploads/2016/08/dummy-prod-1-300x300.jpg"
    }
  ],
  "item_count": 5,
  "items_weight": 0,
  "coupons": [],
  "needs_payment": true,
  "needs_shipping": true,
  "shipping": {
    "total_packages": 1,
    "show_package_details": false,
    "has_calculated_shipping": false,
    "packages": {
      "default": {
        "package_name": "Shipping",
        "rates": {
          "free_shipping:1": {
            "key": "free_shipping:1",
            "method_id": "free_shipping",
            "instance_id": 1,
            "label": "شحن مجاني",
            "cost": "0",
            "html": "شحن مجاني",
            "taxes": "",
            "chosen_method": true,
            "meta_data": {"عناصر": "فرشة تسريح &times; 3, Fluro Big Pullover Designers Remix &times; 2", "items": ""}
          }
        },
        "package_details": "",
        "index": 0,
        "chosen_method": "free_shipping:1",
        "formatted_destination": ""
      }
    }
  },
  "fees": [],
  "taxes": [],
  "totals": {
    "subtotal": "13300",
    "subtotal_tax": "0",
    "fee_total": "0",
    "fee_tax": "0",
    "discount_total": "0",
    "discount_tax": "0",
    "shipping_total": "0",
    "shipping_tax": "0",
    "total": "1330000",
    "total_tax": "0"
  },
  "removed_items": [],
  "cross_sells": [],
  "notices": []
};
