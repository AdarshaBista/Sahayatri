import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/destination_update.dart';
import 'package:sahayatri/core/services/api_service.dart';

import 'package:sahayatri/cubits/destination_update_cubit/destination_update_cubit.dart';

import 'package:sahayatri/locator.dart';

part 'destination_update_form_state.dart';

class DestinationUpdateFormCubit extends Cubit<DestinationUpdateFormState> {
  final ApiService apiService = locator();
  final Destination destination;
  final DestinationUpdateCubit destinationUpdateCubit;

  DestinationUpdateFormCubit({
    required this.destination,
    required this.destinationUpdateCubit,
  }) : super(
          DestinationUpdateFormState(
            text: '',
            tags: [],
            coords: [],
            imageUrls: [],
          ),
        );

  DestinationUpdate get update => state.update;
  bool get isDirty => state.isDirty();

  void changeText(String text) {
    emit(state.copyWith(text: text));
  }

  void addTag(String tag) {
    if (state.tags.contains(tag)) return;

    final tags = List<String>.from(state.tags);
    tags.add(tag);
    emit(state.copyWith(tags: tags));
  }

  void removeTag(String tag) {
    final tags = List<String>.from(state.tags);
    tags.remove(tag);
    emit(state.copyWith(tags: tags));
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
    if (Platform.isWindows) return;

    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    addImageUrl(pickedImage.path);
  }

  Future<bool> postUpdate() async {
    if (destinationUpdateCubit.user == null) return false;

    try {
      emit(state.copyWith(isLoading: true, message: 'Posting update...'));
      var update = state.update.copyWith(user: destinationUpdateCubit.user);
      update = await apiService.postUpdate(update, destination.id);
      destination.updates ??= [];
      destination.updates?.insert(0, update);
      destinationUpdateCubit.emit(
        DestinationUpdateLoaded(updates: destination.updates ?? []),
      );
      return true;
    } on AppError {
      emit(state.copyWith(isLoading: false, message: 'Failed to post update!'));
      return false;
    }
  }
}
