import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/form/contact_form.dart';
import 'package:sahayatri/ui/shared/nearby/nearby_form.dart';
import 'package:sahayatri/ui/shared/widgets/curved_appbar.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';

class TrackerSetup extends StatefulWidget {
  const TrackerSetup();

  @override
  _TrackerSetupState createState() => _TrackerSetupState();
}

class _TrackerSetupState extends State<TrackerSetup> {
  int currentStep = 0;

  List<Step> get steps => [
        _buildStep(
          title: 'Setup nearby network',
          index: 1,
          content: const NearbyForm(isOnSettings: false),
        ),
        _buildStep(
          title: 'Choose a contact',
          index: 0,
          content: const ContactForm(isOnSettings: false),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppbar(title: 'Review your settings'),
      floatingActionButton: _buildStartButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FadeAnimator(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 72.0),
          child: Stepper(
            steps: steps,
            onStepTapped: (index) => setState(() => currentStep = index),
            currentStep: currentStep,
            physics: const BouncingScrollPhysics(),
            controlsBuilder: (_, {onStepCancel, onStepContinue}) => const Offstage(),
          ),
        ),
      ),
    );
  }

  Step _buildStep({String title, Widget content, int index}) {
    return Step(
      content: content,
      isActive: currentStep == index,
      title: Text(
        title,
        style: AppTextStyles.medium.bold,
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        'START',
        style: AppTextStyles.small.primary.bold,
      ),
      onPressed: () => context
          .bloc<TrackerCubit>()
          .startTracking(context.bloc<DestinationCubit>().destination),
    );
  }
}
