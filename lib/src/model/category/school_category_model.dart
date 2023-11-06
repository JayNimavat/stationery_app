class SchoolCategoryModel {
  final int status;
  final List<SchoolCategoryModelData> schoolCategoryModelData;
  final String message;

  SchoolCategoryModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        schoolCategoryModelData = List<SchoolCategoryModelData>.from(
            map['data'].map((x) => SchoolCategoryModelData.fromJsonMap(x))),
        message = map['message'];
}

class SchoolCategoryModelData {
  final int id;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  SchoolCategoryModelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
