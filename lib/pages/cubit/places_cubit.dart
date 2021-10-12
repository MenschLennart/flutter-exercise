import 'package:bloc/bloc.dart';
import 'package:flutter_exercise/services/map_box_service.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit() : super(PlacesInitial());

  MapBoxService mapService = MapBoxService();

  Future<void> getPlaces(searchStudioInput) async {
    try {
      emit(PlacesLoading());
      final placesLoaded = await Future.delayed(Duration(seconds: 2))
          .then((value) => mapService.searchPlaces(searchStudioInput));

      if (placesLoaded.isNotEmpty) {
        emit(PlacesLoaded(placesLoaded));
      } else {
        emit(PlacesListIsEmpty());
      }
    } catch (e) {
      emit(PlacesFailure(e.toString()));
    }
  }
}
