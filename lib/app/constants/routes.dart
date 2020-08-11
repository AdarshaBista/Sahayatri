class Routes {
  // App Routes
  static const String kAuthPageRoute = '/';
  static const String kHomePageRoute = '/home';
  static const String kDestinationPageRoute = '/destination';

  // Destination Routes
  static const String kRoutePageRoute = '$kDestinationPageRoute/route';
  static const String kPlacePageRoute = '$kDestinationPageRoute/place';
  static const String kLodgePageRoute = '$kDestinationPageRoute/lodge';
  static const String kWeatherPageRoute = '$kDestinationPageRoute/weather';
  static const String kTrackerPageRoute = '$kDestinationPageRoute/tracker';
  static const String kPhotoViewPageRoute = '$kDestinationPageRoute/photos';
  static const String kItineraryPageRoute = '$kDestinationPageRoute/itinerary';
  static const String kDestinationDetailPageRoute = '$kDestinationPageRoute/detail';
  static const String kItineraryFormPageRoute = '$kDestinationPageRoute/itinerary_form';
}
