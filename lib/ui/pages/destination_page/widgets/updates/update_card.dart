import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/dialog_extension.dart';

import 'package:sahayatri/core/models/destination_update.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/icon_label.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/user_avatar_square.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/tag_chip.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/image_list.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/update_map_dialog.dart';

class UpdateCard extends StatelessWidget {
  final DestinationUpdate update;

  const UpdateCard({
    @required this.update,
  }) : assert(update != null);

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      radius: 8.0,
      margin: const EdgeInsets.only(bottom: 12.0),
      child: FadeAnimator(
        child: Container(
          padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildUserInfo(context),
              if (update.tags.isNotEmpty) ...[
                _buildTags(),
                const SizedBox(height: 8.0),
              ],
              _buildText(context),
              if (update.imageUrls.isNotEmpty) ...[
                const SizedBox(height: 10.0),
                ImageList(imageUrls: update.imageUrls),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Row(
      children: [
        UserAvatarSquare(
          username: update.user.name,
          imageUrl: update.user.imageUrl,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              update.user.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.t.headline5.bold,
            ),
            const SizedBox(height: 2.0),
            Text(
              update.timeAgo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.t.headline6,
            ),
          ],
        ),
        if (update.coords.isNotEmpty) ...[
          const Spacer(),
          _buildLocationButton(context),
        ],
      ],
    );
  }

  Widget _buildTags() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: update.tags.map((t) => TagChip(label: t)).toList(),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        update.text,
        style: context.t.headline5,
      ),
    );
  }

  Widget _buildLocationButton(BuildContext context) {
    return GestureDetector(
      onTap: () => UpdateMapDialog(coords: update.coords).openDialog(context),
      child: CustomCard(
        borderRadius: 32.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: IconLabel(
          gap: 2.0,
          iconSize: 16.0,
          icon: AppIcons.location,
          iconColor: AppColors.secondary,
          label: update.coords.length.toString(),
          labelStyle: context.t.headline5.bold.withColor(AppColors.secondary),
        ),
      ),
    );
  }
}
