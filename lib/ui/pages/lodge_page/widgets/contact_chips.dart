import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class ContactChips extends StatelessWidget {
  const ContactChips();

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
          Wrap(
            spacing: 8.0,
            children: contactNumbers
                .map(
                  (number) => ScaleAnimator(
                    child: GestureDetector(
                      onTap: () => _launchPhone(context, number),
                      child: Chip(
                        backgroundColor: AppColors.lightAccent,
                        visualDensity: VisualDensity.compact,
                        label: _buildNumber(number),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNumber(String number) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.phone,
          size: 14.0,
          color: Colors.black54,
        ),
        const SizedBox(width: 6.0),
        Text(
          number,
          style: AppTextStyles.extraSmall,
        ),
      ],
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
