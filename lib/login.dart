// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class loginScreen extends StatefulWidget {
//   const loginScreen({super.key});

//   @override
//   State<loginScreen> createState() => loginScreenState();
// }

// class loginScreenState extends State<loginScreen> {
//   final TextEditingController emailField = TextEditingController();
//   final TextEditingController passwordField = TextEditingController();
//   String startRole = "Educator"; // Default start role

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient( // Making the background gradient
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color.fromARGB(170, 208, 104, 227), Colors.white],
//           ),
//         ),
//         child: Center(
//         child: Container( // Creating the area for entering data
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: const [BoxShadow(
//               color: Colors.white,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),],
//           ),
//           width: 350,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.purple[100],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(Icons.menu_book_rounded, color: Colors.purple, size: 40),
//               ),
//               const SizedBox(height: 16),

//               // Title text
//               const Text(
//                 'CollabEase',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(142, 111, 13, 197),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               const Text(
//                 'Log in to teach, learn, and grow together',
//                 style: TextStyle(color: Colors.black),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),

//               // Email field
//               TextField(
//                 controller: emailField,
//                 decoration: InputDecoration(
//                   labelText: 'Enter email...',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Password field
//               TextField(
//                 controller: passwordField,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Enter password...',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Selecting the user's role
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('I am a...', style: TextStyle(color: Colors.grey)),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [roleButton('Educator'), const SizedBox(width: 10), roleButton('Learner'),],
//               ),
//               const SizedBox(height: 24),

//               // Log in button
//               ElevatedButton(
//                 onPressed: () => context.go('/home_page', extra: startRole),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromARGB(142, 111, 13, 197),
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text(
//                   'Log in',
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // Create account button
//               TextButton(
//                 onPressed: () => context.go('/signup'), // Go to signup page if clicked
//                 child: const Text('Create an Account', style: TextStyle(color: Colors.purple),)
//               ),
//             ],
//           ),
//       ),
//         ),
//       ),
//     );
//   }
      
//   Widget roleButton(String role) { // Making the learner and educator buttons
//     final selected = startRole == role;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => setState(() => startRole = role),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           decoration: BoxDecoration(
//             color: selected ? Color.fromARGB(142, 111, 13, 197) : Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: selected ? Color.fromARGB(142, 111, 13, 197) : Colors.grey,
//             ),
//           ),
//           child: Center(
//             child: Text(
//               role,
//               style: TextStyle(
//                 color: selected ? Colors.white : Colors.black,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => loginScreenState();
}

class loginScreenState extends State<loginScreen> {
  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();
  String startRole = "Educator"; // Default start role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 👈 Important fix
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
            child: SingleChildScrollView( // 👈 Makes content scrollable
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

                    TextField(
                      controller: emailField,
                      decoration: InputDecoration(
                        labelText: 'Enter email...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: passwordField,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Enter password...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('I am a...',
                          style: TextStyle(color: Colors.grey)),
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

                    ElevatedButton(
                      onPressed: () => context.go('/home_page', extra: startRole),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(142, 111, 13, 197),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
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
            color: selected
                ? Color.fromARGB(142, 111, 13, 197)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? Color.fromARGB(142, 111, 13, 197)
                  : Colors.grey,
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
}


