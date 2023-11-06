class StandardCategoryModel {
  final int status;
  final List<StandardCategoryModelData> standardCategoryModelData;
  final String message;

  StandardCategoryModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        standardCategoryModelData = List<StandardCategoryModelData>.from(
            map['data'].map((x) => StandardCategoryModelData.fromJsonMap(x))),
        message = map['message'];
}

class StandardCategoryModelData {
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

  StandardCategoryModelData.fromJsonMap(Map<String, dynamic> map)
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
