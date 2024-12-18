import 'package:ecommerce/features/home/data/models/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String productsBoxName = 'productsBox';
  static const String cartProductsBoxName = 'cartProductsBoxName';
  static const String sellerProductsBoxName = 'sellerProductsBoxName';

  /// Initialize Hive and register adapters
  static Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();

    // Register Hive adapters
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(PriceAdapter());
    Hive.registerAdapter(AmountAdapter());
    Hive.registerAdapter(SellerAdapter());
    await Hive.openBox<Product>(productsBoxName);
  }

  /// Open a specific box
  static Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  /// Add or update a value in the box
  static Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  /// Retrieve a value from the box
  static Future<T?> get<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  /// Retrieve all values from the box
  static Future<List<T>> getAll<T>(String boxName) async {
    final box = await openBox<T>(boxName);
    return box.values.cast<T>().toList();
  }

  /// Delete a specific value in the box
  static Future<void> delete<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    await box.delete(key);
  }

  /// Clear all data in the box
  static Future<void> clear<T>(String boxName) async {
    final box = await openBox<T>(boxName);
    await box.clear();
  }

  /// Close the box (optional)
  static Future<void> closeBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box<T>(boxName);
      await box.close();
    }
  }

  /// Close all open boxes
  static Future<void> closeAllBoxes() async {
    await Hive.close();
  }

  // static Future<void> saveProductsFromJson() async {
  //   final box = Hive.box<Product>(productsBoxName);
  //
  //   if (box.isEmpty) {
  //     // Load JSON from assets
  //     final String jsonString =
  //         await rootBundle.loadString('assets/products.json');
  //     final jsonData = json.decode(jsonString);
  //     final MyProductResponseModel responseModel =
  //         MyProductResponseModel.fromJson(jsonData);
  //
  //     // Save each product into the Hive box
  //     for (var product in responseModel.products ?? []) {
  //       box.put(product.id, product);
  //     }
  //   }
  // }

  Future<void> addProductToCart(Product product) async {
    final box = await Hive.openBox<Product>(cartProductsBoxName);
    await box.put(
        int.parse(product.productId.toString().substring(5, 10)), product);
  }

  Future<List<Product>> getCartProducts() async {
    final box = await Hive.openBox<Product>(cartProductsBoxName);
    return box.values.toList();
  }
}
