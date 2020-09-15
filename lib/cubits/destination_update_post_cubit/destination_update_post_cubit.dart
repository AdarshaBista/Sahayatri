import 'package:meta/meta.dart';

import 'package:image_picker/image_picker.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/destination_update.dart';

part 'destination_update_post_state.dart';

class DestinationUpdatePostCubit extends Cubit<DestinationUpdatePostState> {
  DestinationUpdatePostCubit()
      : super(
          const DestinationUpdatePostState(
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
}
