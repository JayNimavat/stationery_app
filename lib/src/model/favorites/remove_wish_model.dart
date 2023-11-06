class RemoveWishModel {
  final int status;
  final RemoveWishModelData removeWishModelData;
  final String message;

  RemoveWishModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        removeWishModelData = RemoveWishModelData.fromJsonMap(map['data']),
        message = map['message'];
}

class RemoveWishModelData {
  final int id;
  final int userId;
  final int productId;
  final String isFavorite;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  RemoveWishModelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        userId = map['user_id'],
        productId = map['product_id'],
        isFavorite = map['is_favorite'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
