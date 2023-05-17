import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/models/place.dart';

class PlacesDetailPage extends StatelessWidget {
  final Place place;
  const PlacesDetailPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.title,
        ),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
