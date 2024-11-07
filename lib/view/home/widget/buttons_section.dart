import 'package:flutter/material.dart';
import 'package:negup_test/core/constants/constants.dart';
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
              color: AppColor.darkGrey,
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
                    color: AppColor.blue,
                    onPressed: () async {
                      var permissionstatus = await viewModel
                          .permissionHandlerService
                          .requestLocationPermission();
                      if (context.mounted) {
                        if (permissionstatus) {
                          snackBarService.showToast(
                            AppStrings.locationEnabled,
                          );
                        } else {
                          snackBarService.showSnackBar(
                            AppStrings.locationEnabledMessage,
                            context: context,
                            snackBarAction: SnackBarAction(
                                label: AppStrings.settings,
                                onPressed: () {
                                  openAppSettings();
                                }),
                          );
                        }
                      }
                    },
                    title: AppStrings.requestLocationPermission,
                  ),
                  ButtonWidget(
                    color: AppColor.yellow,
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
                          snackBarService.showToast(
                              AppStrings.notificationPermissionEnabled);
                        }
                      } else {
                        if (context.mounted) {
                          snackBarService.showSnackBar(
                            AppStrings.notificationPermissionDenied,
                            context: context,
                            snackBarAction: SnackBarAction(
                                label: AppStrings.settings,
                                onPressed: () {
                                  openAppSettings();
                                }),
                          );
                        }
                      }
                    },
                    title: AppStrings.requestNotificationPermission,
                  ),
                  ButtonWidget(
                    color: AppColor.green,
                    onPressed: () => showAdaptiveDialog(
                        context: context,
                        builder: (_) {
                          return const LocationDialog();
                        }),
                    title: AppStrings.startLocationUpdate,
                  ),
                  ButtonWidget(
                    color: AppColor.red,
                    onPressed: () => viewModel.stopTracking(),
                    title: AppStrings.stopLocationUpdate,
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
