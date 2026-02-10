import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/app_colors.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/edit_profile_screen.dart';

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryGreen,
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),

      // 👇 Entry screen
      home: const LoginScreen(),

      // 👇 Other named routes
      routes: {
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/editProfile': (context) => const EditProfileScreen(),
      },
    );
  }
}
