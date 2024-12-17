
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/repositories/secure_storage_repository.dart';

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  static final SecureStorageRepositoryImpl _instance =
      SecureStorageRepositoryImpl._internal();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  SecureStorageRepositoryImpl._internal(); // Private constructor for singleton

  factory SecureStorageRepositoryImpl() => _instance;

  // Write a value (handles different types)
  @override
  Future<void> write(String key, dynamic value) async {
    String stringValue = value.toString(); // Convert any type to String
    await _storage.write(key: key, value: stringValue);
  }

  // Read a value with type conversion
  @override
  Future<T?> read<T>(String key) async {
    String? value = await _storage.read(key: key);
    if (value == null) return null;

    // Convert the value back to the appropriate type
    if (T == int) return int.tryParse(value) as T?;
    if (T == double) return double.tryParse(value) as T?;
    if (T == bool) return (value.toLowerCase() == 'true') as T?;
    if (T == String) return value as T;

    throw UnsupportedError('Type $T is not supported');
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  @override
  Future<bool> containsKey(String key) async {
    String? value = await _storage.read(key: key);
    return value != null;
  }
}
