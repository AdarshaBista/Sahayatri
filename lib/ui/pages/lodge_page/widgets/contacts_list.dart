import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sahayatri/core/extensions/flushbar_extension.dart';
import 'package:sahayatri/core/models/lodge.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

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
            style: context.t.headlineSmall?.bold,
          ),
          const SizedBox(height: 8.0),
          ElevatedCard(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: contactNumbers
                  .map(
                    (n) => _buildNumber(context, n),
                  )
                  .toList(),
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
      leading: CircleAvatar(
        radius: 14.0,
        backgroundColor: AppColors.primaryLight,
        child: Icon(
          AppIcons.phone,
          size: 14.0,
          color: context.c.primaryContainer,
        ),
      ),
      title: Text(
        number,
        style: context.t.headlineSmall?.bold.serif,
      ),
      trailing: GestureDetector(
        onTap: () => _launchPhone(context, number),
        child: Text(
          'Call',
          style: context.t.headlineSmall?.primary,
        ),
      ),
    );
  }

  Future<void> _launchPhone(BuildContext context, String number) async {
    final scheme = Uri.parse('tel:$number');
    if (await canLaunchUrl(scheme)) {
      await launchUrl(scheme);
    } else {
      if (!context.mounted) return;
      context.openFlushBar('Could not  open dialer!', type: FlushbarType.error);
    }
  }
}
