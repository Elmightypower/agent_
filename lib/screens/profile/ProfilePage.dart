import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ProfileEditPage.dart';
import 'package:agentshipr/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? agentId;
  String? fullName;
  String? email;
  String? address;
  String? contact;
  String? ville;

  final AuthService _authService = AuthService(); // Initialize AuthService

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      agentId = prefs.getString('agent_id');
      fullName = prefs.getString('nom_complet_agent');
      email = prefs.getString('email_agent');
      address = prefs.getString('adresse_physique');
      contact = prefs.getString('contact_agent');
      ville = prefs.getString('ville');
    });
  }

  // Logout function
  Future<void> _logout() async {
    await _authService.logout();  // Call logout from AuthService
    Navigator.pushReplacementNamed(context, '/login');  // Navigate to the login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A2C50), Color(0xFF141E3C)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: 350,
          ),

          // Profile Content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Profile Picture
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.yellow,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: AssetImage('assets/profile.jpg'), // Add your image asset
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        fullName ?? 'Loading...',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ville ?? 'Loading...', // This could be dynamic too, but it's a placeholder here
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Edit Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileEditPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Modifier Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Points Card (Optional - can also be updated with dynamic data)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Your Points',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '+20 since last week',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Circular Points Progress
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(
                                  value: 0.85,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: const AlwaysStoppedAnimation(
                                      Colors.orangeAccent),
                                  strokeWidth: 8,
                                ),
                              ),
                            ),
                            const Center(
                              child: Text(
                                '85',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          IndicatorDot(color: Colors.yellow, label: 'HTML/CSS'),
                          IndicatorDot(color: Colors.blue, label: 'Graphic design'),
                          IndicatorDot(color: Colors.grey, label: 'UX'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Classmates Section (Optional)
                Column(
                  children: [
                    const Text(
                      'mes Top tranShip',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Les tranShip avec lesquels\n J\'ai beaucoup travailler !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Classmate Avatars
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ClassmateAvatar(name: 'Tom', asset: 'assets/tom.jpg'),
                        ClassmateAvatar(name: 'Jane', asset: 'assets/jane.jpg'),
                        ClassmateAvatar(name: 'Sarah', asset: 'assets/sarah.jpg'),
                        ClassmateAvatar(name: 'Jan', asset: 'assets/jan.jpg'),
                      ],
                    ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Text(
                          'Se deconnecter',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
