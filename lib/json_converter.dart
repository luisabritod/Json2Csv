import 'dart:convert';

String convertJsonToCsv(String json) {
  // ver se o json está vázio ou não
  if (json.trim().isEmpty) {
    return 'Json vázio. Insira um json';
  }

  // ver se o json é válido
  try {
    final List<dynamic> jsonList = jsonDecode(json);
    return 'json to csv: $jsonList';
  } catch (erro) {
    return 'Json não é válido. $erro';
  }
}
