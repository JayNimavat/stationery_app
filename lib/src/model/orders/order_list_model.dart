class OrderListModel {
  final int status;
  final List<OrderListModelData> orderListModelData;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  OrderListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        orderListModelData = List<OrderListModelData>.from(
            map['data'].map((x) => OrderListModelData.fromJsonMap(x))),
        totalPages = map['totalPages'],
        totalCount = map['totalCount'],
        pageNumber = map['pageNumber'],
        hasNextPage = map['hasNextPage'],
        hasPreviousPage = map['hasPreviousPage'],
        message = map['message'];
}

class OrderListModelData {
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
  final String subTotal;
  final String shippingCharge;
  final String totalAmount;
  final String orderStatus;
  final String cancelReason;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String orderIDEncrypt;
  final String orderDate;
  final int totalQuantity;

  OrderListModelData.fromJsonMap(Map<String, dynamic> map)
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
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'],
        orderIDEncrypt = map['orderIDEncrypt'],
        orderDate = map['order_date'],
        totalQuantity = map['total_quantity'];
}
