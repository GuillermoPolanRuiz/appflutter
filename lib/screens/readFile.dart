import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ReadFile {
  _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/data.txt');
    await file.writeAsString(text);
  }

  Future<String> _read() async {
  String text="";
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    text = await file.readAsString();
  } catch (e) {
    print("Couldn't read file");
  }
    return text;
  }
}