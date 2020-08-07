import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/debouncer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destinations_cubit/destinations_cubit.dart';

import 'package:sahayatri/ui/shared/widgets/header.dart';
import 'package:sahayatri/ui/shared/widgets/search_box.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/pages/destinations_page/widgets/destinations_list.dart';

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
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: _buildSearchBox(context),
        ),
        body: _buildBody(),
      ),
    );
  }

  Column _buildSearchBox(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12.0),
        SearchBox(
          elevation: searchElevation,
          hintText: 'Where do you want to go?',
          onChanged: (query) => Debouncer().run(
            () => context.bloc<DestinationsCubit>().search(query),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return ListView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      children: [
        const Header(title: 'Choose your', boldTitle: 'Destination'),
        const SizedBox(height: 8.0),
        BlocBuilder<DestinationsCubit, DestinationsState>(
          builder: (context, state) {
            if (state is DestinationsError) {
              return ErrorIndicator(message: state.message);
            } else if (state is DestinationsLoading) {
              return const BusyIndicator();
            } else if (state is DestinationsSuccess) {
              return DestinationsList(destinations: state.destinations);
            } else {
              return const EmptyIndicator();
            }
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
