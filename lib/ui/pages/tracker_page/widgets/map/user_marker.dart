import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/resources.dart';

class UserMarker extends StatelessWidget {
  const UserMarker();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Images.kUserMarker,
      width: 24.0,
      height: 24.0,
    );
  }
}
