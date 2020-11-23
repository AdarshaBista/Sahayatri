import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/curved_appbar.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';

class LodgeRoomsPage extends StatelessWidget {
  const LodgeRoomsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppbar(title: 'Rooms'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdaptiveImage(
                'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                height: 220.0,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deluxe Room',
                          style: AppTextStyles.headline5.bold.serif,
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(
                              'Rs. 4000',
                              style: AppTextStyles.headline3.serif,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '/ per night',
                              style: AppTextStyles.headline6,
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomButton(
                      label: 'BOOK',
                      color: AppColors.dark,
                      backgroundColor: AppColors.primaryLight,
                      iconData: Icons.bookmark_outline,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ],
      ),
    );
  }
}
