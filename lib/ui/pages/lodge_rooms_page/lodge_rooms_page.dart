import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/curved_appbar.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';

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
              Image.network(
                'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                fit: BoxFit.cover,
                height: 220.0,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deluxe Room',
                          style: AppTextStyles.small.bold.serif,
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(
                              'Rs. 4000',
                              style: AppTextStyles.large,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '/ per night',
                              style: AppTextStyles.extraSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomButton(
                      label: 'BOOK',
                      color: AppColors.dark,
                      backgroundColor: AppColors.primary.withOpacity(0.5),
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
