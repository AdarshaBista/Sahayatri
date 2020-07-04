import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/resources.dart';

class UserMarker extends StatelessWidget {
  final double angle;

  const UserMarker({
    @required this.angle,
  }) : assert(angle != null);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Image.asset(
        Images.kUserMarker,
        width: 24.0,
        height: 24.0,
      ),
    );
  }
}
