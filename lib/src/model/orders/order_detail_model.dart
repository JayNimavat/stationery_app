class OrderDetailModel {
  final int status;
  final OrderDetailModelData orderDetailModelData;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  OrderDetailModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        orderDetailModelData = OrderDetailModelData.fromJsonMap(map['data']),
        totalPages = map['totalPages'],
        totalCount = map['totalCount'],
        pageNumber = map['pageNumber'],
        hasNextPage = map['hasNextPage'],
        hasPreviousPage = map['hasPreviousPage'],
        message = map['message'];
}

class OrderDetailModelData {
  final OrderDetail orderDetail;

  OrderDetailModelData.fromJsonMap(Map<String, dynamic> map)
      : orderDetail = OrderDetail.fromJsonMap(map['orderDetail']);
}

class OrderDetail {
  final int id;
  final String orderNo;
  final int userId;
  final String transactionId;
  final String userAddressId;
  final String couponId;
  final String paymentType;
  final String totalDiscount;
  final String discount;
  final String pickupDate;
  final int subTotal;
  final String shippingCharge;
  final String totalAmount;
  final String orderStatus;
  final String cancelReason;
  final String orderDate;
  final List<OrderItem> orderItem;
  final int discountMRP;
  final String invoiceUrl;

  OrderDetail.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        orderNo = map['order_no'],
        userId = map['user_id'],
        transactionId = map['transaction_id'],
        userAddressId = map['user_address_id'],
        couponId = map['coupon_id'],
        paymentType = map['payment_type'],
        totalDiscount = map['total_discount'],
        discount = map['discount'],
        pickupDate = map['pickup_date'],
        subTotal = map['sub_total'],
        shippingCharge = map['shipping_charge'],
        totalAmount = map['total_amount'],
        orderStatus = map['order_status'],
        cancelReason = map['cancel_reason'],
        orderDate = map['order_date'],
        orderItem = List<OrderItem>.from(
            map['orderItem'].map((x) => OrderItem.fromJsonMap(x))),
        discountMRP = map['discountMRP'],
        invoiceUrl = map['invoice_url'];
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final String quantity;
  final String productTotalDiscount;
  final String productPrice;
  final String totalPrice;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final ProductData productData;

  OrderItem.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        orderId = map['order_id'],
        productId = map['product_id'],
        quantity = map['quantity'],
        productTotalDiscount = map['product_total_discount'],
        productPrice = map['product_price'],
        totalPrice = map['total_price'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'],
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
  final String favorite;

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
        brandName = map['brand_name'],
        favorite = map['favorite'];
}
