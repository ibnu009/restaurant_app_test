import 'package:flutter/material.dart';
import 'package:restaurant_app/data/config/api_config.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final apiConfig = ApiConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: apiConfig.fetchListRestaurant(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _loadingWidget();
            }
            List<Restaurant> data = snapshot.data?.restaurants ?? [];
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) {
                  return _restaurantItem(data[index]);
                });
          }),
    );
  }

  Widget _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _restaurantItem(Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                DetailRestaurantScreen(idRestaurant: restaurant.id ?? ''),
          ),
        );
      },
      child: Card(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network("$mediumImage/${restaurant.pictureId}",
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name ?? '',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.place,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            restaurant.city ?? '',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_border,
                            color: Colors.orangeAccent,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        restaurant.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
