import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/core/models/destination_update.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';
import 'package:sahayatri/ui/widgets/common/user_avatar_small.dart';
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
        UserAvatarSmall(
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CircularButton(
        color: AppColors.secondary,
        icon: Icons.location_on_outlined,
        backgroundColor: context.c.surface,
        onTap: () => UpdateMapDialog(coords: update.coords).openDialog(context),
      ),
    );
  }
}
