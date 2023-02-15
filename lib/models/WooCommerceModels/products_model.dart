// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

List<ProductsModel?>? productsModelFromJson(String str) =>
    jsonDecode(str) == null
        ? []
        : List<ProductsModel?>.from(
            jsonDecode(str)!.map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel?>? data) => jsonEncode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class ProductsModel {
  ProductsModel({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.lowStockAmount,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.menuOrder,
    this.priceHtml,
    this.relatedIds,
    this.metaData,
    this.stockStatus,
    this.hasOptions,
    this.yoastHead,
    this.locations,
    this.links,
  });

  int? id;
  String? name;
  String? slug;
  String? permalink;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  ProductsModelType? type;
  Status? status;
  bool? featured;
  CatalogVisibility? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? virtual;
  bool? downloadable;
  List<dynamic>? downloads;
  int? downloadLimit;
  int? downloadExpiry;
  String? externalUrl;
  String? buttonText;
  TaxStatus? taxStatus;
  String? taxClass;
  bool? manageStock;
  int? stockQuantity;
  Backorders? backorders;
  bool? backordersAllowed;
  bool? backordered;
  dynamic lowStockAmount;
  bool? soldIndividually;
  String? weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  int? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  List<dynamic>? upsellIds;
  List<dynamic>? crossSellIds;
  int? parentId;
  String? purchaseNote;
  List<Categoryz?>? categories;
  List<dynamic>? tags;
  List<ProdImage?>? images;
  List<Attribute?>? attributes;
  List<DefaultAttribute?>? defaultAttributes;
  List<int?>? variations;
  List<dynamic>? groupedProducts;
  int? menuOrder;
  String? priceHtml;
  List<int?>? relatedIds;
  List<MetaDatum?>? metaData;
  StockStatus? stockStatus;
  bool? hasOptions;
  String? yoastHead;
  List<dynamic>? locations;
  Links? links;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        type: productsModelTypeValues.map[json["type"]],
        status: statusValues.map[json["status"]],
        featured: json["featured"],
        catalogVisibility:
            catalogVisibilityValues.map[json["catalog_visibility"]],
        description: json["description"],
        shortDescription: json["short_description"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
        dateOnSaleTo: json["date_on_sale_to"],
        dateOnSaleToGmt: json["date_on_sale_to_gmt"],
        onSale: json["on_sale"],
        purchasable: json["purchasable"],
        totalSales: json["total_sales"],
        virtual: json["virtual"],
        downloadable: json["downloadable"],
        downloads: json["downloads"] == null
            ? []
            : List<dynamic>.from(json["downloads"]!.map((x) => x)),
        downloadLimit: json["download_limit"],
        downloadExpiry: json["download_expiry"],
        externalUrl: json["external_url"],
        buttonText: json["button_text"],
        taxStatus: taxStatusValues.map[json["tax_status"]],
        taxClass: json["tax_class"],
        manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        backorders: backordersValues.map[json["backorders"]],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        lowStockAmount: json["low_stock_amount"],
        soldIndividually: json["sold_individually"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        shippingRequired: json["shipping_required"],
        shippingTaxable: json["shipping_taxable"],
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        reviewsAllowed: json["reviews_allowed"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        upsellIds: json["upsell_ids"] == null
            ? []
            : List<dynamic>.from(json["upsell_ids"]!.map((x) => x)),
        crossSellIds: json["cross_sell_ids"] == null
            ? []
            : List<dynamic>.from(json["cross_sell_ids"]!.map((x) => x)),
        parentId: json["parent_id"],
        purchaseNote: json["purchase_note"],
        categories: json["categories"] == null
            ? []
            : List<Categoryz?>.from(
                json["categories"]!.map((x) => Categoryz.fromJson(x))),
        tags: json["tags"] == null
            ? []
            : List<dynamic>.from(json["tags"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<ProdImage?>.from(
                json["images"]!.map((x) => ProdImage.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<Attribute?>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
        defaultAttributes: json["default_attributes"] == null
            ? []
            : List<DefaultAttribute?>.from(json["default_attributes"]!
                .map((x) => DefaultAttribute.fromJson(x))),
        variations: json["variations"] == null
            ? []
            : List<int?>.from(json["variations"]!.map((x) => x)),
        groupedProducts: json["grouped_products"] == null
            ? []
            : List<dynamic>.from(json["grouped_products"]!.map((x) => x)),
        menuOrder: json["menu_order"],
        priceHtml: json["price_html"],
        relatedIds: json["related_ids"] == null
            ? []
            : List<int?>.from(json["related_ids"]!.map((x) => x)),
        metaData: json["meta_data"] == null
            ? []
            : List<MetaDatum?>.from(
                json["meta_data"]!.map((x) => MetaDatum.fromJson(x))),
        stockStatus: stockStatusValues.map[json["stock_status"]],
        hasOptions: json["has_options"],
        yoastHead: json["yoast_head"],
        locations: json["locations"] == null
            ? []
            : List<dynamic>.from(json["locations"]!.map((x) => x)),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "type": productsModelTypeValues.reverse![type],
        "status": statusValues.reverse![status],
        "featured": featured,
        "catalog_visibility":
            catalogVisibilityValues.reverse![catalogVisibility],
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "date_on_sale_from": dateOnSaleFrom,
        "date_on_sale_from_gmt": dateOnSaleFromGmt,
        "date_on_sale_to": dateOnSaleTo,
        "date_on_sale_to_gmt": dateOnSaleToGmt,
        "on_sale": onSale,
        "purchasable": purchasable,
        "total_sales": totalSales,
        "virtual": virtual,
        "downloadable": downloadable,
        "downloads": downloads == null
            ? []
            : List<dynamic>.from(downloads!.map((x) => x)),
        "download_limit": downloadLimit,
        "download_expiry": downloadExpiry,
        "external_url": externalUrl,
        "button_text": buttonText,
        "tax_status": taxStatusValues.reverse![taxStatus],
        "tax_class": taxClass,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "backorders": backordersValues.reverse![backorders],
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "low_stock_amount": lowStockAmount,
        "sold_individually": soldIndividually,
        "weight": weight,
        "dimensions": dimensions!.toJson(),
        "shipping_required": shippingRequired,
        "shipping_taxable": shippingTaxable,
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "reviews_allowed": reviewsAllowed,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "upsell_ids": upsellIds == null
            ? []
            : List<dynamic>.from(upsellIds!.map((x) => x)),
        "cross_sell_ids": crossSellIds == null
            ? []
            : List<dynamic>.from(crossSellIds!.map((x) => x)),
        "parent_id": parentId,
        "purchase_note": purchaseNote,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x!.toJson())),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x!.toJson())),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x!.toJson())),
        "default_attributes": defaultAttributes == null
            ? []
            : List<dynamic>.from(defaultAttributes!.map((x) => x!.toJson())),
        "variations": variations == null
            ? []
            : List<dynamic>.from(variations!.map((x) => x)),
        "grouped_products": groupedProducts == null
            ? []
            : List<dynamic>.from(groupedProducts!.map((x) => x)),
        "menu_order": menuOrder,
        "price_html": priceHtml,
        "related_ids": relatedIds == null
            ? []
            : List<dynamic>.from(relatedIds!.map((x) => x)),
        "meta_data": metaData == null
            ? []
            : List<dynamic>.from(metaData!.map((x) => x!.toJson())),
        "stock_status": stockStatusValues.reverse![stockStatus],
        "has_options": hasOptions,
        "yoast_head": yoastHead,
        "locations": locations == null
            ? []
            : List<dynamic>.from(locations!.map((x) => x)),
        "_links": links!.toJson(),
      };
}

