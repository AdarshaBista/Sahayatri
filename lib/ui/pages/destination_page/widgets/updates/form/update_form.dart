import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination_update.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_post_cubit/destination_update_post_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/tags_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/update_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/images_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/location_field.dart';

class UpdateForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final void Function(DestinationUpdate) onSubmit;

  UpdateForm({
    @required this.onSubmit,
  }) : assert(onSubmit != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DestinationUpdatePostCubit>(
      create: (_) => DestinationUpdatePostCubit(),
      child: AnimatedPadding(
        curve: Curves.decelerate,
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 200),
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            children: [
              Text('Post an Update', style: AppTextStyles.medium.bold),
              const Divider(height: 16.0),
              TagsField(),
              const SizedBox(height: 16.0),
              const LocationField(),
              const SizedBox(height: 12.0),
              const ImagesField(),
              const SizedBox(height: 12.0),
              const UpdateField(),
              const SizedBox(height: 4.0),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Builder(
      builder: (context) {
        return FloatingActionButton(
          mini: true,
          backgroundColor: AppColors.dark,
          child: const Icon(
            Icons.check,
            size: 24.0,
            color: AppColors.primary,
          ),
          onPressed: () {
            if (!formKey.currentState.validate()) return;

            onSubmit(context.bloc<DestinationUpdatePostCubit>().update);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
