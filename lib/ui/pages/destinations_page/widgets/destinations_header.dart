import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/debouncer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destinations_cubit/destinations_cubit.dart';

import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/common/search_box.dart';

class DestinationsHeader extends StatelessWidget {
  const DestinationsHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        const Header(
          title: 'Destinations',
          padding: 20.0,
          fontSize: 36.0,
        ),
        const SizedBox(height: 12.0),
        BlocBuilder<DestinationsCubit, DestinationsState>(
          builder: (context, state) {
            if (state is DestinationsLoaded) {
              return SearchBox(
                hintText: 'Where do you want to go?',
                onChanged: (query) => Debouncer().run(
                  () => context.read<DestinationsCubit>().search(query),
                ),
              );
            }
            return const Offstage();
          },
        ),
      ],
    );
  }
}