class Attribute {
  Attribute({
    this.id,
    this.name,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  int? id;
  Name? name;
  int? position;
  bool? visible;
  bool? variation;
  List<String?>? options;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: nameValues.map[json["name"]],
        position: json["position"],
        visible: json["visible"],
        variation: json["variation"],
        options: json["options"] == null
            ? []
            : List<String?>.from(json["options"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse![name],
        "position": position,
        "visible": visible,
        "variation": variation,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
      };
}

enum Name { colore, memoria }

final nameValues = EnumValues({"Colore": Name.colore, "Memoria": Name.memoria});

enum Backorders { no }

final backordersValues = EnumValues({"no": Backorders.no});

enum CatalogVisibility { visible }

final catalogVisibilityValues =
    EnumValues({"visible": CatalogVisibility.visible});

class Categoryz {
  Categoryz({
    this.id,
    this.name,
    this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory Categoryz.fromJson(Map<String, dynamic> json) => Categoryz(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class DefaultAttribute {
  DefaultAttribute({
    this.id,
    this.name,
    this.option,
  });

  int? id;
  Name? name;
  Option? option;

  factory DefaultAttribute.fromJson(Map<String, dynamic> json) =>
      DefaultAttribute(
        id: json["id"],
        name: nameValues.map[json["name"]],
        option: optionValues.map[json["option"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse![name],
        "option": optionValues.reverse![option],
      };
}

enum Option { nero, the64gb, the128gb }

final optionValues = EnumValues(
    {"nero": Option.nero, "128-gb": Option.the128gb, "64-gb": Option.the64gb});

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

class ProdImage {
  ProdImage({
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
  String? name;
  String? alt;

  factory ProdImage.fromJson(Map<String, dynamic> json) => ProdImage(
        id: json["id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        src: json["src"],
        name: json["name"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "src": src,
        "name": name,
        "alt": alt,
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection?>? self;
  List<Collection?>? collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? []
            : List<Collection?>.from(
                json["self"]!.map((x) => Collection.fromJson(x))),
        collection: json["collection"] == null
            ? []
            : List<Collection?>.from(
                json["collection"]!.map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? []
            : List<dynamic>.from(self!.map((x) => x!.toJson())),
        "collection": collection == null
            ? []
            : List<dynamic>.from(collection!.map((x) => x!.toJson())),
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
  String? key;
  dynamic value;

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
      };
}

class ValueClass {
  ValueClass({
    this.stylesDescriptor,
    this.the414C5E39686B80472Dfd19Eb68D5Cbda,
    this.it,
    this.the32B0Bf150Bb6Bd30C74Ed5Fafdacd61F,
  });

  StylesDescriptor? stylesDescriptor;
  The32B0Bf150Bb6Bd30C74Ed5Fafdacd61F? the414C5E39686B80472Dfd19Eb68D5Cbda;
  String? it;
  The32B0Bf150Bb6Bd30C74Ed5Fafdacd61F? the32B0Bf150Bb6Bd30C74Ed5Fafdacd61F;

  factory ValueClass.fromJson(Map<String, dynamic> json) => ValueClass(
        stylesDescriptor: json["styles_descriptor"],
        the414C5E39686B80472Dfd19Eb68D5Cbda:
            json["414c5e39686b80472dfd19eb68d5cbda"],
        it: json["IT"],
        the32B0Bf150Bb6Bd30C74Ed5Fafdacd61F:
            json["32b0bf150bb6bd30c74ed5fafdacd61f"],
      );

  Map<String, dynamic> toJson() => {
        "styles_descriptor": stylesDescriptor,
        "414c5e39686b80472dfd19eb68d5cbda": the414C5E39686B80472Dfd19Eb68D5Cbda,
        "IT": it,
        "32b0bf150bb6bd30c74ed5fafdacd61f": the32B0Bf150Bb6Bd30C74Ed5Fafdacd61F,
      };
}

class StylesDescriptor {
  StylesDescriptor({
    this.styles,
    this.googleFonts,
    this.version,
  });

  Styles? styles;
  List<dynamic>? googleFonts;
  int? version;

  factory StylesDescriptor.fromJson(Map<String, dynamic> json) =>
      StylesDescriptor(
        styles: Styles.fromJson(json["styles"]),
        googleFonts: json["google_fonts"] == null
            ? []
            : List<dynamic>.from(json["google_fonts"]!.map((x) => x)),
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "styles": styles!.toJson(),
        "google_fonts": googleFonts == null
            ? []
            : List<dynamic>.from(googleFonts!.map((x) => x)),
        "version": version,
      };
}

class Styles {
  Styles({
    this.desktop,
    this.tablet,
    this.mobile,
  });

  String? desktop;
  String? tablet;
  String? mobile;

  factory Styles.fromJson(Map<String, dynamic> json) => Styles(
        desktop: json["desktop"],
        tablet: json["tablet"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "desktop": desktop,
        "tablet": tablet,
        "mobile": mobile,
      };
}

class The32B0Bf150Bb6Bd30C74Ed5Fafdacd61F {
  The32B0Bf150Bb6Bd30C74Ed5Fafdacd61F({
    this.expires,
    this.payload,
  });

  int? expires;
  List<Payload?>? payload;

  factory The32B0Bf150Bb6Bd30C74Ed5Fafdacd61F.fromJson(
          Map<String, dynamic> json) =>
      The32B0Bf150Bb6Bd30C74Ed5Fafdacd61F(
        expires: json["expires"],
        payload: json["payload"] == null
            ? []
            : List<Payload?>.from(
                json["payload"]!.map((x) => Payload.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expires": expires,
        "payload": payload == null
            ? []
            : List<dynamic>.from(payload!.map((x) => x!.toJson())),
      };
}

class Payload {
  Payload({
    this.id,
  });

  int? id;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

enum Status { publish }

final statusValues = EnumValues({"publish": Status.publish});

enum StockStatus { inStock, outOfStock }

final stockStatusValues = EnumValues(
    {"instock": StockStatus.inStock, "outofstock": StockStatus.outOfStock});

enum TaxStatus { taxable }

final taxStatusValues = EnumValues({"taxable": TaxStatus.taxable});

enum ProductsModelType { variable, simple }

final productsModelTypeValues = EnumValues({
  "simple": ProductsModelType.simple,
  "variable": ProductsModelType.variable
});

class YoastHeadJson {
  YoastHeadJson({
    this.title,
    this.description,
    this.robots,
    this.canonical,
    this.ogLocale,
    this.ogType,
    this.ogTitle,
    this.ogDescription,
    this.ogUrl,
    this.ogSiteName,
    this.articleModifiedTime,
    this.ogImage,
    this.twitterCard,
    this.twitterMisc,
  });

  String? title;
  String? description;
  Robots? robots;
  String? canonical;
  OgLocale? ogLocale;
  OgType? ogType;
  String? ogTitle;
  String? ogDescription;
  String? ogUrl;
  OgSiteName? ogSiteName;
  DateTime? articleModifiedTime;
  List<OgImage?>? ogImage;
  TwitterCard? twitterCard;
  TwitterMisc? twitterMisc;

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
        title: json["title"],
        description: json["description"],
        robots: Robots.fromJson(json["robots"]),
        canonical: json["canonical"],
        ogLocale: ogLocaleValues.map[json["og_locale"]],
        ogType: ogTypeValues.map[json["og_type"]],
        ogTitle: json["og_title"],
        ogDescription: json["og_description"],
        ogUrl: json["og_url"],
        ogSiteName: ogSiteNameValues.map[json["og_site_name"]],
        articleModifiedTime: DateTime.parse(json["article_modified_time"]),
        ogImage: json["og_image"] == null
            ? []
            : List<OgImage?>.from(
                json["og_image"]!.map((x) => OgImage.fromJson(x))),
        twitterCard: twitterCardValues.map[json["twitter_card"]],
        twitterMisc: TwitterMisc.fromJson(json["twitter_misc"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "robots": robots!.toJson(),
        "canonical": canonical,
        "og_locale": ogLocaleValues.reverse![ogLocale],
        "og_type": ogTypeValues.reverse![ogType],
        "og_title": ogTitle,
        "og_description": ogDescription,
        "og_url": ogUrl,
        "og_site_name": ogSiteNameValues.reverse![ogSiteName],
        "article_modified_time": articleModifiedTime?.toIso8601String(),
        "og_image": ogImage == null
            ? []
            : List<dynamic>.from(ogImage!.map((x) => x!.toJson())),
        "twitter_card": twitterCardValues.reverse![twitterCard],
        "twitter_misc": twitterMisc!.toJson(),
      };
}

class OgImage {
  OgImage({
    this.width,
    this.height,
    this.url,
    this.type,
  });

  int? width;
  int? height;
  String? url;
  OgImageType? type;

  factory OgImage.fromJson(Map<String, dynamic> json) => OgImage(
        width: json["width"],
        height: json["height"],
        url: json["url"],
        type: ogImageTypeValues.map[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "url": url,
        "type": ogImageTypeValues.reverse![type],
      };
}

enum OgImageType { imageWebp }

final ogImageTypeValues = EnumValues({"image/webp": OgImageType.imageWebp});

enum OgLocale { itIT }

final ogLocaleValues = EnumValues({"it_IT": OgLocale.itIT});

enum OgSiteName { iComShop }

final ogSiteNameValues = EnumValues({"iCom Shop": OgSiteName.iComShop});

enum OgType { article }

final ogTypeValues = EnumValues({"article": OgType.article});

class Robots {
  Robots({
    this.index,
    this.follow,
    this.maxSnippet,
    this.maxImagePreview,
    this.maxVideoPreview,
  });

  Index? index;
  Follow? follow;
  MaxSnippet? maxSnippet;
  MaxImagePreview? maxImagePreview;
  MaxVideoPreview? maxVideoPreview;

  factory Robots.fromJson(Map<String, dynamic> json) => Robots(
        index: indexValues.map[json["index"]],
        follow: followValues.map[json["follow"]],
        maxSnippet: maxSnippetValues.map[json["max-snippet"]],
        maxImagePreview: maxImagePreviewValues.map[json["max-image-preview"]],
        maxVideoPreview: maxVideoPreviewValues.map[json["max-video-preview"]],
      );

  Map<String, dynamic> toJson() => {
        "index": indexValues.reverse![index],
        "follow": followValues.reverse![follow],
        "max-snippet": maxSnippetValues.reverse![maxSnippet],
        "max-image-preview": maxImagePreviewValues.reverse![maxImagePreview],
        "max-video-preview": maxVideoPreviewValues.reverse![maxVideoPreview],
      };
}

enum Follow { follow }

final followValues = EnumValues({"follow": Follow.follow});

enum Index { iNdex }

final indexValues = EnumValues({"index": Index.iNdex});

enum MaxImagePreview { maxImagePreviewLarge }

final maxImagePreviewValues = EnumValues(
    {"max-image-preview:large": MaxImagePreview.maxImagePreviewLarge});

enum MaxSnippet { maxSnippet1 }

final maxSnippetValues = EnumValues({"max-snippet:-1": MaxSnippet.maxSnippet1});

enum MaxVideoPreview { maxVideoPreview }

final maxVideoPreviewValues =
    EnumValues({"max-video-preview:-1": MaxVideoPreview.maxVideoPreview});

class Breadcrumb {
  Breadcrumb({
    this.id,
  });

  String? id;

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
        id: json["@id"],
      );

  Map<String, dynamic> toJson() => {
        "@id": id,
      };
}

enum InLanguage { itIT }

final inLanguageValues = EnumValues({"it-IT": InLanguage.itIT});

class ItemListElement {
  ItemListElement({
    this.type,
    this.position,
    this.name,
    this.item,
  });

  ItemListElementType? type;
  int? position;
  String? name;
  String? item;

  factory ItemListElement.fromJson(Map<String, dynamic> json) =>
      ItemListElement(
        type: itemListElementTypeValues.map[json["@type"]],
        position: json["position"],
        name: json["name"],
        item: json["item"],
      );

  Map<String, dynamic> toJson() => {
        "@type": itemListElementTypeValues.reverse![type],
        "position": position,
        "name": name,
        "item": item,
      };
}

enum ItemListElementType { listItem }

final itemListElementTypeValues =
    EnumValues({"ListItem": ItemListElementType.listItem});

class Logo {
  Logo({
    this.type,
    this.inLanguage,
    this.id,
    this.url,
    this.contentUrl,
    this.width,
    this.height,
    this.caption,
  });

  LogoType? type;
  InLanguage? inLanguage;
  String? id;
  String? url;
  String? contentUrl;
  int? width;
  int? height;
  Caption? caption;

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        type: logoTypeValues.map[json["@type"]],
        inLanguage: inLanguageValues.map[json["inLanguage"]],
        id: json["@id"],
        url: json["url"],
        contentUrl: json["contentUrl"],
        width: json["width"],
        height: json["height"],
        caption: captionValues.map[json["caption"]],
      );

  Map<String, dynamic> toJson() => {
        "@type": logoTypeValues.reverse![type],
        "inLanguage": inLanguageValues.reverse![inLanguage],
        "@id": id,
        "url": url,
        "contentUrl": contentUrl,
        "width": width,
        "height": height,
        "caption": captionValues.reverse![caption],
      };
}

enum Caption { iCom }

final captionValues = EnumValues({"I-Com": Caption.iCom});

enum LogoType { imageObject }

final logoTypeValues = EnumValues({"ImageObject": LogoType.imageObject});

class PotentialAction {
  PotentialAction({
    this.type,
    this.target,
    this.queryInput,
  });

  PotentialActionType? type;
  dynamic target;
  QueryInput? queryInput;

  factory PotentialAction.fromJson(Map<String, dynamic> json) =>
      PotentialAction(
        type: potentialActionTypeValues.map[json["@type"]],
        target: json["target"],
        queryInput: json["query-input"],
      );

  Map<String, dynamic> toJson() => {
        "@type": potentialActionTypeValues.reverse![type],
        "target": target,
        "query-input": queryInput,
      };
}

enum QueryInput { requiredNameSearchTermString }

final queryInputValues = EnumValues({
  "required name=search_term_string": QueryInput.requiredNameSearchTermString
});

class TargetClass {
  TargetClass({
    this.type,
    this.urlTemplate,
  });

  TargetType? type;
  UrlTemplate? urlTemplate;

  factory TargetClass.fromJson(Map<String, dynamic> json) => TargetClass(
        type: targetTypeValues.map[json["@type"]],
        urlTemplate: urlTemplateValues.map[json["urlTemplate"]],
      );

  Map<String, dynamic> toJson() => {
        "@type": targetTypeValues.reverse![type],
        "urlTemplate": urlTemplateValues.reverse![urlTemplate],
      };
}

enum TargetType { entryPoint }

final targetTypeValues = EnumValues({"EntryPoint": TargetType.entryPoint});

enum UrlTemplate { httpsAlealinoComIcomSSearchTermString }

final urlTemplateValues = EnumValues({
  "https://alealino.com/icom/?s={search_term_string}":
      UrlTemplate.httpsAlealinoComIcomSSearchTermString
});

enum PotentialActionType { readAction, searchAction }

final potentialActionTypeValues = EnumValues({
  "ReadAction": PotentialActionType.readAction,
  "SearchAction": PotentialActionType.searchAction
});

enum GraphType { webPage, breadcrumbList, webSite, organization }

final graphTypeValues = EnumValues({
  "BreadcrumbList": GraphType.breadcrumbList,
  "Organization": GraphType.organization,
  "WebPage": GraphType.webPage,
  "WebSite": GraphType.webSite
});

enum TwitterCard { summaryLargeImage }

final twitterCardValues =
    EnumValues({"summary_large_image": TwitterCard.summaryLargeImage});

class TwitterMisc {
  TwitterMisc({
    this.tempoDiLetturaStimato,
  });

  TempoDiLetturaStimato? tempoDiLetturaStimato;

  factory TwitterMisc.fromJson(Map<String, dynamic> json) => TwitterMisc(
        tempoDiLetturaStimato:
            tempoDiLetturaStimatoValues.map[json["Tempo di lettura stimato"]],
      );

  Map<String, dynamic> toJson() => {
        "Tempo di lettura stimato":
            tempoDiLetturaStimatoValues.reverse![tempoDiLetturaStimato],
      };
}

enum TempoDiLetturaStimato { the1Minuto }

final tempoDiLetturaStimatoValues =
    EnumValues({"1 minuto": TempoDiLetturaStimato.the1Minuto});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
