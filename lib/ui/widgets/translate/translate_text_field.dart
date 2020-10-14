import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';

class TranslateTextField extends StatefulWidget {
  const TranslateTextField();

  @override
  _TranslateTextFieldState createState() => _TranslateTextFieldState();
}

class _TranslateTextFieldState extends State<TranslateTextField> {
  FocusNode sourceNode;
  TextEditingController sourceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sourceNode = FocusNode();
    sourceNode.requestFocus();
  }

  @override
  void dispose() {
    sourceNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideAnimator(
      begin: const Offset(0.0, 2.0),
      child: ElevatedCard(
        margin: const EdgeInsets.only(left: 24.0, bottom: 16.0, right: 24.0),
        radius: 50.0,
        child: Row(
          children: [
            const SizedBox(width: 8.0),
            Expanded(child: _buildTextField()),
            _buildTranslateState(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: TextFormField(
        focusNode: sourceNode,
        style: AppTextStyles.small,
        controller: sourceController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          fillColor: Colors.transparent,
          hintText: 'Type Something...',
        ),
      ),
    );
  }

  Widget _buildTranslateState() {
    return BlocBuilder<TranslateCubit, TranslateState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SizedBox(
            width: 44.0,
            height: 44.0,
            child: CircularBusyIndicator(),
          );
        }
        return _buildTranslateButton(context);
      },
    );
  }

  Widget _buildTranslateButton(BuildContext context) {
    return Container(
      color: AppColors.primaryDark,
      child: IconButton(
        splashRadius: 24.0,
        icon: const Icon(
          Icons.send,
          size: 22.0,
          color: AppColors.light,
        ),
        onPressed: () {
          final source = sourceController.text.trim();
          if (source.isEmpty) return;
          setState(() => sourceController.clear());
          context.bloc<TranslateCubit>().translate(source, 'English');
        },
      ),
    );
  }
}
