part of 'places_cubit.dart';

abstract class PlacesState {
  const PlacesState();
}

class PlacesInitial extends PlacesState {
  const PlacesInitial();
}

class PlacesLoading extends PlacesState {
  const PlacesLoading();
}

class PlacesListIsEmpty extends PlacesState {
  const PlacesListIsEmpty();
}

class PlacesLoaded extends PlacesState {
  final List<MapBoxPlace> places;
  const PlacesLoaded(this.places);
}

class PlacesFailure extends PlacesState {
  final String errorMessage;
  const PlacesFailure(this.errorMessage);
}
