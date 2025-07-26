import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
        });
      }
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget buildInfoItem({required IconData icon, required String label, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepOrange, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.deepOrange),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person, color: Colors.orange.shade50),
        title: Text('My Account',style: TextStyle(color: Colors.orange.shade50)),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Colors.orange.shade50,
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  buildInfoItem(
                    icon: Icons.person,
                    label: 'Name',
                    value: userData!['username'] ?? '',
                  ),
                  buildInfoItem(
                    icon: Icons.email,
                    label: ' Email',
                    value: userData!['email'] ?? '',
                  ),
                  buildInfoItem(
                    icon: Icons.phone,
                    label: 'Phone Number ',
                    value: userData!['phone'] ?? '',
                  ),
                  buildInfoItem(
                    icon: Icons.location_city,
                    label: 'Governorate',
                    value: userData!['governorate'] ?? '',
                  ),
                  buildInfoItem(
                    icon: Icons.location_on,
                    label: 'City',
                    value: userData!['city'] ?? '',
                  ),
                  buildInfoItem(
                    icon: Icons.home,
                    label: 'Street',
                    value: userData!['street'] ?? '',
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: logout,
                    label: Text('Logout', style: TextStyle(color: Colors.orange.shade50, fontSize: 25)),
                    icon: Icon(Icons.logout, color: Colors.orange.shade50),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
