import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destinations_cubit/destinations_cubit.dart';

import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/destinations/destinations_list.dart';
import 'package:sahayatri/ui/pages/destinations_page/widgets/search_card.dart';

class DestinationsPage extends StatefulWidget {
  const DestinationsPage();

  @override
  _DestinationsPageState createState() => _DestinationsPageState();
}

class _DestinationsPageState extends State<DestinationsPage> {
  double searchElevation = 0.0;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_elevateSearchBar);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _elevateSearchBar() {
    const double kMaxScrollPos = 100.0;
    const double kScaleFactor = 10.0;
    final double scrollPos = scrollController.position.pixels;

    if (scrollPos < kMaxScrollPos && scrollPos > 0.0 && mounted) {
      setState(() {
        searchElevation = scrollPos / kScaleFactor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DestinationsCubit, DestinationsState>(
        builder: (context, state) {
          if (state is DestinationsLoaded) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: SearchCard(elevation: searchElevation),
              body: _buildBody(),
            );
          } else {
            return Scaffold(body: _buildBody());
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: context.bloc<DestinationsCubit>().fetchDestinations,
      child: ListView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          const Header(padding: 12.0, boldTitle: 'Destinations'),
          const SizedBox(height: 8.0),
          BlocBuilder<DestinationsCubit, DestinationsState>(
            builder: (context, state) {
              if (state is DestinationsError) {
                return ErrorIndicator(
                  message: state.message,
                  onRetry: context.bloc<DestinationsCubit>().fetchDestinations,
                );
              } else if (state is DestinationsLoading) {
                return const BusyIndicator();
              } else if (state is DestinationsLoaded) {
                return DestinationsList(destinations: state.destinations);
              } else {
                return const EmptyIndicator(message: 'No destinations found!');
              }
            },
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
