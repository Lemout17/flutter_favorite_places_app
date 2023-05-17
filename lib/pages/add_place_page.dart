import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/models/place.dart';
import 'package:flutter_favorite_places_app/providers/user_places.dart';
import 'package:flutter_favorite_places_app/widgets/image_input.dart';
import 'package:flutter_favorite_places_app/widgets/location_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlacePage extends ConsumerStatefulWidget {
  const AddPlacePage({super.key});

  @override
  ConsumerState<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends ConsumerState<AddPlacePage> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add new place')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              controller: _titleController,
              style: TextStyle(color: theme.colorScheme.onBackground),
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(onPickImage: onPickImage),
            const SizedBox(
              height: 10,
            ),
            LocationInput(onPickLocation: onPickLocation),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              label: const Text('Save place'),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('U can\'t add empty title of place!'),
        ),
      );
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(
          enteredTitle,
          _pickedImage!,
          _pickedLocation!,
        );
    Navigator.of(context).pop();
  }

  void onPickImage(File image) {
    _pickedImage = image;
  }

  void onPickLocation(PlaceLocation location) {
    _pickedLocation = location;
  }
}
