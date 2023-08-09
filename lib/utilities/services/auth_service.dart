import 'package:budget_maker_app/config/delegates/main_delegate.dart';
import 'package:budget_maker_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

/// Service d'authentification
/// Fait à partir de https://firebase.flutter.dev/docs/auth/usage/
class AuthService {
  /// Retourne l'utilisateur courant
  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  /// Connecte l'utilisateur avec l'email et le mot de passe spécifiés
  static Future<UserCredential> signInWithPassword(
      String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }

  /// Enregistre l'utilisateur avec l'email, le mot de passe et le nom d'affichage spécifiés
  static Future<UserCredential> registerUser(String email, String newPassword,
      {String? displayName}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: newPassword);

    if (displayName != null) {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);
    }

    return userCredential;
  }

  /// Met à jour le nom d'affichage de l'utilisateur courant
  static Future<User> updateDisplayName(String displayName) async {
    var user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(displayName);
    return user!;
  }

  /// Connecte l'utilisateur avec Google
  static Future<UserCredential> signInWithGoogle() async {
    // Si web, utilise le popup
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    }

    // Si mobile, utilise le plugin
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId: (Platform.isIOS)
                ? DefaultFirebaseOptions.currentPlatform.iosClientId
                : null)
        .signIn();

    // Si l'utilisateur n'a pas sélectionné de compte, retourne une erreur
    if (googleUser == null) {
      throw Error();
    }

    // Obtient les informations d'authentification
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Crée les informations d'identification
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Connecte l'utilisateur
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Déconnecte l'utilisateur
  static Future<void> disconnectUser({BuildContext? context}) async {
    await FirebaseAuth.instance.signOut();

    mainDelegate.beamToNamed('/auth/login');
  }

  /// Envoie un email de réinitialisation de mot de passe à l'utilisateur avec l'email spécifié
  static Future<void> sendResetPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
