import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exercise/pages/cubit/places_cubit.dart';
import 'package:flutter_exercise/services/map_box_service.dart';

class SearchStudioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primaryTextTheme = Theme.of(context).primaryTextTheme;
    PlacesCubit placesCubit = new PlacesCubit();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        titleTextStyle: primaryTextTheme.headline6,
        toolbarTextStyle: primaryTextTheme.headline6,
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Search by city name',
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.radar),
            ),
            textAlign: TextAlign.left,
            onChanged: (value) => placesCubit.getPlaces(value),
          ),
          BlocBuilder<PlacesCubit, PlacesState>(
              bloc: placesCubit,
              builder: (context, state) {
                if (state is PlacesInitial) {
                  return Container(
                      child: Center(
                    child: Text("Nothing Found."),
                  ));
                }

                if (state is PlacesLoading) {
                  return buildPlacesLoadingWidget();
                }

                if (state is PlacesLoaded) {
                  return buildPlacesListWidget(state.places);
                }

                if (state is PlacesFailure) {
                  popSnackBar(state.errorMessage, context);
                }

                return buildPlacesNothingFoundWidget();
              })
        ],
      ),
    );
  }

  void popSnackBar(String message, BuildContext context, [int? duration]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration ?? 2),
    ));
  }

  Widget buildPlacesListWidget(List<MapBoxPlace> places) {
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: places.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Text(places[index].name),
            ),
          );
        },
      ),
    );
  }

  Widget buildPlacesLoadingWidget() {
    return Container(
      child: Text("Loading..."),
    );
  }

  Widget buildPlacesNothingFoundWidget() {
    return Container(
      child: Text("Nothing found..."),
    );
  }
}
