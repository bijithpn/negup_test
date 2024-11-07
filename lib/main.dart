import 'package:flutter/material.dart';
import 'package:negup_test/core/providers/home_viewmodel.dart';
import 'package:provider/provider.dart';

import 'core/services/services.dart';
import 'view/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService().init();
  runApp(ChangeNotifierProvider(
      create: (context) => HomeViewModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Negup Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
