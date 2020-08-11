import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/lodge_facility.dart';

final Destination homeTrail = Destination(
  id: 'home',
  name: 'Home Trail',
  length: '0.2',
  maxAltitude: '1810',
  estimatedDuration: '1',
  permit: 'No Permits',
  bestMonths: ['January', 'Februrary', 'March', 'April', 'September'],
  description: _desc,
  places: _places,
  reviews: [],
  imageUrls: _imgUrls,
  route: _route,
  suggestedItineraries: [],
  createdItinerary: null,
  isDownloaded: false,
);

const String _desc = 'Home sweet home.';

const List<String> _imgUrls = [
  'assets/images/home/1.jpg',
  'assets/images/home/2.jpg',
  'assets/images/home/3.jpg',
  'assets/images/home/4.jpg',
  'assets/images/home/5.jpg',
  'assets/images/home/6.jpg',
  'assets/images/home/7.jpg',
  'assets/images/home/8.jpg',
  'assets/images/home/9.jpg',
];

final List<Place> _places = [
  Place(
    id: 12,
    name: 'Home',
    description: _desc,
    lodges: _lodges,
    isNetworkAvailable: true,
    coord: const Coord(lat: 27.628914100, lng: 85.060972300, alt: 1807.8),
    imageUrls: _imgUrls.getRange(0, 2).toList(),
  ),
  Place(
    id: 13,
    name: 'River',
    description: _desc,
    lodges: [..._lodges, ..._lodges],
    isNetworkAvailable: true,
    coord: const Coord(lat: 27.628301000, lng: 85.060934700, alt: 1800.0),
    imageUrls: _imgUrls.getRange(2, 5).toList(),
  ),
  Place(
    id: 14,
    name: 'Chautari',
    description: _desc,
    lodges: _lodges,
    isNetworkAvailable: true,
    coord: const Coord(lat: 27.627977800, lng: 85.060339300, alt: 1801.8),
    imageUrls: _imgUrls.getRange(5, 7).toList(),
  ),
  Place(
    id: 15,
    name: 'Exit',
    description: _desc,
    lodges: _lodges,
    isNetworkAvailable: true,
    coord: const Coord(lat: 27.627657000, lng: 85.060374100, alt: 1801.1),
    imageUrls: _imgUrls.getRange(7, 9).toList(),
  ),
];

final List<Lodge> _lodges = [
  Lodge(
    id: 'lodge7',
    name: 'My Lodge',
    coord: const Coord(lat: 28.29914, lng: 83.82164),
    rating: 3.5,
    imageUrls: _imgUrls.getRange(1, 4).toList(),
    contactNumbers: ['9841146372', '9837285838'],
    facility: const LodgeFacility(wifi: true, toilet: true),
  ),
  Lodge(
    id: 'lodge8',
    name: 'Your Lodge',
    coord: const Coord(lat: 28.31495, lng: 83.83057),
    rating: 4.5,
    imageUrls: _imgUrls.getRange(5, 8).toList(),
    contactNumbers: ['9841146372', '9837285838'],
    facility: const LodgeFacility(wifi: true, toilet: true),
  ),
];

const List<Coord> _route = [
  Coord(lat: 27.628909300, lng: 85.060972300, alt: 1807.6),
  Coord(lat: 27.628876000, lng: 85.060897200, alt: 1807.3),
  Coord(lat: 27.628804700, lng: 85.060913300, alt: 1806.1),
  Coord(lat: 27.628704900, lng: 85.060948100, alt: 1804.4),
  Coord(lat: 27.628595600, lng: 85.060977600, alt: 1802.8),
  Coord(lat: 27.628469700, lng: 85.060961500, alt: 1801.5),
  Coord(lat: 27.628360400, lng: 85.060948100, alt: 1800.4),
  Coord(lat: 27.628277200, lng: 85.060956200, alt: 1799.7),
  Coord(lat: 27.628210600, lng: 85.060867700, alt: 1799.9),
  Coord(lat: 27.628144100, lng: 85.060784500, alt: 1799.8),
  Coord(lat: 27.628096600, lng: 85.060688000, alt: 1800.0),
  Coord(lat: 27.628053800, lng: 85.060569900, alt: 1800.9),
  Coord(lat: 27.628022900, lng: 85.060478700, alt: 1801.3),
  Coord(lat: 27.627989600, lng: 85.060360700, alt: 1801.7),
  Coord(lat: 27.627897000, lng: 85.060350000, alt: 1801.7),
  Coord(lat: 27.627806700, lng: 85.060317800, alt: 1801.9),
  Coord(lat: 27.627671200, lng: 85.060392900, alt: 1801.1),
];
