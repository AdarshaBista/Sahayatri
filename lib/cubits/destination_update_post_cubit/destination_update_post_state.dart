part of 'destination_update_post_cubit.dart';

class DestinationUpdatePostState {
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

  const DestinationUpdatePostState({
    @required this.text,
    @required this.tags,
    @required this.coords,
    @required this.imageUrls,
  })  : assert(text != null),
        assert(tags != null),
        assert(coords != null),
        assert(imageUrls != null);

  DestinationUpdatePostState copyWith({
    String text,
    List<String> tags,
    List<Coord> coords,
    List<String> imageUrls,
  }) {
    return DestinationUpdatePostState(
      text: text ?? this.text,
      tags: tags ?? this.tags,
      coords: coords ?? this.coords,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}
