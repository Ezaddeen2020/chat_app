// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();

// Future<User?> signInWithGoogle() async {
//   final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//   final AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   UserCredential userCredential = await _auth.signInWithCredential(credential);
//   return userCredential.user;
// }