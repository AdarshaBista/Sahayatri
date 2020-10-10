import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/debouncer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destinations_cubit/destinations_cubit.dart';

import 'package:sahayatri/ui/widgets/common/search_box.dart';

class SearchCard extends StatelessWidget implements PreferredSizeWidget {
  final double elevation;

  const SearchCard({
    @required this.elevation,
  }) : assert(elevation != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12.0),
        SearchBox(
          elevation: elevation,
          hintText: 'Where do you want to go?',
          onChanged: (query) => Debouncer().run(
            () => context.bloc<DestinationsCubit>().search(query),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
