import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart'; // Import generated file by Firebase CLI
import 'screens/home_screen.dart'; // Import HomeScreen
import 'screens/retail_screen.dart'; // Import RetailScreen
import 'screens/login_screen.dart'; // Import LoginScreen
import 'screens/register_screen.dart'; // Import RegisterScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MetalsApp());
}

class MetalsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF6C63FF),
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/retail': (context) => RetailScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
