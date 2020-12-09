import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/app/constants/images.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/common/nested_tab_view.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/login_form.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/signup_form.dart';

class AuthPage extends StatelessWidget {
  final bool isInitial;

  const AuthPage({
    this.isInitial = true,
  }) : assert(isInitial != null);

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
    if (!shouldShow) return const Offstage();

    return IconButton(
      splashRadius: 20.0,
      onPressed: Navigator.of(context).pop,
      icon: const Icon(
        Icons.keyboard_backspace,
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
      tabBarPadding: EdgeInsets.zero,
      tabs: [
        NestedTabData(label: 'Login', icon: Icons.login_outlined),
        NestedTabData(label: 'Sign Up', icon: Icons.app_registration),
      ],
      children: [
        LoginForm(isInitial: isInitial),
        SignUpForm(isInitial: isInitial),
      ],
    );
  }

  Widget _buildSkipButton() {
    return ScaleAnimator(
      child: FlatButton(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Text(
          'Continue without signing in...',
          style: AppTextStyles.headline6.lightAccent,
        ),
        onPressed: () =>
            locator<RootNavService>().pushReplacementNamed(Routes.homePageRoute),
      ),
    );
  }
}
