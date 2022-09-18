import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/constants/images.dart';
import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/pages/auth_page/widgets/login_form.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/signup_form.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/views/nested_tab_view.dart';

import 'package:sahayatri/locator.dart';

class AuthPage extends StatelessWidget {
  final bool isInitial;

  const AuthPage({
    super.key,
    this.isInitial = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: _buildBackButton(context, state is AuthLoading),
          ),
          body: Stack(
            children: [
              AdaptiveImage(
                Images.authBackground,
                color: AppColors.dark.withOpacity(0.6),
              ),
              _buildForm(context, state is AuthLoading),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackButton(BuildContext context, bool isLoading) {
    final shouldShow = !isLoading && !isInitial;
    if (!shouldShow) return const SizedBox();

    return IconButton(
      splashRadius: 20.0,
      onPressed: Navigator.of(context).pop,
      icon: const Icon(
        AppIcons.back,
        size: 20.0,
        color: AppColors.light,
      ),
    );
  }

  Widget _buildForm(BuildContext context, bool isLoading) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Image.asset(
            Images.splash,
            width: 120.0,
            height: 120.0,
          ),
          const SizedBox(height: 32.0),
          _buildTabView(),
          const SizedBox(height: 16.0),
          if (isInitial && !isLoading) _buildSkipButton(),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    return NestedTabView(
      keepAlive: true,
      isCentered: true,
      isTabFilled: true,
      showIndicator: false,
      tabs: [
        NestedTabData(label: 'Login', icon: AppIcons.login),
        NestedTabData(label: 'Sign Up', icon: AppIcons.signUp),
      ],
      children: [
        LoginForm(isInitial: isInitial),
        SignUpForm(isInitial: isInitial),
      ],
    );
  }

  Widget _buildSkipButton() {
    return ScaleAnimator(
      child: CustomButton(
        icon: AppIcons.open,
        color: AppColors.light,
        backgroundColor: Colors.transparent,
        label: 'Continue without signing in...',
        onTap: () => locator<RootNavService>().pushReplacementNamed(Routes.homePageRoute),
      ),
    );
  }
}
