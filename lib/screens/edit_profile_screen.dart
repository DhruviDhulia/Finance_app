import 'package:flutter/material.dart';
import '../models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: UserModel.name);
    phoneController = TextEditingController(text: UserModel.phone);
    emailController = TextEditingController(text: UserModel.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C9A7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00C9A7),
        elevation: 0,
        title: const Text("Edit My Profile"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFF1FFF9),
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _field("Username", nameController),
            _field("Phone", phoneController),
            _field("Email Address", emailController),

            SwitchListTile(
              value: true,
              onChanged: (v) {},
              title: const Text("Push Notifications"),
            ),

            SwitchListTile(
              value: false,
              onChanged: (v) {},
              title: const Text("Turn Dark Theme"),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C9A7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  UserModel.name = nameController.text;
                  UserModel.phone = phoneController.text;
                  UserModel.email = emailController.text;

                  Navigator.pop(context);
                },
                child: const Text("Update Profile"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.green.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
