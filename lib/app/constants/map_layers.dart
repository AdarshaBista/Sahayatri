import 'package:sahayatri/app/constants/values.dart';

import 'package:sahayatri/core/models/map_layer.dart';

import 'package:community_material_icon/community_material_icon.dart';

enum MapLayerType {
  dark,
  light,
  streets,
  outdoors,
  satellite,
}

const Map<MapLayerType, MapLayer> kMapLayers = {
  MapLayerType.dark: MapLayer(
    title: 'Dark',
    id: Values.kMapStyleDark,
    icon: CommunityMaterialIcons.weather_night,
  ),
  MapLayerType.light: MapLayer(
    title: 'Light',
    id: Values.kMapStyleLight,
    icon: CommunityMaterialIcons.weather_sunny,
  ),
  MapLayerType.streets: MapLayer(
    title: 'Streets',
    id: Values.kMapStyleStreets,
    icon: CommunityMaterialIcons.google_street_view,
  ),
  MapLayerType.outdoors: MapLayer(
    title: 'Outdoors',
    id: Values.kMapStyleOutdoors,
    icon: CommunityMaterialIcons.hiking,
  ),
  MapLayerType.satellite: MapLayer(
    title: 'Satellite',
    id: Values.kMapStyleSatellite,
    icon: CommunityMaterialIcons.earth,
  ),
};
