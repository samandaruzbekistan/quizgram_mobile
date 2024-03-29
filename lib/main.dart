import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizgram/screens/home_screen/home_screeen.dart';
import 'package:quizgram/screens/sign_up_screen/sign_up_screen.dart';
import 'package:quizgram/screens/splash_screen/splash_screen.dart';

import 'firebase_api.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.black,
  //   statusBarBrightness: Brightness.light, // status bar color
  // ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        var box = Hive.box('user');
        box.put("version", 6);
        var user = box.get("name");
        bool isReg = false;
        if(user != null){
          isReg = true;
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ideal Quiz',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            primarySwatch: Colors.purple,
          ),
          home: isReg ? const HomeScreen() : const SplashScreen(),
        );
      },
    );
  }
}
