import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/tools/tools_list.dart';
import 'package:sahayatri/ui/widgets/views/nested_tab_view.dart';
import 'package:sahayatri/ui/widgets/views/collapsible_view.dart';
import 'package:sahayatri/ui/widgets/views/unauthenticated_view.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/header/profile_header.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/preferences/preferences_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
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
    return CollapsibleView(
      collapsible: const ProfileHeader(),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 8.0),
        children: [_buildTabView()],
      ),
    );
  }

  Widget _buildTabView() {
    return NestedTabView(
      tabs: [
        NestedTabData(
          label: 'Tools',
          icon: AppIcons.tools,
        ),
        NestedTabData(
          label: 'Preferences',
          icon: AppIcons.preferences,
        ),
      ],
      children: const [
        ToolsList(),
        PreferencesList(),
      ],
    );
  }
}
