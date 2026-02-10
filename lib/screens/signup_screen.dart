import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Create Account",
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
                      _label("Full Name"),
                      const CustomTextField(key: Key('signup_name_input'), hint: "John Doe"),
                      _space(),
                      
                      _label("Email"),
                      const CustomTextField(key: Key('signup_email_input'), hint: "example@example.com"),
                      _space(),

                      _label("Mobile Number"),
                      const CustomTextField(key: Key('signup_phone_input'), hint: "+ 123 456 789", keyboardType: TextInputType.phone),
                      _space(),

                      _label("Date Of Birth"),
                      const CustomTextField(key: Key('signup_dob_input'), hint: "DD / MM / YYYY"),
                      _space(),

                      _label("Password"),
                       const CustomTextField(
                        key: Key('signup_password_input'),
                        hint: "••••••••", 
                        obscure: true,
                         suffixIcon: Icon(Icons.visibility_off, color: AppColors.textGrey),
                       ),
                      _space(),

                      _label("Confirm Password"),
                       const CustomTextField(
                        key: Key('signup_confirm_password_input'),
                        hint: "••••••••", 
                        obscure: true,
                         suffixIcon: Icon(Icons.visibility_off, color: AppColors.textGrey),
                       ),
                      const SizedBox(height: 24),
                      
                      const Text(
                        "By continuing, you agree to\nTerms of Use and Privacy Policy.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      
                      const SizedBox(height: 20),

                      CustomButton(
                        key: const Key('signup_button'),
                        text: "Sign Up", 
                        onTap: () {
                           // Implement registration logic
                           Navigator.pop(context);
                        },
                      ),

                      const SizedBox(height: 16),
                      Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const Text("Already have an account? ", style: TextStyle(color: Colors.grey)),
                              GestureDetector(
                                key: const Key('signup_login_link'),
                                onTap: () => Navigator.pop(context),
                                  child: const Text("Log In", style: TextStyle(color: const Color(0xFF00C9A7), fontWeight: FontWeight.bold)), 
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
  
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(text, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w500)),
    );
  }

  Widget _space() => const SizedBox(height: 16);
}
