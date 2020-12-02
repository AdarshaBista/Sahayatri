import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/extensions/index.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/widgets/tools/tools_list.dart';
import 'package:sahayatri/ui/widgets/common/nested_tab_view.dart';
import 'package:sahayatri/ui/widgets/common/unauthenticated_view.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/settings_list.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/header/profile_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is AuthError) {
            context.openFlushBar(state.message, type: FlushbarType.error);
          }
        },
        builder: (context, state) {
          if (state is Authenticated) {
            return Provider<User>.value(
              value: state.user,
              child: _buildPage(),
            );
          }

          return const Center(child: UnauthenticatedView());
        },
      ),
    );
  }

  Widget _buildPage() {
    return NestedScrollView(
      headerSliverBuilder: (context, _) => [const ProfileHeader()],
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 8.0),
        children: [
          _buildTabView(),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    return NestedTabView(
      tabs: [
        NestedTabData(
          label: 'Tools',
          icon: Icons.handyman_outlined,
        ),
        NestedTabData(
          label: 'Settings',
          icon: Icons.settings_outlined,
        ),
      ],
      children: const [
        ToolsList(),
        SettingsList(),
      ],
    );
  }
}
