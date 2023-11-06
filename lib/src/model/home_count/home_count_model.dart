class HomeCountModel {
  final int status;
  final HomeCountModelData homeCountModelData;
  final String message;

  HomeCountModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        homeCountModelData = HomeCountModelData.fromJsonMap(map['data']),
        message = map['message'];
}

class HomeCountModelData {
  final int cartCount;
  final int favoriteCount;
  final int orderCount;

  HomeCountModelData.fromJsonMap(Map<String, dynamic> map)
      : cartCount = map['cartCount'],
        favoriteCount = map['favoriteCount'],
        orderCount = map['orderCount'];
}
