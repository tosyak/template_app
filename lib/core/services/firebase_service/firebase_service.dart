import 'package:firebase_core/firebase_core.dart';
import 'package:ricknotmorty/firebase_options.dart';

class FirebaseService {
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
