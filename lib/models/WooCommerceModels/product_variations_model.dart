// To parse this JSON data, do
//
//     final productVariationsModel = productVariationsModelFromJson(jsonString);

import 'dart:convert';

List<ProductVariationsModel?>? productVariationsModelFromJson(String str) =>
    jsonDecode(str) == null
        ? []
        : List<ProductVariationsModel?>.from(
            json.decode(str)!.map((x) => ProductVariationsModel.fromJson(x)));

String productVariationsModelToJson(List<ProductVariationsModel?>? data) =>
    jsonEncode(
        data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class ProductVariationsModel {
  ProductVariationsModel({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.description,
    this.permalink,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.onSale,
    this.status,
    this.purchasable,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.stockStatus,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.lowStockAmount,
    this.weight,
    this.dimensions,
    this.shippingClass,
    this.shippingClassId,
    this.image,
    this.attributes,
    this.menuOrder,
    this.metaData,
    this.links,
  });

  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? description;
  String? permalink;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  bool? onSale;
  Status? status;
  bool? purchasable;
  bool? virtual;
  bool? downloadable;
  List<dynamic>? downloads;
  int? downloadLimit;
  int? downloadExpiry;
  TaxStatus? taxStatus;
  String? taxClass;
  bool? manageStock;
  int? stockQuantity;
  StockStatus? stockStatus;
  Backorders? backorders;
  bool? backordersAllowed;
  bool? backordered;
  dynamic lowStockAmount;
  String? weight;
  Dimensions? dimensions;
  String? shippingClass;
  int? shippingClassId;
  ImageVar? image;
  List<Attributez?>? attributes;
  int? menuOrder;
  List<MetaDatum?>? metaData;
  Links? links;

  factory ProductVariationsModel.fromJson(Map<String, dynamic> json) =>
      ProductVariationsModel(
        id: json["id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        description: json["description"],
        permalink: json["permalink"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
        dateOnSaleTo: json["date_on_sale_to"],
        dateOnSaleToGmt: json["date_on_sale_to_gmt"],
        onSale: json["on_sale"],
        status: statusValues.map[json["status"]],
        purchasable: json["purchasable"],
        virtual: json["virtual"],
        downloadable: json["downloadable"],
        downloads: json["downloads"] == null
            ? []
            : List<dynamic>.from(json["downloads"]!.map((x) => x)),
        downloadLimit: json["download_limit"],
        downloadExpiry: json["download_expiry"],
        taxStatus: taxStatusValues.map[json["tax_status"]],
        taxClass: json["tax_class"],
        manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        stockStatus: stockStatusValues.map[json["stock_status"]],
        backorders: backordersValues.map[json["backorders"]],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        lowStockAmount: json["low_stock_amount"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        image: ImageVar.fromJson(json["image"]),
        attributes: json["attributes"] == null
            ? []
            : List<Attributez?>.from(
                json["attributes"]!.map((x) => Attributez.fromJson(x))),
        menuOrder: json["menu_order"],
        metaData: json["meta_data"] == null
            ? []
            : List<MetaDatum?>.from(
                json["meta_data"]!.map((x) => MetaDatum.fromJson(x))),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "description": description,
        "permalink": permalink,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "date_on_sale_from": dateOnSaleFrom,
        "date_on_sale_from_gmt": dateOnSaleFromGmt,
        "date_on_sale_to": dateOnSaleTo,
        "date_on_sale_to_gmt": dateOnSaleToGmt,
        "on_sale": onSale,
        "status": statusValues.reverse![status],
        "purchasable": purchasable,
        "virtual": virtual,
        "downloadable": downloadable,
        "downloads": downloads == null
            ? []
            : List<dynamic>.from(downloads!.map((x) => x)),
        "download_limit": downloadLimit,
        "download_expiry": downloadExpiry,
        "tax_status": taxStatusValues.reverse![taxStatus],
        "tax_class": taxClass,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "stock_status": stockStatusValues.reverse![stockStatus],
        "backorders": backordersValues.reverse![backorders],
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "low_stock_amount": lowStockAmount,
        "weight": weight,
        "dimensions": dimensions!.toJson(),
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "image": image!.toJson(),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x!.toJson())),
        "menu_order": menuOrder,
        "meta_data": metaData == null
            ? []
            : List<dynamic>.from(metaData!.map((x) => x!.toJson())),
        "_links": links!.toJson(),
      };
}

class Attributez {
  Attributez({
    this.id,
    this.name,
    this.option,
  });

  int? id;
  AttributeName? name;
  String? option;

  factory Attributez.fromJson(Map<String, dynamic> json) => Attributez(
        id: json["id"],
        name: attributeNameValues.map[json["name"]],
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": attributeNameValues.reverse![name],
        "option": option,
      };
}

enum AttributeName { colore, memoria, condizione }

final attributeNameValues = EnumValues({
  "Colore": AttributeName.colore,
  "Condizione": AttributeName.condizione,
  "Memoria": AttributeName.memoria
});

enum Backorders { no }

final backordersValues = EnumValues({"no": Backorders.no});

class Dimensions {
  Dimensions({
    this.length,
    this.width,
    this.height,
  });

  String? length;
  String? width;
  String? height;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "width": width,
        "height": height,
      };
}

class ImageVar {
  ImageVar({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
  });

  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? src;
  ImageName? name;
  Alt? alt;

  factory ImageVar.fromJson(Map<String, dynamic> json) => ImageVar(
        id: json["id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        src: json["src"],
        name: imageNameValues.map[json["name"]],
        alt: altValues.map[json["alt"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "src": src,
        "name": imageNameValues.reverse![name],
        "alt": altValues.reverse![alt],
      };
}

enum Alt { iPhoneSE2020 }

final altValues = EnumValues({"iPhone SE 2020": Alt.iPhoneSE2020});

enum ImageName { iPhoneSE2020Rosso600, iPhoneSE2020Bianco600 }

final imageNameValues = EnumValues({
  "iphone-se-2020-bianco600": ImageName.iPhoneSE2020Bianco600,
  "iphone-se-2020-rosso-600": ImageName.iPhoneSE2020Rosso600
});

class Links {
  Links({
    this.self,
    this.collection,
    this.up,
  });

  List<Collection?>? self;
  List<Collection?>? collection;
  List<Collection?>? up;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? []
            : List<Collection?>.from(
                json["self"]!.map((x) => Collection.fromJson(x))),
        collection: json["collection"] == null
            ? []
            : List<Collection?>.from(
                json["collection"]!.map((x) => Collection.fromJson(x))),
        up: json["up"] == null
            ? []
            : List<Collection?>.from(
                json["up"]!.map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? []
            : List<dynamic>.from(self!.map((x) => x!.toJson())),
        "collection": collection == null
            ? []
            : List<dynamic>.from(collection!.map((x) => x!.toJson())),
        "up": up == null ? [] : List<dynamic>.from(up!.map((x) => x!.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class MetaDatum {
  MetaDatum({
    this.id,
    this.key,
    this.value,
  });

  int? id;
  Key? key;
  dynamic value;

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        id: json["id"],
        key: keyValues.map[json["key"]],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": keyValues.reverse![key],
        "value": value,
      };
}

enum Key {
  blocksyPostMetaOptions,
  wcGlaMcStatus,
  wcGlaSyncStatus,
  algEan,
  wcGlaSynced,
  wcGlaGoogleIds,
  wcGlaGTIN,
  stockAt66,
  stockAt67,
  sedi
}

final keyValues = EnumValues({
  "_alg_ean": Key.algEan,
  "blocksy_post_meta_options": Key.blocksyPostMetaOptions,
  "_stock_at_66": Key.stockAt66,
  "_stock_at_67": Key.stockAt67,
  "_wc_gla_google_ids": Key.wcGlaGoogleIds,
  "_wc_gla_gtin": Key.wcGlaGTIN,
  "_wc_gla_mc_status": Key.wcGlaMcStatus,
  "_wc_gla_synced_at": Key.wcGlaSynced,
  "_wc_gla_sync_status": Key.wcGlaSyncStatus,
  "sedi": Key.sedi
});

class ValueElementz {
  ValueElementz({
    required this.sede,
    required this.quantita,
  });

  String sede;
  int quantita;

  factory ValueElementz.fromJson(Map<String, dynamic> json) => ValueElementz(
        sede: json["sede"],
        quantita: json["quantita"],
      );

  Map<String, dynamic> toJson() => {
        "sede": sede,
        "quantita": quantita,
      };
}

class ValueClass {
  ValueClass({
    this.gallerySource,
    this.images,
    this.it,
  });

  GallerySource? gallerySource;
  List<dynamic>? images;
  String? it;

  factory ValueClass.fromJson(Map<String, dynamic> json) => ValueClass(
        gallerySource: json["gallery_source"],
        images: json["images"] == null
            ? []
            : json["images"] == null
                ? []
                : List<dynamic>.from(json["images"]!.map((x) => x)),
        it: json["IT"],
      );

  Map<String, dynamic> toJson() => {
        "gallery_source": gallerySource,
        "images": images == null
            ? []
            : images == null
                ? []
                : List<dynamic>.from(images!.map((x) => x)),
        "IT": it,
      };
}

enum GallerySource { defaults }

final gallerySourceValues = EnumValues({"default": GallerySource.defaults});

enum Status { publish }

final statusValues = EnumValues({"publish": Status.publish});

enum StockStatus { outOfStock }

final stockStatusValues = EnumValues({"outofstock": StockStatus.outOfStock});

enum TaxStatus { taxable }

final taxStatusValues = EnumValues({"taxable": TaxStatus.taxable});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
