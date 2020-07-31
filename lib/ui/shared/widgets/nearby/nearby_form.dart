import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/nearby_bloc/nearby_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_status.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_actions.dart';

class NearbyForm extends StatelessWidget {
  const NearbyForm();

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      curve: Curves.decelerate,
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      child: FadeAnimator(
        child: SlideAnimator(
          begin: const Offset(0.0, 1.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nearby',
                style: AppTextStyles.small.bold,
              ),
              const SizedBox(height: 12.0),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<NearbyBloc, NearbyState>(
      listener: (context, state) {
        if (state is NearbyError) _showSnackBar(context, state.message);
      },
      builder: (context, state) {
        if (state is NearbyInProgress) {
          return NearbyStatus(connected: state.connected);
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
