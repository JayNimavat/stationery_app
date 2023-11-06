class StandardModel {
  final int status;
  final List<StandardmodelData> standardmodelData;
  final String message;

  StandardModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        standardmodelData = List<StandardmodelData>.from(
            map['data'].map((x) => StandardmodelData.fromJsonMap(x))),
        message = map['message'];
}

class StandardmodelData {
  final int id;
  final String categoryId;
  final String superCategoryId;
  final String supersubCatId;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  StandardmodelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        categoryId = map['category_id'],
        superCategoryId = map['super_category_id'],
        supersubCatId = map['supersub_cat_id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
