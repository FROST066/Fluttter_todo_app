import 'package:blog/screens/home_page.dart';
import 'package:blog/widgets/BarChart.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: appBlue, foregroundColor: Colors.white),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
            centerTitle: true,
            titleTextStyle: GoogleFonts.lora(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        primaryColor: appBlue,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: appBlue, fontSize: 18),
          floatingLabelStyle: const TextStyle(fontSize: 18, color: appBlue),
          prefixIconColor: appBlue,
          suffixIconColor: appBlue,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: appBlue, width: 2)),
          labelStyle: GoogleFonts.workSans(color: appBlue, fontSize: 18),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: appBlue, width: 2)),
        ),
        textTheme: TextTheme(
          button: GoogleFonts.workSans(fontSize: 20, color: Colors.black),
          // headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: GoogleFonts.lora(color: Colors.black),
        ),
      ),
      home: firstPage == 'LOGIN' ? const LoginScreen() : HomePage(),
    );
  }
}
