import 'package:aseel/models/product.dart';
import 'package:aseel/pages/base.dart';
import 'package:aseel/widgets/widget_product_card.dart';
import 'package:flutter/material.dart';

class ProductsMenuPage extends BasePage {
  final int categoryId;
  const ProductsMenuPage({super.key, required this.categoryId});

  @override
  BasePageState createState() => _ProductsMenuPageState();
}

class _ProductsMenuPageState extends BasePageState<ProductsMenuPage> {
  @override
  Widget pageUI() {
    var product = Product.fromMap(rawProd);
    print(product);
    return Container(
      child: ProductCard(product: product),
    );
  }
}

var rawProd = {
  "id": 168,
  "name": "فرشة تسريح",
  "slug": "%d9%81%d8%b1%d8%b4%d8%a9-%d8%aa%d8%b3%d8%b1%d9%8a%d8%ad",
  "permalink": "https://store.aboidrees.dev/product/%d9%81%d8%b1%d8%b4%d8%a9-%d8%aa%d8%b3%d8%b1%d9%8a%d8%ad/",
  "date_created": "2014-08-10T10:06:55",
  "date_created_gmt": "2014-08-10T07:06:55",
  "date_modified": "2023-01-01T22:38:46",
  "date_modified_gmt": "2023-01-01T19:38:46",
  "type": "simple",
  "status": "publish",
  "featured": false,
  "catalog_visibility": "visible",
  "description":
      "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum iaculis massa nec velit commodo lobortis. Quisque diam lacus, tincidunt vitae eros porta, sagittis rhoncus est. Quisque sed justo a erat lobortis gravida. Suspendisse nibh neque, hendrerit vel nisi at, ultrices adipiscing justo. Nunc ullamcorper molestie felis at pharetra.</p>\n<p>Osaka Entry Tee NOK 399, Superdry - NELLY.COM</p>\n<p>Marfa authentic High Life veniam Carles nostrud, pickled meggings assumenda fingerstache keffiyeh Pinterest.</p>\n<p> </p>\n",
  "short_description":
      "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum iaculis massa nec velit commodo lobortis. Quisque diam lacus, tincidunt vitae eros porta, sagittis rhoncus est. Quisque sed justo a erat lobortis gravida.</p>\n",
  "sku": "",
  "price": "25",
  "regular_price": "29",
  "sale_price": "25",
  "date_on_sale_from": null,
  "date_on_sale_from_gmt": null,
  "date_on_sale_to": null,
  "date_on_sale_to_gmt": null,
  "on_sale": true,
  "purchasable": true,
  "total_sales": 156,
  "virtual": false,
  "downloadable": false,
  "downloads": [],
  "download_limit": -1,
  "download_expiry": -1,
  "external_url": "",
  "button_text": "",
  "tax_status": "taxable",
  "tax_class": "",
  "manage_stock": false,
  "stock_quantity": null,
  "backorders": "no",
  "backorders_allowed": false,
  "backordered": false,
  "low_stock_amount": null,
  "sold_individually": false,
  "weight": "",
  "dimensions": {"length": "", "width": "", "height": ""},
  "shipping_required": true,
  "shipping_taxable": true,
  "shipping_class": "",
  "shipping_class_id": 0,
  "reviews_allowed": true,
  "average_rating": "4.00",
  "rating_count": 4,
  "upsell_ids": [],
  "cross_sell_ids": [],
  "parent_id": 0,
  "purchase_note": "",
  "categories": [
    {"id": 74, "name": "أدوات العناية", "slug": "horse-care-tools"}
  ],
  "tags": [
    {"id": 77, "name": "العروض", "slug": "offers"}
  ],
  "images": [
    {
      "id": 20,
      "date_created": "2016-08-09T16:43:25",
      "date_created_gmt": "2016-08-09T13:43:25",
      "date_modified": "2016-08-09T16:43:25",
      "date_modified_gmt": "2016-08-09T13:43:25",
      "src": "https://store.aboidrees.dev/wp-content/uploads/2016/08/dummy-prod-1.jpg",
      "name": "Product Dummy Image",
      "alt": ""
    },
    {
      "id": 20,
      "date_created": "2016-08-09T16:43:25",
      "date_created_gmt": "2016-08-09T13:43:25",
      "date_modified": "2016-08-09T16:43:25",
      "date_modified_gmt": "2016-08-09T13:43:25",
      "src": "https://store.aboidrees.dev/wp-content/uploads/2016/08/dummy-prod-1.jpg",
      "name": "Product Dummy Image",
      "alt": ""
    }
  ],
  "attributes": [],
  "default_attributes": [],
  "variations": [],
  "grouped_products": [],
  "menu_order": 0,
  "price_html":
      "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><bdi>29,00&nbsp;<span class=\"woocommerce-Price-currencySymbol\">&#x631;.&#x642;</span></bdi></span></del> <ins><span class=\"woocommerce-Price-amount amount\"><bdi>25,00&nbsp;<span class=\"woocommerce-Price-currencySymbol\">&#x631;.&#x642;</span></bdi></span></ins>",
  "related_ids": [172, 169, 170, 171, 175],
  "meta_data": [
    {
      "id": 265,
      "key": "_vc_post_settings",
      "value": {"vc_grid_id": []}
    },
    {"id": 291, "key": "_min_variation_price", "value": "39"},
    {"id": 292, "key": "_max_variation_price", "value": "39"},
    {"id": 293, "key": "_min_variation_regular_price", "value": "39"},
    {"id": 294, "key": "_max_variation_regular_price", "value": "39"},
    {"id": 295, "key": "_min_variation_sale_price", "value": ""},
    {"id": 296, "key": "_max_variation_sale_price", "value": ""},
    {"id": 298, "key": "_dp_original", "value": "389"},
    {
      "id": 303,
      "key": "wc_productdata_options",
      "value": [
        {"_bubble_new": "", "_bubble_text": "", "_custom_tab_title": "", "_custom_tab": "", "_product_video": "", "_product_video_size": ""}
      ]
    }
  ],
  "stock_status": "instock",
  "has_options": false,
  "_links": {
    "self": [
      {"href": "https://store.aboidrees.dev/wp-json/wc/v3/products/168"}
    ],
    "collection": [
      {"href": "https://store.aboidrees.dev/wp-json/wc/v3/products"}
    ]
  }
};
