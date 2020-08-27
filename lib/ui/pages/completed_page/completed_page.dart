import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/shared/widgets/header.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/widgets/unauthenticated_view.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return _buildPage();
            }
            return const Center(child: UnauthenticatedView());
          },
        ),
      ),
    );
  }

  Widget _buildPage() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        Header(boldTitle: 'Completed'),
        EmptyIndicator(message: 'No completed destinations.'),
      ],
    );
  }
}
