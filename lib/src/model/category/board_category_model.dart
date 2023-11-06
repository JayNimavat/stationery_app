class BoardCategoryModel {
  final int status;
  final List<BoardCategoryModelData> boardCategoryModelData;
  final String message;

  BoardCategoryModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        boardCategoryModelData = List<BoardCategoryModelData>.from(
            map['data'].map((x) => BoardCategoryModelData.fromJsonMap(x))),
        message = map['message'];
}

class BoardCategoryModelData {
  final int id;
  final String superCategoryId;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  BoardCategoryModelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        superCategoryId = map['super_category_id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
