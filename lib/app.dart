import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/pages/places_page.dart';
import 'package:flutter_favorite_places_app/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: AppTheme.theme,
      home: const PlacesPage(),
    );
  }
}
