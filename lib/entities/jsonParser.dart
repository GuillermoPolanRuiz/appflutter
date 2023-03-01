import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

const initialAssetFile = 'assets/save.json';
const localFilename = 'data.json';

class Repository {
  /// Initially check if there is already a local file.
  /// If not, create one with the contents of the initial json in assets
  Future<File> _initializeFile() async {
    final localDirectory = await getApplicationDocumentsDirectory();
    final file = File('$localDirectory/$localFilename');

    if (!await file.exists()) {
      // read the file from assets first and create the local file with its contents
      final initialContent = await rootBundle.loadString(initialAssetFile);
      await file.create();
      await file.writeAsString(initialContent);
    }

    return file;
  }

  Future<String> readFile() async {
    final file = await _initializeFile();
    return await file.readAsString();
  }

  Future<void> writeToFile(String data) async {
    final file = await _initializeFile();
    await file.writeAsString(data);
  }
}