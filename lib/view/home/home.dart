import 'package:flutter/material.dart';
import 'package:negup_test/core/providers/home_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../core/constants/constants.dart';
import 'widget/widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).fetchLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isTablet = size.width >= 550;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(AppStrings.appbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColor.white)),
          backgroundColor: AppColor.darkGrey,
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                ButtonsSection(),
                Expanded(
                  child: viewModel.currentPositions.isNotEmpty
                      ? LocationDataBuilder(
                          positionList: viewModel.currentPositions,
                          isTablet: isTablet,
                        )
                      : Center(
                          child: Text(AppStrings.startTracking,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: AppColor.black)),
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
