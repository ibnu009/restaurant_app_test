import 'package:flutter/material.dart';
import 'package:restaurant_app/data/config/api_config.dart';

import '../data/model/restaurant.dart';
import '../data/response/restaurant_detail_response.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final String idRestaurant;

  const DetailRestaurantScreen({super.key, required this.idRestaurant});

  @override
  DetailRestaurantScreenState createState() => DetailRestaurantScreenState();
}

class DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  late Future<RestaurantDetailResponse> _futureDetailRestaurant;

  @override
  void initState() {
    super.initState();
    _futureDetailRestaurant =
        ApiConfig().fetchDetailRestaurant(widget.idRestaurant);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.idRestaurant,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          body: FutureBuilder(
            future: _futureDetailRestaurant,
            builder: (context, snapshot) {
              var state = snapshot.connectionState;
              if (state == ConnectionState.waiting){
                return _loadingWidget();
              }

              if(snapshot.hasData){
                var data = snapshot.data;
                return _detailRestaurantBody(context, data!.restaurant);
              }

              return Center(child: Text(snapshot.error.toString()),);
            },
          )),
    );
  }
}

Widget _detailRestaurantBody(BuildContext context, Restaurant restaurant) {
  final screen = MediaQuery.of(context).size;

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screen.height * 0.4,
          child: SizedBox(
              height: screen.height * 0.4,
              width: screen.width * 1,
              child: Image.network("$mediumImage/${restaurant.pictureId}",
                  fit: BoxFit.cover)),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 16),
                  child: Text(
                    restaurant.name ?? '',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.place, color: Colors.redAccent),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          restaurant.city ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.star, color: Colors.yellow),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 16),
          child: Text(
            restaurant.description ?? '',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black45),
          ),
        ),
      ],
    ),
  );


}

Widget _loadingWidget() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget imageDialog({required String name, required String assetImage}) {
  return Dialog(
    child: Container(
      padding: const EdgeInsets.only(top: 12),
      width: 200,
      height: 265,
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(assetImage), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              name,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}