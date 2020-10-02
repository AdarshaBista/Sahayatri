import 'package:meta/meta.dart';

import 'package:image_picker/image_picker.dart';

import 'package:bloc/bloc.dart';
import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/cubits/destination_update_cubit/destination_update_cubit.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/destination_update.dart';

part 'destination_update_form_state.dart';

class DestinationUpdateFormCubit extends Cubit<DestinationUpdateFormState> {
  final ApiService apiService;
  final Destination destination;
  final DestinationUpdateCubit destinationUpdateCubit;

  DestinationUpdateFormCubit({
    @required this.apiService,
    @required this.destination,
    @required this.destinationUpdateCubit,
  })  : assert(apiService != null),
        assert(destination != null),
        assert(destinationUpdateCubit != null),
        super(
          DestinationUpdateFormState(
            text: '',
            tags: [],
            coords: [],
            imageUrls: [],
          ),
        );

  DestinationUpdate get update => state.update;

  void changeText(String text) {
    emit(state.copyWith(text: text));
  }

  void updateTags(String tag) {
    final tags = List<String>.from(state.tags);
    if (tags.contains(tag)) {
      tags.remove(tag);
      emit(state.copyWith(tags: tags));
    } else {
      tags.add(tag);
      emit(state.copyWith(tags: tags));
    }
  }

  void updateCoords(Coord coord) {
    final coords = List<Coord>.from(state.coords);
    if (coords.contains(coord)) {
      coords.remove(coord);
      emit(state.copyWith(coords: coords));
    } else {
      coords.add(coord);
      emit(state.copyWith(coords: coords));
    }
  }

  void addImageUrl(String imageUrl) {
    final imageUrls = List<String>.from(state.imageUrls);
    imageUrls.add(imageUrl);
    emit(state.copyWith(imageUrls: imageUrls));
  }

  void removeImageUrl(String imageUrl) {
    final imageUrls = List<String>.from(state.imageUrls);
    imageUrls.remove(imageUrl);
    emit(state.copyWith(imageUrls: imageUrls));
  }

  Future<void> selectImage(ImageSource source) async {
    final pickedImage = await ImagePicker().getImage(source: source);
    if (pickedImage == null) return false;
    addImageUrl(pickedImage.path);
  }

  Future<bool> postUpdate() async {
    if (destinationUpdateCubit.user == null) return false;

    try {
      emit(state.copyWith(isLoading: true, message: 'Posting update...'));
      var update = state.update.copyWith(user: destinationUpdateCubit.user);
      update = await apiService.postUpdate(update, destination.id);
      destination.updates ??= [];
      destination.updates.insert(0, update);
      destinationUpdateCubit.emit(DestinationUpdateLoaded(updates: destination.updates));
      return true;
    } on Failure {
      emit(state.copyWith(isLoading: false, message: 'Failed to post update!'));
      return false;
    }
  }
}
