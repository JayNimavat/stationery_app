class BannerlistModel {
  final int status;
  final List<BannerlistData> bannerlistData;
  final String message;

  BannerlistModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        bannerlistData = List<BannerlistData>.from(
            map['data'].map((x) => BannerlistData.fromJsonMap(x))),
        message = map['message'];
}

class BannerlistData {
  final int id;
  final String name;
  final String productId;
  final String image;
  final String status;
  final String bannerType;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  BannerlistData.fromJsonMap(Map<String, dynamic> map)
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
