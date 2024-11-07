import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:negup_test/view/home/widget/location_tile_widget.dart';

class LocationDataBuilder extends StatelessWidget {
  final List<Position> positionList;
  final bool isTablet;
  const LocationDataBuilder({
    super.key,
    required this.positionList,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        crossAxisCount:
            orientation == Orientation.portrait && size.width < 500 ? 1 : 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 5,
        children: List.generate(
          positionList.length,
          (index) {
            final position = positionList[index];
            return LocationTileWidget(
              index: index + 1,
              position: position,
            );
          },
        ),
      );
    });
  }
}
