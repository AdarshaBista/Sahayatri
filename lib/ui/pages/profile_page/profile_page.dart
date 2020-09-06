import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/dialogs/message_dialog.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/widgets/nested_tab_view.dart';
import 'package:sahayatri/ui/shared/widgets/unauthenticated_view.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/header/profile_header.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/settings/settings_list.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/downloaded/downloaded_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: _buildPage(),
            );
          } else if (state is AuthLoading) {
            return const BusyIndicator();
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
          label: 'Settings',
          icon: Icons.settings_outlined,
        ),
        NestedTabData(
          label: 'Downloaded',
          icon: CommunityMaterialIcons.cloud_check_outline,
        ),
      ],
      children: const [
        SettingsList(),
        DownloadedList(),
      ],
    );
  }
}
