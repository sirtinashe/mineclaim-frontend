import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:mineclaim/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_export.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
bool isUserAuthenticated = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DateTime timeStamp = DateTime.now();
  print(timeStamp.millisecondsSinceEpoch);

  final Future<SharedPreferences> _sharedPreferences =  SharedPreferences.getInstance() ;
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    print("Something changed in authentication ");
    final SharedPreferences sharedPreferences = await _sharedPreferences ;
    if (user == null) {
      print('User is currently signed out!');
      isUserAuthenticated = false;

    } else {
      print('User is signed in!');
      isUserAuthenticated = true;

      sharedPreferences.setString("uuid", user!.uid.toString());
      sharedPreferences.setString("email", user!.email.toString());
      String doc = timeStamp.millisecondsSinceEpoch.toString()+"user"+user.uid.toString();
      print("Document $doc");
      print(doc.split("user")[1]);

      print("===================== From shared preferences ============");
      String? email = sharedPreferences.getString("email");
      String? uuid  =  sharedPreferences.getString("uuid");
      print("Email $email , uuid $uuid");
      globalUuid = uuid.toString();
      globalEmail = email.toString();


      print("============== End of the shared preferences ============");

    }
  });




  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: PrimaryColors().appDarkBlue,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'mineclaim',
          debugShowCheckedModeBanner: true,
          // initialRoute: AppRoutes.myHomeEmptyScreen,
          initialRoute: isUserAuthenticated ? AppRoutes.myHomeEmptyScreen : AppRoutes.signUpScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}