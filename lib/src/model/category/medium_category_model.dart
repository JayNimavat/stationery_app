class MediumCategoryModel {
  final int status;
  final List<MediumCategoryModelData> mediumCategoryModelData;
  final String message;

  MediumCategoryModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        mediumCategoryModelData = List<MediumCategoryModelData>.from(
            map['data'].map((x) => MediumCategoryModelData.fromJsonMap(x))),
        message = map['message'];
}

class MediumCategoryModelData {
  final int id;
  final String supersubCatId;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  MediumCategoryModelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        supersubCatId = map['super_category_id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
