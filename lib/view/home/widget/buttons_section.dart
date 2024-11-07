import 'package:flutter/material.dart';
import 'package:negup_test/core/providers/home_viewmodel.dart';
import 'package:negup_test/view/home/widget/button_widget.dart';
import 'package:negup_test/view/home/widget/location_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../core/services/app_notification_service.dart';

class ButtonsSection extends StatelessWidget {
  ButtonsSection({super.key});
  final snackBarService = SnackbarService();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return Container(
              color: Colors.grey[900],
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                crossAxisCount:
                    orientation == Orientation.portrait && size.width < 500
                        ? 1
                        : 2,
                children: [
                  ButtonWidget(
                    color: Colors.blue,
                    onPressed: () async {
                      var permissionstatus = await viewModel
                          .permissionHandlerService
                          .requestLocationPermission();
                      if (context.mounted) {
                        if (permissionstatus) {
                          snackBarService.showToast(
                            "Location Permission Enabled",
                          );
                        } else {
                          snackBarService.showSnackBar(
                            "Location Permission Denied Go to settings and enable location",
                            context: context,
                            snackBarAction: SnackBarAction(
                                label: 'Settings',
                                onPressed: () {
                                  openAppSettings();
                                }),
                          );
                        }
                      }
                    },
                    title: 'Request Location Permission',
                  ),
                  ButtonWidget(
                    color: Colors.amber,
                    titleStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                    onPressed: () async {
                      var permissionstatus = await viewModel
                          .permissionHandlerService
                          .requestNotificationPermission();
                      if (permissionstatus) {
                        if (context.mounted) {
                          snackBarService
                              .showToast("Notification Permission Enabled");
                        }
                      } else {
                        if (context.mounted) {
                          snackBarService.showSnackBar(
                            "Notification Permission Denied  Go to settings and enable notification",
                            context: context,
                            snackBarAction: SnackBarAction(
                                label: 'Settings',
                                onPressed: () {
                                  openAppSettings();
                                }),
                          );
                        }
                      }
                    },
                    title: 'Request Notification Permission',
                  ),
                  ButtonWidget(
                    color: Colors.green,
                    onPressed: () => showAdaptiveDialog(
                        context: context,
                        builder: (_) {
                          return const LocationDialog();
                        }),
                    title: 'Start Location Update',
                  ),
                  ButtonWidget(
                    color: Colors.red,
                    onPressed: () => viewModel.stopTracking(),
                    title: 'Stop Location Update',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
