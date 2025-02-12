import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ro'yhatdan o'tish

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print("Sign up error : $e");
      return null;
    }
  }

  // kirish

  Future<User?> signIn(String email, String password) async
  {
     try{

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final id=userCredential.user;
      
      return userCredential.user;

     }catch(e)
     {
      print("Sign in error : $e");
      return null;
     }
  }


  // chiqish

Future<void> signOut() async
{
   _auth.signOut();
}
}
