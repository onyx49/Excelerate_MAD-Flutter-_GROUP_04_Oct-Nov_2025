import 'package:firebase_auth/firebase_auth.dart';


class FireStoreUtils {
  static FirebaseAuth auth = FirebaseAuth.instance;

static Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (exception, s) {
      print(exception.toString() + '$s');
      switch ((exception).code) {
        case 'network-request-failed':
          return "Check your Internet connection and try again";
        case 'invalid-email':
          return 'Email address is malformed.';
        case 'wrong-password':
          return 'Wrong password.';
        case 'user-not-found':
          return 'No user corresponding to the given email address.';
        case 'user-disabled':
          return 'This user has been disabled.';
        case 'invalid-credential':
          return 'Invalid username or password';  
        case 'too-many-requests':
          return 'Too many attempts to sign in as this user.';
      }
      
      return 'Something went wrong, Please contact Support';
    } catch (e) {
      // Handle any other unexpected errors
      print('Login error: $e');
      return null;
    }
  }

   static Future<dynamic> logout() async {
    try {
      await auth.signOut();

     return 'User logged out successfully';
    } catch (e) {
      return "Error logging out:\n $e";
    }
  }



}
