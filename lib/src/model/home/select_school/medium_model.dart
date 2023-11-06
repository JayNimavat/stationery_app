class MediumModel {
  final int status;
  final List<MediummodelData> mediummodelData;
  final String message;

  MediumModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        mediummodelData = List<MediummodelData>.from(
            map['data'].map((x) => MediummodelData.fromJsonMap(x))),
        message = map['message'];
}

class MediummodelData {
  final int id;
  final String supersubCatId;
  final String superCategoryId;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  MediummodelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        supersubCatId = map['supersub_cat_id'],
        superCategoryId = map['super_category_id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
