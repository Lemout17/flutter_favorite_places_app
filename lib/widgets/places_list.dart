import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/models/place.dart';
import 'package:flutter_favorite_places_app/widgets/places_item.dart';

class PlacesList extends StatelessWidget {
  final List<Place> placesList;
  const PlacesList({super.key, required this.placesList});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (placesList.isEmpty) {
      return Center(
        child: Text(
          'No places added yet...',
          style: theme.textTheme.bodyLarge!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) =>
          PlacesItem(title: placesList[index].title),
      itemCount: placesList.length,
    );
  }
}
