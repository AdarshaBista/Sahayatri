import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/nearby_bloc/nearby_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_actions.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_progress_info.dart';

class NearbyForm extends StatelessWidget {
  final bool isOnSettings;

  const NearbyForm({
    @required this.isOnSettings,
  }) : assert(isOnSettings != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      curve: Curves.decelerate,
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      child: FadeAnimator(
        child: SlideAnimator(
          begin: const Offset(0.0, 1.0),
          child: isOnSettings
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: Scaffold(
                    body: _buildColumn(context),
                  ),
                )
              : _buildColumn(context),
        ),
      ),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: isOnSettings
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      children: [
        Text(
          'Nearby',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 12.0),
        _buildBody(),
      ],
    );
  }

  Widget _buildBody() {
    return BlocConsumer<NearbyBloc, NearbyState>(
      listener: (context, state) {
        if (state is NearbyError) _showSnackBar(context, state.message);
      },
      builder: (context, state) {
        if (state is NearbyInProgress) {
          return Provider<NearbyInProgress>(
            create: (_) => state,
            child: const NearbyProgressInfo(),
          );
        } else {
          return const NearbyActions();
        }
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.small.light,
          ),
        ),
      );
  }
}
