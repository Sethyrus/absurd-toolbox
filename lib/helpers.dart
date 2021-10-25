void log({required String key, Object? value}) {
  print('[DEBUG] ' + key + (value != null ? ': ' : ''));

  if (value != null) print(value);
}
