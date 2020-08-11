import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/nested_tab_view.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/login_form.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/signup_form.dart';

class AuthPage extends StatelessWidget {
  final bool isInitial;

  const AuthPage({
    this.isInitial = true,
  }) : assert(isInitial != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          _buildBackground(),
          _buildForm(context),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Image.asset(
      Images.kAuthBackground,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      colorBlendMode: BlendMode.srcATop,
      color: AppColors.primary.withOpacity(0.6),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Image.asset(
            Images.kSplash,
            width: 120.0,
            height: 120.0,
          ),
          const SizedBox(height: 32.0),
          _buildTabView(),
          if (isInitial) _buildSkipButton(context),
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

  Widget _buildSkipButton(BuildContext context) {
    return FlatButton(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        'Continue without signing in...',
        style: AppTextStyles.extraSmall.lightAccent,
      ),
      onPressed: () {
        context.repository<RootNavService>().pushReplacementNamed(Routes.kHomePageRoute);
      },
    );
  }
}
