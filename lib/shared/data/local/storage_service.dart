/// Storage service interface
// ignore_for_file: public_member_api_docs, dangling_library_doc_comments

abstract class StorageService {
  void init();

  bool get hasInitialized;

  Future<bool> remove(String key);

  Future<Object?> get(String key);

  Future<bool> set(String key, String data);

  Future<void> clear();

  Future<bool> has(String key);
}
