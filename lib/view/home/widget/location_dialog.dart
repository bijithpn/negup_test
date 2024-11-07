import 'package:flutter/material.dart';
import 'package:negup_test/core/providers/home_viewmodel.dart';
import 'package:provider/provider.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(
        "Location Access",
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      content: Text(
        "This app needs access to your location to provide accurate information. Please allow location access.",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "No",
              style: Theme.of(context).textTheme.bodyLarge,
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<HomeViewModel>(context, listen: false)
                  .startTracking(context);
            },
            child: Text(
              "Yes",
              style: Theme.of(context).textTheme.bodyLarge,
            ))
      ],
    );
  }
}
