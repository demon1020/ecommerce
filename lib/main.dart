import 'core.dart';
import 'core/data/repositories/hive_service.dart';

Future<void> main() async {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();
  await HiveService.saveProductsFromJson();

  runApp(const App());
}
