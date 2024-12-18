import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/models/destination_update.dart';

import 'package:sahayatri/cubits/destination_update_cubit/destination_update_cubit.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/update_form.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/update_card.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/buttons/view_more_button.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';

class UpdateList extends StatelessWidget {
  const UpdateList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPostUpdateButton(context),
          const SizedBox(height: 12.0),
          _buildUpdates(context),
        ],
      ),
    );
  }

  Widget _buildPostUpdateButton(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is! Authenticated) return const SizedBox();
        return CustomButton(
          label: 'Post an update',
          icon: AppIcons.addUpdate,
          onTap: () => const UpdateForm().openModalBottomSheet(context, enableDrag: false),
        );
      },
    );
  }

  Widget _buildUpdates(BuildContext context) {
    return BlocBuilder<DestinationUpdateCubit, DestinationUpdateState>(
      builder: (context, state) {
        if (state is DestinationUpdateError) {
          return ErrorIndicator(
            message: state.message,
            onRetry: () => context.read<DestinationUpdateCubit>().fetchUpdates(),
          );
        } else if (state is DestinationUpdateLoaded) {
          return _buildList(context, state.updates);
        } else if (state is DestinationUpdateEmpty) {
          return EmptyIndicator(
            message: 'No updates yet.',
            onRetry: () => context.read<DestinationUpdateCubit>().fetchUpdates(),
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
          hasMore: BlocProvider.of<DestinationUpdateCubit>(context).hasMore,
          onLoadMore: () => context.read<DestinationUpdateCubit>().loadMore(),
        ),
      ],
    );
  }
}
