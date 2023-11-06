class OfferListModel {
  final int status;
  final List<OfferListModelData> offerListModelData;
  final String message;

  OfferListModel.fromJSonMap(Map<String, dynamic> map)
      : status = map['status'],
        offerListModelData = List<OfferListModelData>.from(
            map['data'].map((x) => OfferListModelData.fromJsonMap(x))),
        message = map['message'];
}

class OfferListModelData {
  final int id;
  final String offerName;
  final String offerDescription;
  final String offerCode;
  final String startDate;
  final String endDate;
  final String offerDiscount;
  final String categoryType;
  final String categoryIds;
  final String superCatId;
  final String superSubCatId;
  final String categoryId;
  final String subCategoryId;
  final String productId;
  final String brandId;
  final String userId;
  final int totalUse;
  final int totalUsed;
  final int totalAmount;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  OfferListModelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        offerName = map['offer_name'],
        offerDescription = map['offer_description'],
        offerCode = map['offer_code'],
        startDate = map['start_date'],
        endDate = map['end_date'],
        offerDiscount = map['offer_discount'],
        categoryType = map['category_type'],
        categoryIds = map['category_ids'],
        superCatId = map['super_cat_id'],
        superSubCatId = map['super_sub_cat_id'],
        categoryId = map['category_id'],
        subCategoryId = map['sub_category_id'],
        productId = map['product_id'],
        brandId = map['brand_id'],
        userId = map['user_id'],
        totalUse = map['total_use'],
        totalUsed = map['total_used'],
        totalAmount = map['total_amount'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
