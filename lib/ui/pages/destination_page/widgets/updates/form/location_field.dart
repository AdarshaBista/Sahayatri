import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class LocationField extends StatefulWidget {
  const LocationField();

  @override
  _LocationFieldState createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  List<Coord> coords;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Location',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
