import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<User> loginAdmin(String email, String password) async {
    // sign in with email and password..
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user!;
  }

  // logout method
  static Future<void> logOut() {
    return _auth.signOut();
  }
}
