import 'package:flutter/material.dart';
import 'package:negup_test/core/providers/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Test App',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white)),
          backgroundColor: Colors.grey[900],
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                    ),
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
                    child: Text('Request Location Permission',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () async {
                      var permissionstatus = await viewModel
                          .permissionHandlerService
                          .requestNotificationPermission();
                      if (permissionstatus) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Notification Permission Enabled")));
                        }
                      }
                    },
                    child: Text('Request Notification Permission',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () => viewModel.startTracking(context),
                    child: Text('Start Location Update',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => viewModel.stopTracking(),
                    child: Text('Stop Location Update',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: viewModel.currentPositions.isNotEmpty
                        ? ListView.builder(
                            itemCount: viewModel.currentPositions.length,
                            itemBuilder: (context, index) {
                              final position =
                                  viewModel.currentPositions[index];
                              return ListTile(
                                title: Text(
                                    "Lat: ${position.latitude}, Long: ${position.longitude} speed: ${position.speed.round()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.white)),
                              );
                            },
                          )
                        : Center(
                            child: Text('Start Tracking',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white)),
                          ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
