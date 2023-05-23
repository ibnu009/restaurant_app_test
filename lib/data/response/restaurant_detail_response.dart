import 'dart:convert';

import '../model/restaurant.dart';

RestaurantDetailResponse restaurantResponseFromMap(String str) => RestaurantDetailResponse.fromMap(json.decode(str));

String restaurantResponseToMap(RestaurantDetailResponse data) => json.encode(data.toMap());

class RestaurantDetailResponse {
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromMap(Map<String, dynamic> json) => RestaurantDetailResponse(
    error: json["error"],
    message: json["message"],
    restaurant: Restaurant.fromMap(json["restaurant"]),
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "message": message,
    "restaurant": restaurant.toMap(),
  };
}