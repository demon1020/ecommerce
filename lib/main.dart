import 'core.dart';
import 'core/data/repositories/hive_service.dart';

Future<void> main() async {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();
  await dotenv.load(fileName: ".env");

  // await HiveService.saveProductsFromJson();

  runApp(const App());
}
