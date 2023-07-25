import 'package:brew_app/app/app.dart';
import 'package:brew_app/bootstrap.dart';
import 'package:brew_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await bootstrap(() => const App());
}
