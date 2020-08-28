import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class ContactList extends StatelessWidget {
  const ContactList();

  @override
  Widget build(BuildContext context) {
    final contactNumbers = context.watch<Lodge>().contactNumbers;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Numbers',
            style: AppTextStyles.medium.bold,
          ),
          const SizedBox(height: 8.0),
          ...contactNumbers.map((n) => _buildNumber(context, n)).toList(),
        ],
      ),
    );
  }

  Widget _buildNumber(BuildContext context, String number) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      leading: const CircleAvatar(
        radius: 14.0,
        backgroundColor: AppColors.lightAccent,
        child: Icon(
          Icons.phone,
          size: 14.0,
          color: Colors.black54,
        ),
      ),
      title: Text(
        number,
        style: AppTextStyles.small,
      ),
      trailing: GestureDetector(
        onTap: () => _launchPhone(context, number),
        child: Text(
          'Call',
          style: AppTextStyles.small.primary,
        ),
      ),
    );
  }

  Future<void> _launchPhone(BuildContext context, String number) async {
    final String scheme = 'tel:$number';
    if (await canLaunch(scheme)) {
      await launch(scheme);
    } else {
      context.openSnackBar('Could not  open dialer!');
    }
  }
}
