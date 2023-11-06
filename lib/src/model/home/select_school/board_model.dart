class BoardModel {
  final int status;
  final List<BoardmodelData> boardmodelData;
  final String message;

  BoardModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        boardmodelData = List<BoardmodelData>.from(
            map['data'].map((x) => BoardmodelData.fromJsonMap(x))),
        message = map['message'];
}

class BoardmodelData {
  final int id;
  final String superCategoryId;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  BoardmodelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        superCategoryId = map['super_category_id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
