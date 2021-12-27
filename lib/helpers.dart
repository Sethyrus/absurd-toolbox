void log({required String key, Object? value, bool? debug}) {
  print((debug == true ? '[DEBUG] ' : '') + key + (value != null ? ': ' : ''));

  if (value != null) print(value);
}

bool isEmailValid(String email) => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
