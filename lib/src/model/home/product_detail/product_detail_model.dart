class ProductDetailModel {
  final int status;
  final ProductDetailModelData productDetailModelData;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  ProductDetailModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        productDetailModelData =
            ProductDetailModelData.fromJsonMap(map['data']),
        totalPages = map['totalPages'],
        totalCount = map['totalCount'],
        pageNumber = map['pageNumber'],
        hasNextPage = map['hasNextPage'],
        hasPreviousPage = map['hasPreviousPage'],
        message = map['message'];
}

class ProductDetailModelData {
  final ProductData productData;
  final List<TopSellingProductList> topSellingProductList;

  ProductDetailModelData.fromJsonMap(Map<String, dynamic> map)
      : productData = ProductData.fromJsonMap(map['productData']),
        topSellingProductList = List<TopSellingProductList>.from(
            map['topSellingProductList']
                .map((x) => TopSellingProductList.fromJsonMap(x)));
}

class ProductData {
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
  final String isCart;
  String isFavorite;
  final int wishlistId;
  final String brandName;
  final String schoolName;
  final String boardName;
  final String mediumName;
  final String standardName;
  final List<ProductImage> productImages;

  ProductData.fromJsonMap(Map<String, dynamic> map)
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
        isFavorite = map['is_favorite'],
        wishlistId = map['wishlist_id'],
        brandName = map['brand_name'],
        schoolName = map['school_name'],
        boardName = map['board_name'],
        mediumName = map['medium_name'],
        standardName = map['standard_name'],
        productImages = List<ProductImage>.from(
            map['productImage'].map((x) => ProductImage.fromJsonMap(x)));
}

class ProductImage {
  final int id;
  final int productId;
  final String productImage;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  ProductImage.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        productId = map['product_id'],
        productImage = map['product_image'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}

class TopSellingProductList {
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
  final String isFavorite;
  final String brandName;

  TopSellingProductList.fromJsonMap(Map<String, dynamic> map)
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
        isFavorite = map['is_favorite'],
        brandName = map['brand_name'];
}
