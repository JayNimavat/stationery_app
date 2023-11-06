class AddToCartModel {
  final int status;
  final AddToCartModelData addToCartModelData;
  final String message;

  AddToCartModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        addToCartModelData = AddToCartModelData.fromJsonMap(map['data']),
        message = map['message'];
}

class AddToCartModelData {
  final String userId;
  final String productId;
  final String qty;
  final String isCart;
  final String deletedAt;
  final String updatedAt;
  final String createdAt;
  final int id;

  AddToCartModelData.fromJsonMap(Map<String, dynamic> map)
      : userId = map['user_id'],
        productId = map['product_id'],
        qty = map['qty'],
        isCart = map['is_cart'],
        deletedAt = map['deleted_at'],
        updatedAt = map['updated_at'],
        createdAt = map['created_at'],
        id = map['id'];
}
