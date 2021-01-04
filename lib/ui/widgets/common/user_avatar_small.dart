import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';

class UserAvatarSmall extends StatelessWidget {
  final String username;
  final String imageUrl;

  const UserAvatarSmall({
    @required this.username,
    @required this.imageUrl,
  }) : assert(username != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66.0,
      height: 66.0,
      child: ElevatedCard(
        margin: const EdgeInsets.all(12.0),
        color: AppColors.primaryDark,
        child: imageUrl != null
            ? AdaptiveImage(imageUrl, showLoading: false)
            : Center(
                child: Text(
                  username[0].toUpperCase(),
                  style: AppTextStyles.headline3.serif.light,
                ),
              ),
      ),
    );
  }
}
