// To parse this JSON data, do
//
//     final modelInfoProduct = modelInfoProductFromJson(jsonString);

import 'dart:convert';

ModelInfoProduct modelInfoProductFromJson(String str) => ModelInfoProduct.fromJson(json.decode(str));
String modelInfoProductToJson(ModelInfoProduct data) => json.encode(data.toJson());

class ModelInfoProduct {
    ModelInfoProduct({
        this.siteId,
        this.countryDefaultTimeZone,
        this.query,
        this.paging,
        this.results,
        this.sort,
        this.availableSorts,
        this.filters,
        this.availableFilters,
    });

    SiteId siteId;
    String countryDefaultTimeZone;
    String query;
    Paging paging;
    List<ResultInfoProduct> results;
    Sort sort;
    List<Sort> availableSorts;
    List<Filter> filters;
    List<AvailableFilter> availableFilters;

    factory ModelInfoProduct.fromJson(Map<String, dynamic> json) => ModelInfoProduct(
        siteId: siteIdValues.map[json["site_id"]],
        countryDefaultTimeZone: json["country_default_time_zone"],
        query: json["query"],
        paging: Paging.fromJson(json["paging"]),
        results: List<ResultInfoProduct>.from(json["results"].map((x) => ResultInfoProduct.fromJson(x))),
        sort: Sort.fromJson(json["sort"]),
        availableSorts: List<Sort>.from(json["available_sorts"].map((x) => Sort.fromJson(x))),
        filters: List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
        availableFilters: List<AvailableFilter>.from(json["available_filters"].map((x) => AvailableFilter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteIdValues.reverse[siteId],
        "country_default_time_zone": countryDefaultTimeZone,
        "query": query,
        "paging": paging.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "sort": sort.toJson(),
        "available_sorts": List<dynamic>.from(availableSorts.map((x) => x.toJson())),
        "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
        "available_filters": List<dynamic>.from(availableFilters.map((x) => x.toJson())),
    };
}

class AvailableFilter {
    AvailableFilter({
        this.id,
        this.name,
        this.type,
        this.values,
    });

    String id;
    String name;
    AvailableFilterType type;
    List<AvailableFilterValue> values;

    factory AvailableFilter.fromJson(Map<String, dynamic> json) => AvailableFilter(
        id: json["id"],
        name: json["name"],
        type: availableFilterTypeValues.map[json["type"]],
        values: List<AvailableFilterValue>.from(json["values"].map((x) => AvailableFilterValue.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": availableFilterTypeValues.reverse[type],
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
    };
}

enum AvailableFilterType { TEXT, RANGE, BOOLEAN, STRING, LIST }

final availableFilterTypeValues = EnumValues({
    "boolean": AvailableFilterType.BOOLEAN,
    "list": AvailableFilterType.LIST,
    "range": AvailableFilterType.RANGE,
    "STRING": AvailableFilterType.STRING,
    "text": AvailableFilterType.TEXT
});

class AvailableFilterValue {
    AvailableFilterValue({
        this.id,
        this.name,
        this.results,
    });

    String id;
    String name;
    int results;

    factory AvailableFilterValue.fromJson(Map<String, dynamic> json) => AvailableFilterValue(
        id: json["id"],
        name: json["name"],
        results: json["results"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "results": results,
    };
}

class Sort {
    Sort({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name,
    };
}

class Filter {
    Filter({
        this.id,
        this.name,
        this.type,
        this.values,
    });

    String id;
    String name;
    AvailableFilterType type;
    List<FilterValue> values;

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        id: json["id"],
        name: json["name"],
        type: availableFilterTypeValues.map[json["type"]],
        values: List<FilterValue>.from(json["values"].map((x) => FilterValue.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": availableFilterTypeValues.reverse[type],
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
    };
}

class FilterValue {
    FilterValue({
        this.id,
        this.name,
        this.pathFromRoot,
    });

    String id;
    String name;
    List<Sort> pathFromRoot;

    factory FilterValue.fromJson(Map<String, dynamic> json) => FilterValue(
        id: json["id"],
        name: json["name"],
        pathFromRoot: json["path_from_root"] == null ? null : List<Sort>.from(json["path_from_root"].map((x) => Sort.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "path_from_root": pathFromRoot == null ? null : List<dynamic>.from(pathFromRoot.map((x) => x.toJson())),
    };
}

class Paging {
    Paging({
        this.total,
        this.primaryResults,
        this.offset,
        this.limit,
    });

    int total;
    int primaryResults;
    int offset;
    int limit;

    factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        total: json["total"],
        primaryResults: json["primary_results"],
        offset: json["offset"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "primary_results": primaryResults,
        "offset": offset,
        "limit": limit,
    };
}

class ResultInfoProduct {
    ResultInfoProduct({
        this.id,
        this.siteId,
        this.title,
        this.seller,
        this.price,
        this.prices,
        this.salePrice,
        this.currencyId,
        this.availableQuantity,
        this.soldQuantity,
        this.buyingMode,
        this.listingTypeId,
        this.stopTime,
        this.condition,
        this.permalink,
        this.thumbnail,
        this.thumbnailId,
        this.acceptsMercadopago,
        this.installments,
        this.address,
        this.shipping,
        this.sellerAddress,
        this.attributes,
        this.originalPrice,
        this.categoryId,
        this.officialStoreId,
        this.domainId,
        this.catalogProductId,
        this.tags,
        this.orderBackend,
        this.useThumbnailId,
        this.offerScore,
        this.offerShare,
        this.matchScore,
        this.winnerItemId,
        this.melicoin,
        this.discounts,
        this.catalogListing,
        this.differentialPricing,
    });

    String id;
    SiteId siteId;
    String title;
    Seller seller;
    String price;
    Prices prices;
    dynamic salePrice;
    CurrencyId currencyId;
    int availableQuantity;
    int soldQuantity;
    BuyingMode buyingMode;
    ListingTypeId listingTypeId;
    DateTime stopTime;
    Condition condition;
    String permalink;
    String thumbnail;
    String thumbnailId;
    bool acceptsMercadopago;
    Installments installments;
    Address address;
    Shipping shipping;
    SellerAddress sellerAddress;
    List<Attribute> attributes;
    dynamic originalPrice;
    CategoryId categoryId;
    dynamic officialStoreId;
    DomainId domainId;
    String catalogProductId;
    List<ResultTag> tags;
    int orderBackend;
    bool useThumbnailId;
    dynamic offerScore;
    dynamic offerShare;
    dynamic matchScore;
    dynamic winnerItemId;
    dynamic melicoin;
    dynamic discounts;
    bool catalogListing;
    DifferentialPricing differentialPricing;

    factory ResultInfoProduct.fromJson(Map<String, dynamic> json) => ResultInfoProduct(
        id: json["id"],
        siteId: siteIdValues.map[json["site_id"]],
        title: json["title"],
        seller: Seller.fromJson(json["seller"]),
        price: json["price"].toString(),
        prices: Prices.fromJson(json["prices"]),
        salePrice: json["sale_price"],
        currencyId: currencyIdValues.map[json["currency_id"]],
        availableQuantity: json["available_quantity"],
        soldQuantity: json["sold_quantity"],
        buyingMode: buyingModeValues.map[json["buying_mode"]],
        listingTypeId: listingTypeIdValues.map[json["listing_type_id"]],
        stopTime: DateTime.parse(json["stop_time"]),
        condition: conditionValues.map[json["condition"]],
        permalink: json["permalink"],
        thumbnail: json["thumbnail"],
        thumbnailId: json["thumbnail_id"],
        acceptsMercadopago: json["accepts_mercadopago"],
        installments: Installments.fromJson(json["installments"]),
        address: Address.fromJson(json["address"]),
        shipping: Shipping.fromJson(json["shipping"]),
        sellerAddress: SellerAddress.fromJson(json["seller_address"]),
        attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
        originalPrice: json["original_price"],
        categoryId: categoryIdValues.map[json["category_id"]],
        officialStoreId: json["official_store_id"],
        domainId: domainIdValues.map[json["domain_id"]],
        catalogProductId: json["catalog_product_id"],
        tags: List<ResultTag>.from(json["tags"].map((x) => resultTagValues.map[x])),
        orderBackend: json["order_backend"],
        useThumbnailId: json["use_thumbnail_id"],
        offerScore: json["offer_score"],
        offerShare: json["offer_share"],
        matchScore: json["match_score"],
        winnerItemId: json["winner_item_id"],
        melicoin: json["melicoin"],
        discounts: json["discounts"],
        catalogListing: json["catalog_listing"] == null ? null : json["catalog_listing"],
        differentialPricing: json["differential_pricing"] == null ? null : DifferentialPricing.fromJson(json["differential_pricing"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "site_id": siteIdValues.reverse[siteId],
        "title": title,
        "seller": seller.toJson(),
        "price": price,
        "prices": prices.toJson(),
        "sale_price": salePrice,
        "currency_id": currencyIdValues.reverse[currencyId],
        "available_quantity": availableQuantity,
        "sold_quantity": soldQuantity,
        "buying_mode": buyingModeValues.reverse[buyingMode],
        "listing_type_id": listingTypeIdValues.reverse[listingTypeId],
        "stop_time": stopTime.toIso8601String(),
        "condition": conditionValues.reverse[condition],
        "permalink": permalink,
        "thumbnail": thumbnail,
        "thumbnail_id": thumbnailId,
        "accepts_mercadopago": acceptsMercadopago,
        "installments": installments.toJson(),
        "address": address.toJson(),
        "shipping": shipping.toJson(),
        "seller_address": sellerAddress.toJson(),
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
        "original_price": originalPrice,
        "category_id": categoryIdValues.reverse[categoryId],
        "official_store_id": officialStoreId,
        "domain_id": domainIdValues.reverse[domainId],
        "catalog_product_id": catalogProductId,
        "tags": List<dynamic>.from(tags.map((x) => resultTagValues.reverse[x])),
        "order_backend": orderBackend,
        "use_thumbnail_id": useThumbnailId,
        "offer_score": offerScore,
        "offer_share": offerShare,
        "match_score": matchScore,
        "winner_item_id": winnerItemId,
        "melicoin": melicoin,
        "discounts": discounts,
        "catalog_listing": catalogListing == null ? null : catalogListing,
        "differential_pricing": differentialPricing == null ? null : differentialPricing.toJson(),
    };
}

class Address {
    Address({
        this.stateId,
        this.stateName,
        this.cityId,
        this.cityName,
    });

    StateId stateId;
    StateName stateName;
    String cityId;
    String cityName;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        stateId: stateIdValues.map[json["state_id"]],
        stateName: stateNameValues.map[json["state_name"]],
        cityId: json["city_id"] == null ? null : json["city_id"],
        cityName: json["city_name"],
    );

    Map<String, dynamic> toJson() => {
        "state_id": stateIdValues.reverse[stateId],
        "state_name": stateNameValues.reverse[stateName],
        "city_id": cityId == null ? null : cityId,
        "city_name": cityName,
    };
}

enum StateId { AR_C, AR_B, AR_S, AR_E, AR_X }

final stateIdValues = EnumValues({
    "AR-B": StateId.AR_B,
    "AR-C": StateId.AR_C,
    "AR-E": StateId.AR_E,
    "AR-S": StateId.AR_S,
    "AR-X": StateId.AR_X
});

enum StateName { CAPITAL_FEDERAL, BUENOS_AIRES, SANTA_FE, ENTRE_ROS, CRDOBA }

final stateNameValues = EnumValues({
    "Buenos Aires": StateName.BUENOS_AIRES,
    "Capital Federal": StateName.CAPITAL_FEDERAL,
    "Córdoba": StateName.CRDOBA,
    "Entre Ríos": StateName.ENTRE_ROS,
    "Santa Fe": StateName.SANTA_FE
});

class Attribute {
    Attribute({
        this.valueStruct,
        this.name,
        this.valueName,
        this.values,
        this.attributeGroupId,
        this.attributeGroupName,
        this.source,
        this.id,
        this.valueId,
    });

    Struct valueStruct;
    Name name;
    String valueName;
    List<AttributeValue> values;
    AttributeGroupId attributeGroupId;
    AttributeGroupName attributeGroupName;
    int source;
    Id id;
    String valueId;

    factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        valueStruct: json["value_struct"] == null ? null : Struct.fromJson(json["value_struct"]),
        name: nameValues.map[json["name"]],
        valueName: json["value_name"],
        values: List<AttributeValue>.from(json["values"].map((x) => AttributeValue.fromJson(x))),
        attributeGroupId: attributeGroupIdValues.map[json["attribute_group_id"]],
        attributeGroupName: attributeGroupNameValues.map[json["attribute_group_name"]],
        source: json["source"],
        id: idValues.map[json["id"]],
        valueId: json["value_id"] == null ? null : json["value_id"],
    );

    Map<String, dynamic> toJson() => {
        "value_struct": valueStruct == null ? null : valueStruct.toJson(),
        "name": nameValues.reverse[name],
        "value_name": valueName,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
        "attribute_group_id": attributeGroupIdValues.reverse[attributeGroupId],
        "attribute_group_name": attributeGroupNameValues.reverse[attributeGroupName],
        "source": source,
        "id": idValues.reverse[id],
        "value_id": valueId == null ? null : valueId,
    };
}

enum AttributeGroupId { OTHERS }

final attributeGroupIdValues = EnumValues({
    "OTHERS": AttributeGroupId.OTHERS
});

enum AttributeGroupName { OTROS }

final attributeGroupNameValues = EnumValues({
    "Otros": AttributeGroupName.OTROS
});

enum Id { BRAND, ITEM_CONDITION, LINE, MODEL, PROCESSOR_MODEL, WEIGHT, GPU_MODEL }

final idValues = EnumValues({
    "BRAND": Id.BRAND,
    "GPU_MODEL": Id.GPU_MODEL,
    "ITEM_CONDITION": Id.ITEM_CONDITION,
    "LINE": Id.LINE,
    "MODEL": Id.MODEL,
    "PROCESSOR_MODEL": Id.PROCESSOR_MODEL,
    "WEIGHT": Id.WEIGHT
});

enum Name { MARCA, CONDICIN_DEL_TEM, LNEA, MODELO, MODELO_DEL_PROCESADOR, PESO, MODELO_DE_GPU }

final nameValues = EnumValues({
    "Condición del ítem": Name.CONDICIN_DEL_TEM,
    "Línea": Name.LNEA,
    "Marca": Name.MARCA,
    "Modelo": Name.MODELO,
    "Modelo del procesador": Name.MODELO_DEL_PROCESADOR,
    "Modelo de GPU": Name.MODELO_DE_GPU,
    "Peso": Name.PESO
});

class Struct {
    Struct({
        this.number,
        this.unit,
    });

    double number;
    Unit unit;

    factory Struct.fromJson(Map<String, dynamic> json) => Struct(
        number: json["number"].toDouble(),
        unit: unitValues.map[json["unit"]],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "unit": unitValues.reverse[unit],
    };
}

enum Unit { G }

final unitValues = EnumValues({
    "g": Unit.G
});

class AttributeValue {
    AttributeValue({
        this.id,
        this.name,
        this.struct,
        this.source,
    });

    String id;
    String name;
    Struct struct;
    int source;

    factory AttributeValue.fromJson(Map<String, dynamic> json) => AttributeValue(
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
        struct: json["struct"] == null ? null : Struct.fromJson(json["struct"]),
        source: json["source"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name,
        "struct": struct == null ? null : struct.toJson(),
        "source": source,
    };
}

enum BuyingMode { BUY_IT_NOW }

final buyingModeValues = EnumValues({
    "buy_it_now": BuyingMode.BUY_IT_NOW
});

enum CategoryId { MLA1055 }

final categoryIdValues = EnumValues({
    "MLA1055": CategoryId.MLA1055
});

enum Condition { NEW, USED }

final conditionValues = EnumValues({
    "new": Condition.NEW,
    "used": Condition.USED
});

enum CurrencyId { ARS }

final currencyIdValues = EnumValues({
    "ARS": CurrencyId.ARS
});

class DifferentialPricing {
    DifferentialPricing({
        this.id,
    });

    int id;

    factory DifferentialPricing.fromJson(Map<String, dynamic> json) => DifferentialPricing(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

enum DomainId { MLA_CELLPHONES }

final domainIdValues = EnumValues({
    "MLA-CELLPHONES": DomainId.MLA_CELLPHONES
});

class Installments {
    Installments({
        this.quantity,
        this.amount,
        this.rate,
        this.currencyId,
    });

    int quantity;
    double amount;
    double rate;
    CurrencyId currencyId;

    factory Installments.fromJson(Map<String, dynamic> json) => Installments(
        quantity: json["quantity"],
        amount: json["amount"].toDouble(),
        rate: json["rate"].toDouble(),
        currencyId: currencyIdValues.map[json["currency_id"]],
    );

    Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "amount": amount,
        "rate": rate,
        "currency_id": currencyIdValues.reverse[currencyId],
    };
}

enum ListingTypeId { GOLD_SPECIAL, GOLD_PRO, FREE }

final listingTypeIdValues = EnumValues({
    "free": ListingTypeId.FREE,
    "gold_pro": ListingTypeId.GOLD_PRO,
    "gold_special": ListingTypeId.GOLD_SPECIAL
});

class Prices {
    Prices({
        this.id,
        this.prices,
        this.presentation,
        this.paymentMethodPrices,
        this.referencePrices,
        this.purchaseDiscounts,
    });

    String id;
    List<Price> prices;
    Presentation presentation;
    List<dynamic> paymentMethodPrices;
    List<Price> referencePrices;
    List<dynamic> purchaseDiscounts;

    factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        id: json["id"],
        prices: List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
        presentation: Presentation.fromJson(json["presentation"]),
        paymentMethodPrices: List<dynamic>.from(json["payment_method_prices"].map((x) => x)),
        referencePrices: List<Price>.from(json["reference_prices"].map((x) => Price.fromJson(x))),
        purchaseDiscounts: List<dynamic>.from(json["purchase_discounts"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
        "presentation": presentation.toJson(),
        "payment_method_prices": List<dynamic>.from(paymentMethodPrices.map((x) => x)),
        "reference_prices": List<dynamic>.from(referencePrices.map((x) => x.toJson())),
        "purchase_discounts": List<dynamic>.from(purchaseDiscounts.map((x) => x)),
    };
}

class Presentation {
    Presentation({
        this.displayCurrency,
    });

    CurrencyId displayCurrency;

    factory Presentation.fromJson(Map<String, dynamic> json) => Presentation(
        displayCurrency: currencyIdValues.map[json["display_currency"]],
    );

    Map<String, dynamic> toJson() => {
        "display_currency": currencyIdValues.reverse[displayCurrency],
    };
}

class Price {
    Price({
        this.id,
        this.type,
        this.amount,
        this.regularAmount,
        this.currencyId,
        this.lastUpdated,
        this.conditions,
        this.exchangeRateContext,
        this.metadata,
        this.tags,
    });

    String id;
    PriceType type;
    double amount;
    String regularAmount;
    CurrencyId currencyId;
    DateTime lastUpdated;
    Conditions conditions;
    ExchangeRateContext exchangeRateContext;
    Metadata metadata;
    List<dynamic> tags;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        type: priceTypeValues.map[json["type"]],
        amount: json["amount"].toDouble(),
        regularAmount: json["regular_amount"] == null ? null : json["regular_amount"].toString(),
        currencyId: currencyIdValues.map[json["currency_id"]],
        lastUpdated: DateTime.parse(json["last_updated"]),
        conditions: Conditions.fromJson(json["conditions"]),
        exchangeRateContext: exchangeRateContextValues.map[json["exchange_rate_context"]],
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
        tags: json["tags"] == null ? null : List<dynamic>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": priceTypeValues.reverse[type],
        "amount": amount,
        "regular_amount": regularAmount == null ? null : regularAmount,
        "currency_id": currencyIdValues.reverse[currencyId],
        "last_updated": lastUpdated.toIso8601String(),
        "conditions": conditions.toJson(),
        "exchange_rate_context": exchangeRateContextValues.reverse[exchangeRateContext],
        "metadata": metadata == null ? null : metadata.toJson(),
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
    };
}

class Conditions {
    Conditions({
        this.contextRestrictions,
        this.startTime,
        this.endTime,
        this.eligible,
    });

    List<ContextRestriction> contextRestrictions;
    DateTime startTime;
    DateTime endTime;
    bool eligible;

    factory Conditions.fromJson(Map<String, dynamic> json) => Conditions(
        contextRestrictions: List<ContextRestriction>.from(json["context_restrictions"].map((x) => contextRestrictionValues.map[x])),
        startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
        endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        eligible: json["eligible"],
    );

    Map<String, dynamic> toJson() => {
        "context_restrictions": List<dynamic>.from(contextRestrictions.map((x) => contextRestrictionValues.reverse[x])),
        "start_time": startTime == null ? null : startTime.toIso8601String(),
        "end_time": endTime == null ? null : endTime.toIso8601String(),
        "eligible": eligible,
    };
}

enum ContextRestriction { CHANNEL_MARKETPLACE }

final contextRestrictionValues = EnumValues({
    "channel_marketplace": ContextRestriction.CHANNEL_MARKETPLACE
});

enum ExchangeRateContext { DEFAULT }

final exchangeRateContextValues = EnumValues({
    "DEFAULT": ExchangeRateContext.DEFAULT
});

class Metadata {
    Metadata({
        this.promotionId,
        this.promotionType,
    });

    String promotionId;
    String promotionType;

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        promotionId: json["promotion_id"] == null ? null : json["promotion_id"],
        promotionType: json["promotion_type"] == null ? null : json["promotion_type"],
    );

    Map<String, dynamic> toJson() => {
        "promotion_id": promotionId == null ? null : promotionId,
        "promotion_type": promotionType == null ? null : promotionType,
    };
}

enum PriceType { STANDARD, PROMOTION, MIN_STANDARD, WAS }

final priceTypeValues = EnumValues({
    "min_standard": PriceType.MIN_STANDARD,
    "promotion": PriceType.PROMOTION,
    "standard": PriceType.STANDARD,
    "was": PriceType.WAS
});

class Seller {
    Seller({
        this.id,
        this.permalink,
        this.registrationDate,
        this.carDealer,
        this.realEstateAgency,
        this.tags,
        this.eshop,
        this.sellerReputation,
    });

    int id;
    String permalink;
    DateTime registrationDate;
    bool carDealer;
    bool realEstateAgency;
    List<SellerTag> tags;
    Eshop eshop;
    SellerReputation sellerReputation;

    factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        permalink: json["permalink"],
        registrationDate: DateTime.parse(json["registration_date"]),
        carDealer: json["car_dealer"],
        realEstateAgency: json["real_estate_agency"],
        tags: List<SellerTag>.from(json["tags"].map((x) => sellerTagValues.map[x])),
        eshop: json["eshop"] == null ? null : Eshop.fromJson(json["eshop"]),
        sellerReputation: SellerReputation.fromJson(json["seller_reputation"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "permalink": permalink,
        "registration_date": registrationDate.toIso8601String(),
        "car_dealer": carDealer,
        "real_estate_agency": realEstateAgency,
        "tags": List<dynamic>.from(tags.map((x) => sellerTagValues.reverse[x])),
        "eshop": eshop == null ? null : eshop.toJson(),
        "seller_reputation": sellerReputation.toJson(),
    };
}

class Eshop {
    Eshop({
        this.seller,
        this.eshopRubro,
        this.eshopId,
        this.nickName,
        this.siteId,
        this.eshopLogoUrl,
        this.eshopStatusId,
        this.eshopExperience,
        this.eshopLocations,
    });

    int seller;
    dynamic eshopRubro;
    int eshopId;
    String nickName;
    SiteId siteId;
    String eshopLogoUrl;
    int eshopStatusId;
    int eshopExperience;
    List<dynamic> eshopLocations;

    factory Eshop.fromJson(Map<String, dynamic> json) => Eshop(
        seller: json["seller"],
        eshopRubro: json["eshop_rubro"],
        eshopId: json["eshop_id"],
        nickName: json["nick_name"],
        siteId: siteIdValues.map[json["site_id"]],
        eshopLogoUrl: json["eshop_logo_url"],
        eshopStatusId: json["eshop_status_id"],
        eshopExperience: json["eshop_experience"],
        eshopLocations: List<dynamic>.from(json["eshop_locations"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "seller": seller,
        "eshop_rubro": eshopRubro,
        "eshop_id": eshopId,
        "nick_name": nickName,
        "site_id": siteIdValues.reverse[siteId],
        "eshop_logo_url": eshopLogoUrl,
        "eshop_status_id": eshopStatusId,
        "eshop_experience": eshopExperience,
        "eshop_locations": List<dynamic>.from(eshopLocations.map((x) => x)),
    };
}

enum SiteId { MLA }

final siteIdValues = EnumValues({
    "MLA": SiteId.MLA
});

class SellerReputation {
    SellerReputation({
        this.powerSellerStatus,
        this.levelId,
        this.metrics,
        this.transactions,
    });

    String powerSellerStatus;
    LevelId levelId;
    Metrics metrics;
    Transactions transactions;

    factory SellerReputation.fromJson(Map<String, dynamic> json) => SellerReputation(
        powerSellerStatus: json["power_seller_status"] == null ? null : json["power_seller_status"],
        levelId: json["level_id"] == null ? null : levelIdValues.map[json["level_id"]],
        metrics: Metrics.fromJson(json["metrics"]),
        transactions: Transactions.fromJson(json["transactions"]),
    );

    Map<String, dynamic> toJson() => {
        "power_seller_status": powerSellerStatus == null ? null : powerSellerStatus,
        "level_id": levelId == null ? null : levelIdValues.reverse[levelId],
        "metrics": metrics.toJson(),
        "transactions": transactions.toJson(),
    };
}

enum LevelId { THE_5_GREEN, THE_3_YELLOW, THE_1_RED, THE_4_LIGHT_GREEN }

final levelIdValues = EnumValues({
    "1_red": LevelId.THE_1_RED,
    "3_yellow": LevelId.THE_3_YELLOW,
    "4_light_green": LevelId.THE_4_LIGHT_GREEN,
    "5_green": LevelId.THE_5_GREEN
});

class Metrics {
    Metrics({
        this.cancellations,
        this.claims,
        this.delayedHandlingTime,
        this.sales,
    });

    Cancellations cancellations;
    Cancellations claims;
    Cancellations delayedHandlingTime;
    Sales sales;

    factory Metrics.fromJson(Map<String, dynamic> json) => Metrics(
        cancellations: Cancellations.fromJson(json["cancellations"]),
        claims: Cancellations.fromJson(json["claims"]),
        delayedHandlingTime: Cancellations.fromJson(json["delayed_handling_time"]),
        sales: Sales.fromJson(json["sales"]),
    );

    Map<String, dynamic> toJson() => {
        "cancellations": cancellations.toJson(),
        "claims": claims.toJson(),
        "delayed_handling_time": delayedHandlingTime.toJson(),
        "sales": sales.toJson(),
    };
}

class Cancellations {
    Cancellations({
        this.period,
        this.rate,
        this.value,
    });

    CancellationsPeriod period;
    double rate;
    int value;

    factory Cancellations.fromJson(Map<String, dynamic> json) => Cancellations(
        period: cancellationsPeriodValues.map[json["period"]],
        rate: json["rate"].toDouble(),
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "period": cancellationsPeriodValues.reverse[period],
        "rate": rate,
        "value": value,
    };
}

enum CancellationsPeriod { THE_60_DAYS, THE_365_DAYS, THE_60_MONTHS }

final cancellationsPeriodValues = EnumValues({
    "365 days": CancellationsPeriod.THE_365_DAYS,
    "60 days": CancellationsPeriod.THE_60_DAYS,
    "60 months": CancellationsPeriod.THE_60_MONTHS
});

class Sales {
    Sales({
        this.period,
        this.completed,
    });

    CancellationsPeriod period;
    int completed;

    factory Sales.fromJson(Map<String, dynamic> json) => Sales(
        period: cancellationsPeriodValues.map[json["period"]],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "period": cancellationsPeriodValues.reverse[period],
        "completed": completed,
    };
}

class Transactions {
    Transactions({
        this.canceled,
        this.period,
        this.total,
        this.ratings,
        this.completed,
    });

    int canceled;
    TransactionsPeriod period;
    int total;
    Ratings ratings;
    int completed;

    factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        canceled: json["canceled"],
        period: transactionsPeriodValues.map[json["period"]],
        total: json["total"],
        ratings: Ratings.fromJson(json["ratings"]),
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "canceled": canceled,
        "period": transactionsPeriodValues.reverse[period],
        "total": total,
        "ratings": ratings.toJson(),
        "completed": completed,
    };
}

enum TransactionsPeriod { HISTORIC }

final transactionsPeriodValues = EnumValues({
    "historic": TransactionsPeriod.HISTORIC
});

class Ratings {
    Ratings({
        this.negative,
        this.neutral,
        this.positive,
    });

    double negative;
    double neutral;
    double positive;

    factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        negative: json["negative"].toDouble(),
        neutral: json["neutral"].toDouble(),
        positive: json["positive"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "negative": negative,
        "neutral": neutral,
        "positive": positive,
    };
}

enum SellerTag { NORMAL, MSHOPS, ESHOP, MESSAGES_AS_SELLER, CREDITS_PRIORITY_4, CREDITS_PROFILE, MEDIUM_SELLER, CREDITS_ACTIVE_BORROWER, CREDITS_PRIORITY_1 }

final sellerTagValues = EnumValues({
    "credits_active_borrower": SellerTag.CREDITS_ACTIVE_BORROWER,
    "credits_priority_1": SellerTag.CREDITS_PRIORITY_1,
    "credits_priority_4": SellerTag.CREDITS_PRIORITY_4,
    "credits_profile": SellerTag.CREDITS_PROFILE,
    "eshop": SellerTag.ESHOP,
    "medium_seller": SellerTag.MEDIUM_SELLER,
    "messages_as_seller": SellerTag.MESSAGES_AS_SELLER,
    "mshops": SellerTag.MSHOPS,
    "normal": SellerTag.NORMAL
});

class SellerAddress {
    SellerAddress({
        this.id,
        this.comment,
        this.addressLine,
        this.zipCode,
        this.country,
        this.state,
        this.city,
        this.latitude,
        this.longitude,
    });

    String id;
    String comment;
    String addressLine;
    String zipCode;
    Sort country;
    Sort state;
    Sort city;
    String latitude;
    String longitude;

    factory SellerAddress.fromJson(Map<String, dynamic> json) => SellerAddress(
        id: json["id"],
        comment: json["comment"],
        addressLine: json["address_line"],
        zipCode: json["zip_code"],
        country: Sort.fromJson(json["country"]),
        state: Sort.fromJson(json["state"]),
        city: Sort.fromJson(json["city"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "address_line": addressLine,
        "zip_code": zipCode,
        "country": country.toJson(),
        "state": state.toJson(),
        "city": city.toJson(),
        "latitude": latitude,
        "longitude": longitude,
    };
}

class Shipping {
    Shipping({
        this.freeShipping,
        this.mode,
        this.tags,
        this.logisticType,
        this.storePickUp,
    });

    bool freeShipping;
    Mode mode;
    List<ShippingTag> tags;
    LogisticType logisticType;
    bool storePickUp;

    factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
        freeShipping: json["free_shipping"],
        mode: modeValues.map[json["mode"]],
        tags: List<ShippingTag>.from(json["tags"].map((x) => shippingTagValues.map[x])),
        logisticType: logisticTypeValues.map[json["logistic_type"]],
        storePickUp: json["store_pick_up"],
    );

    Map<String, dynamic> toJson() => {
        "free_shipping": freeShipping,
        "mode": modeValues.reverse[mode],
        "tags": List<dynamic>.from(tags.map((x) => shippingTagValues.reverse[x])),
        "logistic_type": logisticTypeValues.reverse[logisticType],
        "store_pick_up": storePickUp,
    };
}

enum LogisticType { CROSS_DOCKING, DROP_OFF, XD_DROP_OFF }

final logisticTypeValues = EnumValues({
    "cross_docking": LogisticType.CROSS_DOCKING,
    "drop_off": LogisticType.DROP_OFF,
    "xd_drop_off": LogisticType.XD_DROP_OFF
});

enum Mode { ME2 }

final modeValues = EnumValues({
    "me2": Mode.ME2
});

enum ShippingTag { SELF_SERVICE_IN, MANDATORY_FREE_SHIPPING }

final shippingTagValues = EnumValues({
    "mandatory_free_shipping": ShippingTag.MANDATORY_FREE_SHIPPING,
    "self_service_in": ShippingTag.SELF_SERVICE_IN
});

enum ResultTag { BRAND_VERIFIED, GOOD_QUALITY_PICTURE, GOOD_QUALITY_THUMBNAIL, IMMEDIATE_PAYMENT, CART_ELIGIBLE, EXTENDED_WARRANTY_ELIGIBLE, SHIPPING_GUARANTEED, LOYALTY_DISCOUNT_ELIGIBLE, POOR_QUALITY_PICTURE, DRAGGED_BIDS_AND_VISITS }

final resultTagValues = EnumValues({
    "brand_verified": ResultTag.BRAND_VERIFIED,
    "cart_eligible": ResultTag.CART_ELIGIBLE,
    "dragged_bids_and_visits": ResultTag.DRAGGED_BIDS_AND_VISITS,
    "extended_warranty_eligible": ResultTag.EXTENDED_WARRANTY_ELIGIBLE,
    "good_quality_picture": ResultTag.GOOD_QUALITY_PICTURE,
    "good_quality_thumbnail": ResultTag.GOOD_QUALITY_THUMBNAIL,
    "immediate_payment": ResultTag.IMMEDIATE_PAYMENT,
    "loyalty_discount_eligible": ResultTag.LOYALTY_DISCOUNT_ELIGIBLE,
    "poor_quality_picture": ResultTag.POOR_QUALITY_PICTURE,
    "shipping_guaranteed": ResultTag.SHIPPING_GUARANTEED
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
