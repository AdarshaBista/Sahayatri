import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class ConnectedList extends StatelessWidget {
  final List<String> connected;

  const ConnectedList({
    @required this.connected,
  }) : assert(connected != null);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: connected.length,
      itemBuilder: (context, index) {
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            connected[index],
            style: AppTextStyles.medium,
          ),
          leading: CircleAvatar(
            radius: 14.0,
            backgroundColor: AppColors.primary.withOpacity(0.4),
            child: Text(
              '${index + 1}',
              style: AppTextStyles.small.bold,
            ),
          ),
        );
      },
    );
  }
}
