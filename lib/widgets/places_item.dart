import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/models/place.dart';
import 'package:flutter_favorite_places_app/pages/places_detail_page.dart';

class PlacesItem extends StatelessWidget {
  final String title;
  final Place place;
  const PlacesItem({super.key, required this.title, required this.place});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: FileImage(place.image),
      ),
      title: Text(
        title.substring(0, 1).toUpperCase() + title.substring(1),
        style: theme.textTheme.titleMedium!.copyWith(
          color: theme.colorScheme.onBackground,
        ),
      ),
      subtitle: Text(
        place.location.address,
        style: theme.textTheme.bodySmall!.copyWith(
          color: theme.colorScheme.onBackground,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlacesDetailPage(place: place),
          ),
        );
      },
    );
  }
}
