import 'dart:convert';

String convertJsonToCsv(String json) {
  // ver se o json está vazio ou não
  if (json.trim().isEmpty) {
    return 'Json vazio. Insira um json';
  }

  // ver se o json é válido
  try {
    final List<dynamic> jsonList = jsonDecode(json);

    if (jsonList.isEmpty) {
      return 'Json váido, mas vazio.';
    }

    // aqui pego o primeiro item do json para descobrir os valores do cabeçalho do csv
    final Map<String, dynamic> primeiroJson = jsonList.first;
    final List<String> cabecalho = primeiroJson.keys.toList();

    // StringBuffer usada para concatenar
    final StringBuffer csv = StringBuffer(cabecalho.join(','));
    csv.writeln();

    for (final item in jsonList) {
      if (item is Map) {
        final List<String> valores = cabecalho.map((index) {
          var valor = item[index]?.toString() ?? '';

          if (valor.contains(',')) {
            valor = '"$valor"';
          }
          return valor;
        }).toList();

        // coloca uma nova linha e os valores ao csv
        csv.writeln(valores.join(','));
      }
    }

    return csv.toString();
  } catch (erro) {
    return 'Json não é válido. $erro';
  }
}
