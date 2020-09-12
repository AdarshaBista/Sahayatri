import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination_update.dart';

class UpdateCard extends StatelessWidget {
  final DestinationUpdate update;

  const UpdateCard({
    @required this.update,
  }) : assert(update != null);

  @override
  Widget build(BuildContext context) {
    return Text(update.text);
  }
}
