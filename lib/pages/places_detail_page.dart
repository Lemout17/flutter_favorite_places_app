import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/api/apiService.dart';
import 'package:flutter_favorite_places_app/models/place.dart';

class PlacesDetailPage extends StatefulWidget {
  final Place place;
  const PlacesDetailPage({super.key, required this.place});

  @override
  State<PlacesDetailPage> createState() => _PlacesDetailPageState();
}

class _PlacesDetailPageState extends State<PlacesDetailPage> {
  String? _imageLocation;

  @override
  void initState() {
    super.initState();

    _getLocationImage();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Widget content;

    if (_imageLocation != null) {
      content = CircleAvatar(
        radius: 70,
        backgroundImage: NetworkImage(_imageLocation!),
      );
    } else {
      content = const CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.place.title,
        ),
      ),
      body: Stack(
        children: [
          Image.file(
            widget.place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                content,
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    widget.place.location.address,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _getLocationImage() {
    ApiService()
        .getLocationImage(
      widget.place.location.latitude,
      widget.place.location.longitude,
    )
        .then((result) {
      setState(() {
        _imageLocation = result;
      });
    });
  }
}
