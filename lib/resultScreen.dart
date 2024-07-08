import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class ResultScreen extends StatefulWidget {
  final String word;
  const ResultScreen({super.key, required this.word});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Future<Map<String, dynamic>>?_futurewordData;

  @override
  void initState() {
    super.initState();
    _futurewordData = _fetcgwordDATA(widget.word);
  }

  Future<Map<String, dynamic>> _fetcgwordDATA(String word) async {
    final response = await http.get(
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word')
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)[0];
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futurewordData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final wordData = snapshot.data!;
            final List meanings = wordData['meanings'] ?? [];
            return ListView.builder(
              itemCount: meanings.length,
              itemBuilder: (context, index) {
                final meaning = meanings[index];
                final String partOfSpeech = meaning['partOfSpeech'] ?? '';
                final List definitions = meaning['definitions'] ?? [];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: ListTile(
                      title: Text(partOfSpeech),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: definitions.map<Widget>((definition) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Definition: ${definition['definition'] ?? ''}'),
                                if (definition['example'] != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      'Example: ${definition['example']}',
                                      style: TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}