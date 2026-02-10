import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: const BoxDecoration(
                  color: AppColors.scaffoldBg,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Reset Password?", 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.5),
                      ),
                      const SizedBox(height: 32),
                      
                      const Text("Enter Email Address", style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      const CustomTextField(
                        key: Key('forgot_password_email_input'), 
                        hint: "example@example.com",
                      ),
                      const SizedBox(height: 32),
                      
                      CustomButton(
                        key: const Key('forgot_password_next_button'),
                        text: "Next Step", 
                        onTap: () {
                           // Implement reset logic
                        },
                      ),

                      const SizedBox(height: 48),

                      CustomButton(
                        key: const Key('forgot_password_signup_button'),
                        text: "Sign Up", 
                        onTap: () {
                           Navigator.pushReplacementNamed(context, '/signup');
                        },
                        isOutlined: true, // Though design shows filled light green, utilizing secondary style
                      ),
                       const SizedBox(height: 16),
                       Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const Text("or sign up with", style: TextStyle(color: Colors.grey)),
                           ],
                         ),
                       ),
                        const SizedBox(height: 16),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           _socialButton("assets/facebook.png"), 
                           const SizedBox(width: 20),
                           _socialButton("assets/google.png"),
                         ],
                       ),
                       const SizedBox(height: 24),
                       Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const Text("Don't have an account? ", style: TextStyle(color: Colors.grey)),
                              GestureDetector(
                                key: const Key('forgot_password_login_link'), // Wait, text says Sign Up, logic is Sign Up. Logic seems circular in original code?
                                // Original code: "Don't have an account? Sign Up".
                                // If I am on Forgot Password, maybe I want to go to Login? 
                                // The design image 3 has "Sign Up" button and "Don't have an account? Sign Up" link.
                                // It seems redundant but I will stick to the design/code I wrote.
                                onTap: () => Navigator.pushReplacementNamed(context, '/signup'),
                                  child: const Text("Sign Up", style: TextStyle(color: const Color(0xFF00C9A7), fontWeight: FontWeight.bold)), 
                              ),
                           ],
                         ),
                       ),
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
      return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.transparent,
      child: Icon(
        asset.contains("facebook") ? Icons.facebook : Icons.g_mobiledata,
        color: AppColors.textDark,
        size: 32,
      ),
    );
  }
}
