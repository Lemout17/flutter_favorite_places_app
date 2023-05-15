import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/pages/add_place_page.dart';
import 'package:flutter_favorite_places_app/widgets/places_list.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () => addPlace(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const PlacesList(placesList: []),
    );
  }

  void addPlace(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddPlacePage(),
      ),
    );
  }
}
