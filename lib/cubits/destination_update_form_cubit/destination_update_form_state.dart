part of 'destination_update_form_cubit.dart';

class DestinationUpdateFormState {
  final String? message;
  final bool isLoading;
  final String text;
  final List<String> tags;
  final List<Coord> coords;
  final List<String> imageUrls;

  DestinationUpdate get update => DestinationUpdate(
        text: text.trim(),
        tags: tags,
        coords: coords,
        imageUrls: imageUrls,
        dateUpdated: DateTime.now(),
      );

  DestinationUpdateFormState({
    this.message,
    this.isLoading = false,
    required this.text,
    required this.tags,
    required this.coords,
    required this.imageUrls,
  });

  DestinationUpdateFormState copyWith({
    String? message,
    bool? isLoading,
    String? text,
    List<String>? tags,
    List<Coord>? coords,
    List<String>? imageUrls,
  }) {
    return DestinationUpdateFormState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      text: text ?? this.text,
      tags: tags ?? this.tags,
      coords: coords ?? this.coords,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  bool isDirty() {
    return text.isNotEmpty ||
        tags.isNotEmpty ||
        imageUrls.isNotEmpty ||
        coords.isNotEmpty;
  }
}
