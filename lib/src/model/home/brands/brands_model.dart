class BrandsModel {
  final int status;
  final List<BrandsmodelData> brandsmodelData;
  final String message;

  BrandsModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        brandsmodelData = List<BrandsmodelData>.from(
            map['data'].map((x) => BrandsmodelData.fromJsonMap(x))),
        message = map['message'];
}

class BrandsmodelData {
  final int id;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  BrandsmodelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
