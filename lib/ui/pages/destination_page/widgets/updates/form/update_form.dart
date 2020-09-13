import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/tags_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/update_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/location_field.dart';

class UpdateForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final void Function(String, List<Coord>, List<String>, List<String>) onSubmit;

  UpdateForm({
    @required this.onSubmit,
  }) : assert(onSubmit != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
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
            const SizedBox(height: 16.0),
            const UpdateField(),
            const SizedBox(height: 16.0),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
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
        Navigator.of(context).pop();
      },
    );
  }
}
