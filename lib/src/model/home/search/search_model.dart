class SearchModel {
  final int status;
  final SearchData searchData;
  final int totalpages;
  final int totalcount;
  final int pagenumber;
  final bool hasnextpage;
  final bool haspreviouspage;
  final String message;

  SearchModel.fromJSonMap(Map<String, dynamic> map)
      : status = map['status'],
        searchData = SearchData.fromJsonMap(map['data']),
        totalpages = map['totalPages'],
        totalcount = map['totalCount'],
        pagenumber = map['pageNumber'],
        hasnextpage = map['hasNextPage'],
        haspreviouspage = map['hasPreviousPage'],
        message = map['message'];
}

class SearchData {
  final List<SearchProductData> searchProductData;

  SearchData.fromJsonMap(Map<String, dynamic> map)
      : searchProductData = List<SearchProductData>.from(
            map['productData'].map((x) => SearchProductData.fromJsonMap(x)));
}

class SearchProductData {
  final int id;
  final String productName;
  final String superCatId;
  final String superSubCatId;
  final String categoryId;
  final String subCategoryId;
  final String productImage;
  final int brandId;
  final String price;
  final String quantity;
  final String description;
  final String discount;
  final String discountPrice;
  final String soldBy;
  final String status;
  final String isFuture;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  String isCart;
  final String brandName;

  SearchProductData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        productName = map['product_name'],
        superCatId = map['super_cat_id'],
        superSubCatId = map['super_sub_cat_id'],
        categoryId = map['category_id'],
        subCategoryId = map['sub_category_id'],
        productImage = map['product_image'],
        brandId = map['brand_id'],
        price = map['price'],
        quantity = map['quantity'],
        description = map['description'],
        discount = map['discount'],
        discountPrice = map['discount_price'],
        soldBy = map['sold_by'],
        status = map['status'],
        isFuture = map['is_future'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'],
        isCart = map['is_cart'],
        brandName = map['brand_name'];
}
