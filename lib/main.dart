import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'native.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OCR demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlatformFile? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file?.name ?? 'No file'),
        actions: [
          IconButton(
            onPressed: () async {
              if (file == null) return;

              print(await api.scan(filePath: file!.path!));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        child: ElevatedButton(
          child: Text("Select file"),
          onPressed: () async {
            PlatformFile? file =
                (await FilePicker.platform.pickFiles(allowMultiple: false))
                    ?.files
                    .first;
            setState(() {
              this.file = file;
            });
          },
        ),
      ),
    );
  }
}
