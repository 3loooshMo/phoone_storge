import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_store_app/utils/core/theme_manager.dart';
import 'package:phone_store_app/view/widgets/bottom_app_bar.dart';
import 'firebase_options.dart';
Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: ThemeManager.appName,
        theme: ThemeManager.lightTheme,
        home: const SharedBottomAppBar(),
    );
  }
}
