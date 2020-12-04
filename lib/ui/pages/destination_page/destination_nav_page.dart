import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/routers/destination_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DestinationNavPage extends StatelessWidget {
  const DestinationNavPage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!context.read<DestinationNavService>().canPop()) return true;
        context.read<DestinationNavService>().pop();
        return false;
      },
      child: Navigator(
        key: RepositoryProvider.of<DestinationNavService>(context).navigatorKey,
        observers: [HeroController()],
        onGenerateRoute: DestinationRouter.onGenerateRoute,
      ),
    );
  }
}
