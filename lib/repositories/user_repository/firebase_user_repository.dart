import 'package:firebase_auth/firebase_auth.dart';
import 'package:yuppakids/repositories/repositories.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseUserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<bool> isAuthenticated() async {
    final currentUser = _firebaseAuth.currentUser;
    print(currentUser.uid);
    return currentUser != null;
  }

  Future<void> authenticate() {
    return _firebaseAuth.signInAnonymously();
  }

  Future<String> getUserId() async {
    return (_firebaseAuth.currentUser).uid;
  }
}
