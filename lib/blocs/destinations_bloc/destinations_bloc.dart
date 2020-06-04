import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'destinations_event.dart';
part 'destinations_state.dart';

class DestinationsBloc extends Bloc<DestinationsEvent, DestinationsState> {
  final ApiService apiService;

  List<Destination> _destinations;

  DestinationsBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  Stream<Transition<DestinationsEvent, DestinationsState>> transformEvents(
    Stream<DestinationsEvent> events,
    TransitionFunction<DestinationsEvent, DestinationsState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(Duration(milliseconds: 300)),
      transitionFn,
    );
  }

  @override
  DestinationsState get initialState => DestinationsEmpty();

  @override
  Stream<DestinationsState> mapEventToState(DestinationsEvent event) async* {
    if (event is DestinationsFetched) yield* _mapDestinationsFetchedToState();
    if (event is DestinationsSearched)
      yield* _mapDestinationsSearchedToState(event.query);
  }

  Stream<DestinationsState> _mapDestinationsFetchedToState() async* {
    yield DestinationsLoading();
    try {
      _destinations = await apiService.fetchDestinations();
      yield DestinationsSuccess(destinations: _destinations);
    } on Failure catch (e) {
      print(e.error);
      yield DestinationsError(message: e.message);
    }
  }

  Stream<DestinationsState> _mapDestinationsSearchedToState(
      String query) async* {
    if (query.isEmpty) {
      yield DestinationsSuccess(destinations: _destinations);
      return;
    }

    yield DestinationsLoading();
    final searchedDestinations = _destinations
        .where(
          (d) => d.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    if (searchedDestinations.isEmpty) {
      yield DestinationsEmpty();
      return;
    }

    yield DestinationsSuccess(destinations: searchedDestinations);
  }
}
