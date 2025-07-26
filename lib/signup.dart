import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback onLogin;

  const SignupPage({super.key, required this.onLogin});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _governorateController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        final auth = FirebaseAuth.instance;
        final credential = await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final user = credential.user;

        if (user != null) {
          final firestore = FirebaseFirestore.instance;
          await firestore.collection('users').doc(user.uid).set({
            'username': _usernameController.text.trim(),
            'email': _emailController.text.trim(),
            'phone': _phoneController.text.trim(),
            'governorate': _governorateController.text.trim(),
            'city': _cityController.text.trim(),
            'street': _streetController.text.trim(),
            'createdAt': FieldValue.serverTimestamp(),
          });

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
              title: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 10),
                  Text('Registration Successful'),
                ],
              ),
              content: const Text('Your account has been created successfully.'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onLogin();
                  },
                  child: const Text('OK', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Row(
              children: const [
                Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: 10),
                Text('Error'),
              ],
            ),
            content: Text(e.toString()),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      }
    }
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    IconData? icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: Colors.brown) : null,
        filled: true,
        fillColor: Colors.orange.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Create a New Account 🍽️',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 30),
                  buildTextField(
                    label: 'Full Name',
                    controller: _usernameController,
                    icon: Icons.person,
                    validator: (v) => v!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Phone Number',
                    controller: _phoneController,
                    icon: Icons.phone,
                    validator: (v) => v!.length >= 10 ? null : 'Enter a valid phone number',
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Governorate',
                    controller: _governorateController,
                    icon: Icons.location_city,
                    validator: (v) => v!.isEmpty ? 'Enter your governorate' : null,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'City',
                    controller: _cityController,
                    icon: Icons.location_on,
                    validator: (v) => v!.isEmpty ? 'Enter your city' : null,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Street',
                    controller: _streetController,
                    icon: Icons.home,
                    validator: (v) => v!.isEmpty ? 'Enter your street' : null,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Email',
                    controller: _emailController,
                    icon: Icons.email,
                    validator: (v) => v!.contains('@') ? null : 'Invalid email address',
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Password',
                    controller: _passwordController,
                    icon: Icons.lock,
                    obscure: true,
                    validator: (v) => v!.length >= 6 ? null : 'Password too short',
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Confirm Password',
                    controller: _confirmController,
                    icon: Icons.lock_outline,
                    obscure: true,
                    validator: (v) =>
                        v == _passwordController.text ? null : 'Passwords do not match',
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: widget.onLogin,
                    child: const Text('Already have an account? Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
