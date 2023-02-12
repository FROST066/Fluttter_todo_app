import 'package:blog/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blog/screens/login_screen.dart';
import 'package:blog/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

  final firstPage = token == '' ? 'LOGIN' : 'HOME';

  runApp(MyApp(firstPage: firstPage));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.firstPage});

  final String firstPage;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          textTheme: TextTheme(bodyText2: GoogleFonts.workSans())),
      home: firstPage == 'LOGIN' ? const LoginScreen() : HomePage(),
    );
  }
}
