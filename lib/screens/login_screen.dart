import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        child: Column(
          children: [
             const SizedBox(height: 40),
             const Text(
               "Welcome",
               style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
              ),
             ),
            
             const SizedBox(height: 40),

             Expanded(
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                 decoration: const BoxDecoration(
                   color: AppColors.scaffoldBg,
                   borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                 ),
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Text("Username Or Email", style: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.w500)),
                       const SizedBox(height: 8),
                       const CustomTextField(key: Key('login_email_input'), hint: "example@example.com"),

                       const SizedBox(height: 24),

                       const Text("Password", style: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.w500)),
                       const SizedBox(height: 8),
                       const CustomTextField(
                        key: Key('login_password_input'),
                        hint: "••••••••", 
                        obscure: true,
                         suffixIcon: Icon(Icons.visibility_off, color: AppColors.textGrey),
                       ),

                       const SizedBox(height: 32),

                       CustomButton(
                         key: const Key('login_button'),
                         text: "Log In", 
                         onTap: () {
                           Navigator.pushReplacementNamed(context, '/home');
                         },
                         isOutlined: false,
                       ),

                       const SizedBox(height: 16),
                       Center(
                         child: GestureDetector(
                           key: const Key('forgot_password_link'),
                           onTap: () => Navigator.pushNamed(context, '/forgot'),
                           child: const Text("Forgot Password?", style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600)),
                         ),
                       ),
                       const SizedBox(height: 16),

                       CustomButton(
                         key: const Key('login_signup_button'),
                         text: "Sign Up", 
                         onTap: () {
                           Navigator.pushNamed(context, '/signup');
                         },
                         isOutlined: true,
                       ),

                       const SizedBox(height: 24),

                       Center(
                         child: Text("Use Fingerprint To Access", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                       ),

                       const SizedBox(height: 24),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: const [
                             Text("or sign up with", style: TextStyle(color: Colors.grey, fontSize: 12)),
                         ],
                       ),
                       
                        const SizedBox(height: 16),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           _socialButton("assets/facebook.png"), // Placeholder for now, using Icon
                           const SizedBox(width: 20),
                           _socialButton("assets/google.png"),
                         ],
                       ),
                       
                       const SizedBox(height: 24),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Don't have an account? ", style: TextStyle(color: Colors.grey.shade600)),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/signup'),
                                child: const Text("Sign Up", style: TextStyle(color: const Color(0xFF00C9A7), fontWeight: FontWeight.bold)), // Assuming blue content color logic
                            ),
                         ],
                       )
                     ],
                   ),
                 ),
               ),
             )
          ],
        ),
      ),
    );
  }

  Widget _socialButton(String asset) {
    // Using Icons for now as assets might not exist
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.transparent,
      child: Icon(
        asset.contains("facebook") ? Icons.facebook : Icons.g_mobiledata,
        color: AppColors.textDark,
        size: 32,
      ),
       // If assets were real: Image.asset(asset, height: 40)
    );
  }
}

// Add textBlueContent to AppColors if missed
extension on Color {
    // Helper if needed locally, but better in AppColors
}
