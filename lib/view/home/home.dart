import 'package:flutter/material.dart';
import 'package:negup_test/core/providers/home_viewmodel.dart';
import 'package:provider/provider.dart';

import 'widget/widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Test App',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white)),
          backgroundColor: Colors.grey[900],
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                Container(
                  color: Colors.grey[900],
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Column(
                    children: [
                      ButtonWidget(
                        color: Colors.blue,
                        onPressed: () async {
                          var permissionstatus = await viewModel
                              .permissionHandlerService
                              .requestLocationPermission();
                          if (context.mounted) {
                            if (permissionstatus) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Location Permission Enabled")));
                            }
                          }
                        },
                        title: 'Request Location Permission',
                      ),
                      ButtonWidget(
                        color: Colors.amber,
                        onPressed: () async {
                          var permissionstatus = await viewModel
                              .permissionHandlerService
                              .requestNotificationPermission();
                          if (permissionstatus) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Notification Permission Enabled")));
                            }
                          }
                        },
                        title: 'Request Notification Permission',
                      ),
                      ButtonWidget(
                        color: Colors.green,
                        onPressed: () => viewModel.startTracking(context),
                        title: 'Start Location Update',
                      ),
                      ButtonWidget(
                        color: Colors.red,
                        onPressed: () => viewModel.stopTracking(),
                        title: 'Stop Location Update',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: viewModel.currentPositions.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          itemCount: viewModel.currentPositions.length,
                          itemBuilder: (context, index) {
                            final position = viewModel.currentPositions[index];
                            return LocationTileWidget(
                              index: index + 1,
                              position: position,
                            );
                          },
                        )
                      : Center(
                          child: Text('Start Tracking',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.black)),
                        ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
