import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _jsonController = TextEditingController();
  final TextEditingController _csvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Json2Csv Conversor',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 43, 194, 136),
        centerTitle: true,
      ),

      body: Padding(
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
                  ElevatedButton(onPressed: () {}, child: Text('Limpar')),
                  SizedBox(width: 10),
                  ElevatedButton(onPressed: () {}, child: Text('Converter')),
                ],
              ),
              SizedBox(height: 10),
              Text('CSV:'),
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
            ],
          ),
        ),
      ),
    );
  }
}
