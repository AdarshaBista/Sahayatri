import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/nested_tab_view.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildForm(),
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

  Widget _buildForm() {
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
          _buildSkipButton(),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    return NestedTabView(
      isCentered: true,
      isTabFilled: true,
      tabBarPadding: EdgeInsets.zero,
      tabs: [
        NestedTabData(label: 'Login', icon: Icons.login_outlined),
        NestedTabData(label: 'Sign Up', icon: Icons.app_registration),
      ],
      children: [
        AuthForm(
          buttonLabel: 'LOGIN',
          buttonIcon: Icons.login_outlined,
          onSubmit: () {},
        ),
        AuthForm(
          buttonLabel: 'SIGN UP',
          buttonIcon: Icons.app_registration,
          onSubmit: () {},
        ),
      ],
    );
  }

  Widget _buildSkipButton() {
    return FlatButton(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        'Continue without signing in...',
        style: AppTextStyles.extraSmall.lightAccent,
      ),
      onPressed: () {},
    );
  }
}
