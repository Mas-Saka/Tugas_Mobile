import 'package:firebase_auth/firebase_auth.dart';

class LayananAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get statusLogin {
    return _auth.authStateChanges();
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return 'Email atau password salah.';
      }

      if (e.code == 'invalid-email') {
        return 'Format email tidak valid.';
      }

      if (e.code == 'user-not-found') {
        return 'Akun belum terdaftar.';
      }

      if (e.code == 'wrong-password') {
        return 'Password salah.';
      }

      return 'Terjadi kesalahan saat login.';
    }
  }

  Future<String?> daftar(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Setelah daftar, keluar dulu supaya kembali ke halaman login.
      await _auth.signOut();

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email sudah digunakan.';
      }

      if (e.code == 'invalid-email') {
        return 'Format email tidak valid.';
      }

      if (e.code == 'weak-password') {
        return 'Password terlalu lemah.';
      }

      return 'Terjadi kesalahan saat membuat akun.';
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
