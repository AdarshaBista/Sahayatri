import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/auth_cubit/auth_cubit.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/unauthenticated_view.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/profile_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) _showSnackBar(context, state.message);
        },
        builder: (context, state) {
          if (state is Authenticated) {
            return Provider<User>.value(
              value: state.user,
              child: _buildBody(),
            );
          } else if (state is AuthLoading) {
            return const BusyIndicator();
          }

          return const Center(child: UnauthenticatedView());
        },
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: const [
        ProfileHeader(),
      ],
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
