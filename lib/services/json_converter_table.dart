import 'dart:convert';

class CsvTable {
  final List<String> cabecalho;
  final List<List<String>> colunas;

  CsvTable({required this.cabecalho, required this.colunas});
}

CsvTable? jsonToTable(String json) {
  if (json.trim().isEmpty) {
    return null;
  }

  try {
    final List<dynamic> jsonList = jsonDecode(json);

    if (jsonList.isEmpty || jsonList.first is! Map) {
      return null;
    }

    final Map<String, dynamic> primeiroJson = jsonList.first;
    final List<String> cabecalho = primeiroJson.keys.toList();
    final List<List<String>> colunas = [];

    for (final item in jsonList) {
      if (item is Map) {
        final List<String> valorColuna = cabecalho.map((index) {
          final valor = item[index]?.toString() ?? '';
          return valor;
        }).toList();
        colunas.add(valorColuna);
      }
    }

    return CsvTable(cabecalho: cabecalho, colunas: colunas);
  } catch (erro) {
    return null;
  }
}
