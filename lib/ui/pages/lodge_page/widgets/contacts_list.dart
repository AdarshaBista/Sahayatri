import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/extensions/index.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';

class ContactList extends StatelessWidget {
  const ContactList();

  @override
  Widget build(BuildContext context) {
    final contactNumbers = context.select<Lodge, List<String>>((l) => l.contactNumbers);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Numbers',
            style: AppTextStyles.headline5.bold,
          ),
          const SizedBox(height: 16.0),
          ElevatedCard(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: contactNumbers.map((n) => _buildNumber(context, n)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumber(BuildContext context, String number) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      leading: const CircleAvatar(
        radius: 14.0,
        backgroundColor: AppColors.primaryLight,
        child: Icon(Icons.phone, size: 14.0, color: AppColors.primaryDark),
      ),
      title: Text(
        number,
        style: AppTextStyles.headline5.bold.serif,
      ),
      trailing: GestureDetector(
        onTap: () => _launchPhone(context, number),
        child: Text(
          'Call',
          style: AppTextStyles.headline5.primary,
        ),
      ),
    );
  }

  Future<void> _launchPhone(BuildContext context, String number) async {
    final String scheme = 'tel:$number';
    if (await canLaunch(scheme)) {
      await launch(scheme);
    } else {
      context.openFlushBar('Could not  open dialer!', type: FlushbarType.error);
    }
  }
}
