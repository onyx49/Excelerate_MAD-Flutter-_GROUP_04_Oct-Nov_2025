import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_04_app/services/helper.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => signupScreenState();

}

class signupScreenState extends State<signupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String startRole = "Educator";
  bool _obscureText = true;

   void _togglePassVisible(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // making the background gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(170, 208, 104, 227), Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(
                color: Colors.white,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),],
            ),
            width: 350,
            child: Form (
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
                child: const Icon(Icons.menu_book_sharp, color: Colors.purple, size: 40),
              ),
              const SizedBox(height: 16),

              // Title text
              const Text(
                'CollabEase',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(142, 111, 13, 197),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Create an account to teach, learn, and grow together',
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Email field
              TextFormField(
                validator: validateEmail,
                controller: emailField,
                decoration: InputDecoration(
                  labelText: 'Enter email...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                
              ),
              
              const SizedBox(height: 16),

              // Password field
              TextFormField(
                controller: passwordField,
                validator: validatePassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Enter password...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(onPressed: _togglePassVisible, icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility
                      )),
                ),
                
              ),
              const SizedBox(height: 16),

              // Confirming password field
              TextFormField(
                 validator: (val) =>
                validateConfirmPassword(passwordField.text, val),
            // onSaved: (String? val) {
            //   confirmPassword = val;
            // },
                obscureText: _obscureText,
                controller: confirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm password...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  // suffixIcon: IconButton(onPressed: _togglePassVisible, icon: Icon(
                  //       _obscureText ? Icons.visibility_off : Icons.visibility
                  //     )),
                ),
              ),
              const SizedBox(height: 16),

              // Selecting the user's role
              Align(
                alignment: Alignment.centerLeft,
                child: Text('I am a/an...', style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [roleButton('Educator'), const SizedBox(width: 10), roleButton('Learner'),],
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 12),

              // Create account button
              ElevatedButton(
                onPressed: () async {
                  
                  await createUserWithEmailAndPassword();

                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: Color.fromARGB(142, 111, 13, 197),
                   minimumSize: const Size(double.infinity, 50),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child:
                 const Text('Create Account', style: TextStyle(color: Colors.white),),
              ),
              
              // Return to login screen
              const SizedBox(height: 10),
              TextButton(onPressed: () => context.go('/'), child: const Text('Return to login', style: TextStyle(color: Colors.purple))),
            ],
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
            color: selected ? Color.fromARGB(142, 111, 13, 197) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? Color.fromARGB(142, 111, 13, 197) : Colors.grey,
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


Future<void> createUserWithEmailAndPassword() async {
  if (_formKey.currentState!.validate()){
    showProgress( 'Creating Account....');
  await Future.delayed(const Duration(seconds: 3));
  if (!mounted) return;
  showSuccess("Account Created Successfully", context);
  await Future.delayed(const Duration(seconds: 3));
  if (!mounted) return;
  showError("Account creation failed", context);
 

  }
  
//   try {
//     EasyLoading.show(status: 'Creating Account....');
//     final userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword
//   ( email: emailField.text.trim(), 
//   password: passwordField.text.trim(),
//   );
//   if (userCred != null) {
//     EasyLoading.showSuccess('Account was successfully created continue to login');
//     context.go('/');
//     print (userCred);
//   }
  
// } on FirebaseAuthException catch (e) {
//     EasyLoading.showError('Failed to create Account\n${e.message}');
//     print (e.message);
//   } 
}
  



}

