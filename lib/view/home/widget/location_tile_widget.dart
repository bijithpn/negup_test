import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationTileWidget extends StatelessWidget {
  final int index;
  final Position position;
  const LocationTileWidget({
    super.key,
    required this.index,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    var subtitleStyle = Theme.of(context).textTheme.bodyMedium;
    return ListTile(
        tileColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text("Request$index",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold)),
        subtitle: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Lat:',
                children: [
                  TextSpan(
                    text: ' ${position.latitude}',
                    style: subtitleStyle,
                  )
                ],
                style: subtitleStyle!.copyWith(fontWeight: FontWeight.bold),
              ),
              const WidgetSpan(
                child: SizedBox(width: 10), // 10px spacing
              ),
              TextSpan(
                text: 'Long:',
                children: [
                  TextSpan(
                    text: ' ${position.longitude}',
                    style: subtitleStyle,
                  )
                ],
                style: subtitleStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              const WidgetSpan(
                child: SizedBox(width: 10), // 10px spacing
              ),
              TextSpan(
                text: 'Speed:',
                children: [
                  TextSpan(
                    text: ' ${position.speed.round()}m',
                    style: subtitleStyle,
                  )
                ],
                style: subtitleStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
