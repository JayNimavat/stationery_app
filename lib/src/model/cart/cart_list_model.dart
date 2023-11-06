class CartListModel {
  final int status;
  final CartListModelData cartListModelData;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  CartListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        cartListModelData = CartListModelData.fromJsonMap(map['data']),
        totalPages = map['totalPages'],
        totalCount = map['totalCount'],
        pageNumber = map['pageNumber'],
        hasNextPage = map['hasNextPage'],
        hasPreviousPage = map['hasPreviousPage'],
        message = map['message'];
}

class CartListModelData {
  final List<CartDetail> cartDetail;
  final CartSummary cartSummary;

  CartListModelData.fromJsonMap(Map<String, dynamic> map)
      : cartDetail = List<CartDetail>.from(
            map['cartDetail'].map((x) => CartDetail.fromJsonMap(x))),
        cartSummary = CartSummary.fromJsonMap(map['cart_summary']);
}

class CartDetail {
  final int id;
  final String userId;
  final String productId;
  String qty;
  final String isCart;
  final String offerId;
  final String isGlobalOffer;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;
  final ProductData productData;

  CartDetail.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        userId = map['user_id'],
        productId = map['product_id'],
        qty = map['qty'],
        isCart = map['is_cart'],
        offerId = map['offer_id'],
        isGlobalOffer = map['is_global_offer'],
        deletedAt = map['deleted_at'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        productData = ProductData.fromJsonMap(map['productData']);
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
  final String brandName;

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
        brandName = map['brand_name'];
}

class CartSummary {
  final int subTotal;
  final int discountTotal;
  final int couponDiscount;
  final int deliveryCharge;
  int orderTotal;

  CartSummary.fromJsonMap(Map<String, dynamic> map)
      : subTotal = map['sub_total'],
        discountTotal = map['discount_total'],
        couponDiscount = map['coupon_discount'],
        deliveryCharge = map['delivery_charge'],
        orderTotal = map['order_total'];
}
