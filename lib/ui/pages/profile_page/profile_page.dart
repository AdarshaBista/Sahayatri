import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/shared/dialogs/message_dialog.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/widgets/curved_appbar.dart';
import 'package:sahayatri/ui/shared/widgets/unauthenticated_view.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/logout_button.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/header/profile_header.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/settings/settings_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppbar(
        title: 'Profile',
        actions: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is Authenticated) return const LogoutButton();
              return const Offstage();
            },
          )
        ],
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is AuthError) {
            MessageDialog(message: state.message).openDialog(context);
          }
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
        SettingsList(),
      ],
    );
  }
}
