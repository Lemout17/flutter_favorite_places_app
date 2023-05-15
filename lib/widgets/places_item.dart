import 'package:flutter/material.dart';

class PlacesItem extends StatelessWidget {
  final String title;
  const PlacesItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListTile(
      title: Text(
        title,
        style: theme.textTheme.titleMedium!.copyWith(
          color: theme.colorScheme.onBackground,
        ),
      ),
    );
  }
}
