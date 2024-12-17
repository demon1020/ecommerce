abstract class SecureStorageRepository {
  Future<void> write(String key, dynamic value);
  Future<T?> read<T>(String key);
  Future<void> delete(String key);
  Future<Map<String, String>> readAll();
  Future<void> deleteAll();
  Future<bool> containsKey(String key);
}
