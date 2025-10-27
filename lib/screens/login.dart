import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:group_04_app/services/FirebaseHelper.dart';
import 'package:group_04_app/services/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();
  String startRole = "Educator"; // Default role
  bool _obscureText = true;

  void _togglePassVisible() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(170, 208, 104, 227), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                width: 350,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.menu_book_rounded,
                            color: Colors.purple, size: 40),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        'CollabEase',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(142, 111, 13, 197),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Log in to teach, learn, and grow together',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Email Field
                      TextFormField(
                        validator: validateEmail,
                        controller: emailField,
                        decoration: InputDecoration(
                          labelText: 'Enter email...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextFormField(
                        validator: validatePassword,
                        controller: passwordField,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Enter password...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            onPressed: _togglePassVisible,
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'I am a...',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          roleButton('Educator'),
                          const SizedBox(width: 10),
                          roleButton('Learner'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Login Button
                      ElevatedButton(
                        onPressed: () async {
                          await signinWithEmailAndPassword(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(142, 111, 13, 197),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 12),

                      TextButton(
                        onPressed: () => context.go('/signup'),
                        child: const Text(
                          'Create an Account',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget roleButton(String role) {
    final selected = startRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => startRole = role),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color:
                selected ? const Color.fromARGB(142, 111, 13, 197) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  selected ? const Color.fromARGB(142, 111, 13, 197) : Colors.grey,
            ),
          ),
          child: Center(
            child: Text(
              role,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signinWithEmailAndPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      showProgress('Logging In...');
      final result = await FireStoreUtils.loginWithEmailAndPassword(
        emailField.text.trim(),
        passwordField.text.trim(),
      );
      closeLoader();

      if (result != null && result is! String) {
        if (!mounted) return;
        showSuccess("Logged In Successfully", context);
        await Future.delayed(const Duration(seconds: 2));

        if (!mounted) return;

        // ✅ Navigate to Dashboard with both role & email
        context.go('/home_page', extra: {
          'email': emailField.text.trim(),
          'role': startRole,
        });
      } else {
        if (!mounted) return;
        showError("Login failed\n$result", context);
      }
    }
  }
}
