import 'package:flutter/material.dart';
import 'package:json2csv/services/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _jsonController = TextEditingController();
  final TextEditingController _csvController = TextEditingController();

  CsvTable? _csvTable;

  void _convertJsonToCsv() {
    String json = _jsonController.text;
    String csv = convertJsonToCsv(json);
    _csvController.text = csv;

    final CsvTable? table = jsonToTable(json);

    setState(() {
      _csvTable = table;
    });
  }

  void _clear() {
    _jsonController.clear();
    _csvController.clear();
  }

  String _telaSelecionada = 'CSV';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Json2Csv Conversor',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 43, 194, 136),
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Text('Cole aqui seu arquivo Json:'),
                SizedBox(height: 10),
                Expanded(
                  child: TextField(
                    controller: _jsonController,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      labelText: 'Json',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: _clear, child: Text('Limpar')),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _convertJsonToCsv,
                      child: Text('Converter'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                RadioGroup(
                  groupValue: _telaSelecionada,
                  onChanged: (String? valor) {
                    setState(() {
                      _telaSelecionada = valor!;
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          value: 'CSV',
                          title: Text('CSV'),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          value: 'Tabela',
                          title: Text('Tabela'),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_telaSelecionada == 'CSV') ...[
                  Text('Arquivo CSV convertido:'),
                  SizedBox(height: 10),
                  Expanded(
                    child: TextField(
                      controller: _csvController,
                      maxLines: null,
                      expands: true,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'CSV',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ] else if (_csvTable != null) ...[
                  Text('Tabela:'),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Expanded(
                      child: DataTable(
                        columns: _csvTable!.cabecalho
                            .map((index) => DataColumn(label: Text(index)))
                            .toList(),
                        rows: _csvTable!.colunas
                            .map(
                              (index) => DataRow(
                                cells: index
                                    .map((index) => DataCell(Text(index)))
                                    .toList(),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
