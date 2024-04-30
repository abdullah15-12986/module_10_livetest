import 'package:flutter/material.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.cyan,
          title: const Text('Profile', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
        ),
        body: const Center(
          child: ProfileWidget(
            name: 'Abdullah Masum',
            email: 'abdullahmasum99@gmail.com',
          ),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String name;
  final String email;

  const ProfileWidget({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/profile_image.jpg'), // Placeholder image path
        ),
        const SizedBox(height: 20),
        Text(
          'Name: $name',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Text(
          'Email: $email',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        const Text(
          'Additional information goes here.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}