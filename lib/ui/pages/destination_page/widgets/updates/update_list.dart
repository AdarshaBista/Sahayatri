import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination_update.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/destination_update_cubit/destination_update_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/buttons/view_more_button.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/update_card.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/update_form.dart';

class UpdateList extends StatelessWidget {
  const UpdateList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (context.bloc<UserCubit>().isAuthenticated) _buildPostUpdateButton(context),
          const SizedBox(height: 8.0),
          _buildUpdates(context),
        ],
      ),
    );
  }

  Widget _buildPostUpdateButton(BuildContext context) {
    return CustomButton(
      label: 'Post an update',
      color: AppColors.primaryDark,
      backgroundColor: AppColors.primaryLight,
      iconData: Icons.post_add_outlined,
      onTap: () => UpdateForm(
        onSubmit: (update) => _postUpdate(context, update),
      ).openModalBottomSheet(context),
    );
  }

  Widget _buildUpdates(BuildContext context) {
    return BlocBuilder<DestinationUpdateCubit, DestinationUpdateState>(
      builder: (context, state) {
        if (state is DestinationUpdateError) {
          return ErrorIndicator(
            message: state.message,
            onRetry: context.bloc<DestinationUpdateCubit>().fetchUpdates,
          );
        } else if (state is DestinationUpdateLoaded) {
          return _buildList(context, state.updates);
        } else if (state is DestinationUpdateEmpty) {
          return EmptyIndicator(
            message: 'No updates yet.',
            onRetry: context.bloc<DestinationUpdateCubit>().fetchUpdates,
          );
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<DestinationUpdate> updates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: updates.length,
          itemBuilder: (context, index) {
            return UpdateCard(update: updates[index]);
          },
        ),
        ViewMoreButton(
          hasMore: context.bloc<DestinationUpdateCubit>().hasMore,
          onLoadMore: context.bloc<DestinationUpdateCubit>().loadMore,
        ),
      ],
    );
  }

  Future<void> _postUpdate(BuildContext context, DestinationUpdate update) async {
    context.openSnackBar('Posting update...');
    final bool success = await context.bloc<DestinationUpdateCubit>().postUpdate(update);

    if (success) {
      context.openSnackBar('Update posted');
    } else {
      context.openSnackBar('Failed to post update!');
    }
  }
}