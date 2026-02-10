import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get isLoading => _isLoading;
  String? get userName => _user?.displayName;
  String? get userEmail => _user?.email;

  AuthProvider() {
    // Ascolta i cambiamenti dello stato di autenticazione
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> loginWithGoogle() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Inizia il processo di login con Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return; // Utente ha annullato
      }

      // Ottieni i dettagli dell'autenticazione da Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Crea una nuova credenziale per Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Accedi a Firebase con la credenziale
      await _auth.signInWithCredential(credential);

    } catch (e) {
      print("ERRORE LOGIN GOOGLE: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
