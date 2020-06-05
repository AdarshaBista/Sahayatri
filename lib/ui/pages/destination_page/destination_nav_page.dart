import 'package:flutter/material.dart';

import 'package:sahayatri/app/routers/destination_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

class DestinationNavPage extends StatelessWidget {
  const DestinationNavPage();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: context.repository<DestinationNavService>().navigatorKey,
      observers: [HeroController()],
      onGenerateRoute: DestRouter.onGenerateRoute,
    );
  }
}
