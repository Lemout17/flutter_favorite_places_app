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
      body: Center(
        child: Text(
          place.title,
          style: theme.textTheme.bodyLarge!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
