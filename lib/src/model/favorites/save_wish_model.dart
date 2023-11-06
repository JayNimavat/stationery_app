class SaveWishModel {
  final int status;
  final SaveWishModelData saveWishModelData;
  final String message;

  SaveWishModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        saveWishModelData = SaveWishModelData.fromJsonMap(map['data']),
        message = map['message'];
}

class SaveWishModelData {
  final String userId;
  final String productId;
  final String deletedAt;
  String isFavorite;
  final String updatedAt;
  final String createdAt;
  final int id;

  SaveWishModelData.fromJsonMap(Map<String, dynamic> map)
      : userId = map['user_id'],
        productId = map['product_id'],
        deletedAt = map['deleted_at'],
        isFavorite = map['is_favorite'],
        updatedAt = map['updated_at'],
        createdAt = map['created_at'],
        id = map['id'];
}
