import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C9A7),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=3"),
            ),

            const SizedBox(height: 10),
            Text(
              UserModel.name,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text("ID: 25030024"),

            const SizedBox(height: 30),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF1FFF9),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    _tile(
                      icon: Icons.person,
                      text: "Edit Profile",
                      onTap: () {
                        Navigator.pushNamed(context, '/editProfile');
                      },
                    ),
                    _tile(icon: Icons.security, text: "Security"),
                    _tile(icon: Icons.settings, text: "Setting"),
                    _tile(icon: Icons.help, text: "Help"),
                    _tile(
                      icon: Icons.logout,
                      text: "Logout",
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
      {required IconData icon,
      required String text,
      VoidCallback? onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: Icon(icon),
      ),
      title: Text(text),
      onTap: onTap,
    );
  }
}
