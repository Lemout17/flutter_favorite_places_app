import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/api/apiService.dart';
import 'package:flutter_favorite_places_app/models/place.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final void Function(PlaceLocation location) onPickLocation;
  const LocationInput({super.key, required this.onPickLocation});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;
  String? _locationImage;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onBackground,
      ),
    );

    if (_locationImage != null) {
      previewContent = Image.network(
        _locationImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            )
          ],
        ),
      ],
    );
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) return;

    final String address = await ApiService().getAddress(lat, lng);

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: lat,
        longitude: lng,
        address: address,
      );
      _isGettingLocation = false;
    });

    widget.onPickLocation(_pickedLocation!);

    if (_pickedLocation != null) {
      ApiService()
          .getLocationImage(
        _pickedLocation!.latitude,
        _pickedLocation!.longitude,
      )
          .then((result) {
        setState(() {
          _locationImage = result;
        });
      });
    }
  }
}
