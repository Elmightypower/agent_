import 'package:flutter/material.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF1A2C50),
      ),
      body: const Center(
        child: Text(
          'Profile Edit Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final Color color;
  final String label;
  const IndicatorDot({required this.color, required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: color,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class ClassmateAvatar extends StatelessWidget {
  final String name;
  final String asset;
  const ClassmateAvatar({required this.name, required this.asset, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(asset),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
