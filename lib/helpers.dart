void log({required String key, Object? value, bool? debug}) {
  print((debug == true ? '[DEBUG] ' : '') + key + (value != null ? ': ' : ''));

  if (value != null) print(value);
}
