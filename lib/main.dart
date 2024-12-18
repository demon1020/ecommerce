import 'core.dart';
import 'core/data/repositories/hive_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await HiveService.init();
  await dotenv.load(fileName: ".env");

  runApp(const App());
}
