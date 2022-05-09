import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shivrai_task/common/routes.dart';
import 'package:shivrai_task/view/splash.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xff1ad1cc,
            <int, Color>{
              50: Color(0xff1ad1cc),
              100: Color(0xff1ad1cc),
              200: Color(0xff1ad1cc),
              300: Color(0xff1ad1cc),
              400: Color(0xff1ad1cc),
              500: Color(0xff1ad1cc),
              600: Color(0xff1ad1cc),
              700: Color(0xff1ad1cc),
              800: Color(0xff1ad1cc),
              900: Color(0xff1ad1cc),
            },
          ),
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.black))),
      home: const SplashView(),
      getPages: Routes.routes,
      initialRoute: '/',
    );
  }
}
