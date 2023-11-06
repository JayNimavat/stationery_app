class CancelOrderModel {
  final int status;
  final CancelOrderModelData cancelOrderModelData;
  final String message;

  CancelOrderModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        cancelOrderModelData = CancelOrderModelData.fromJsonMap(map['data']),
        message = map['message'];
}

class CancelOrderModelData {
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
  final String deletedAt;
  final String updatedAt;

  CancelOrderModelData.fromJsonMap(Map<String, dynamic> map)
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
        deletedAt = map['deleted_at'];
}
