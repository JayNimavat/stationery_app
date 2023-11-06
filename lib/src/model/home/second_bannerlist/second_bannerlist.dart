class SecondBannerListModel {
  final int status;
  final List<SecondBannerListModelData> secondBannerListModelData;
  final String message;

  SecondBannerListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        secondBannerListModelData = List<SecondBannerListModelData>.from(
            map['data'].map((x) => SecondBannerListModelData.fromJsonMap(x))),
        message = map['message'];
}

class SecondBannerListModelData {
  final int id;
  final String name;
  final String productId;
  final String image;
  final String status;
  final String bannerType;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  SecondBannerListModelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        productId = map['product_id'],
        image = map['image'],
        status = map['status'],
        bannerType = map['banner_type'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
