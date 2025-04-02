extension GetValueOrNull on Map<String, dynamic> {
  T? getValueOrNull<T>(String key) {
    if (!containsKey(key) || this[key] == null) {
      return null;
    }
    return this[key] as T;
  }

  T getValueOrDefault<T>(String key, T defaultValue) {
    if (!containsKey(key) || this[key] == null) {
      return defaultValue;
    }
    return this[key] as T;
  }
}
