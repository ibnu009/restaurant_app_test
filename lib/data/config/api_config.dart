import 'dart:convert';
import 'dart:io';

import 'package:restaurant_app/data/response/restaurant_detail_response.dart';

import '../response/restaurant_list_response.dart';
import 'package:http/http.dart' as http;

const String contentType = "Content-Type";
const String applicationJson = "application/json";
const genericHeader = <String, String>{contentType: applicationJson};
const baseUrl = "https://restaurant-api.dicoding.dev";
const mediumImage = "https://restaurant-api.dicoding.dev/images/medium";

class ApiConfig  {
    Future<RestaurantListResponse> fetchListRestaurant() async {
      try {
        const String endPoint = '$baseUrl/list';
        final response = await http.get(Uri.parse(endPoint), headers: genericHeader);
        var res = json.decode(response.body);
        return RestaurantListResponse.fromMap(res);
      } on SocketException {
        throw Exception("Connection Failed");
      }
    }

    Future<RestaurantDetailResponse> fetchDetailRestaurant(String id) async {
      try {
        String endPoint = '$baseUrl/detail/$id';
        print("ENDPOINT IS $endPoint");
        final response = await http.get(Uri.parse(endPoint), headers: genericHeader);
        var res = json.decode(response.body);
        return RestaurantDetailResponse.fromMap(res);
      } on SocketException {
        throw Exception("Connection Failed");
      }
    }
}