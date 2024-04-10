import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:path_provider/path_provider.dart';


Future<Interpreter> loadModelData() async {
  try {
    final ByteData modelByteData = await rootBundle.load('assets/lstm_ed.tflite');
    final ByteBuffer buffer = modelByteData.buffer;
    final Uint8List modelUint8List = buffer.asUint8List();
    final interpreter = Interpreter.fromBuffer(modelUint8List);
    interpreter.allocateTensors(); // Allocate memory for input and output tensors
    return interpreter;
  } catch (e) {
    throw Exception('Error loading model data: $e');
  }
}



// Future<File> writeAssetToFile(String assetPath) async {
//   final ByteData data = await loadModelData();
//   final Uint8List bytes = data.buffer.asUint8List();
//   final tempDir = await getTemporaryDirectory();
//   final tempFile = File('${tempDir.path}/temp_model.tflite');
//   await tempFile.writeAsBytes(bytes);
//   return tempFile;
// }





// Future<File> copyModelToCache(String modelName) async {
//   try {
//     // Get the path to the app's cache directory
//     final cacheDir = await getTemporaryDirectory();
//     final modelFile = File('${cacheDir.path}/$modelName');

//     // Check if the model file already exists in the cache directory
//     if (!await modelFile.exists()) {
//       // Load the model file from the assets folder
//       final ByteData data = await rootBundle.load('assets/$modelName');
//       final buffer = data.buffer;

//       // Write the model data to the cache directory
//       await modelFile.writeAsBytes(buffer.asUint8List());
//     }

//     return modelFile;
//   } catch (e) {
//     print('Error copying model file to cache: $e');
//     throw e;
//   }
// }


// Future<Interpreter> loadModel(String modelFileName) async {
//   try {
//     // Copy the model file to the cache directory
//     final modelFile = await copyModelToCache(modelFileName);
    
//     // Create an instance of Interpreter and load the model
//     final interpreter = Interpreter.fromFile(modelFile);
//     interpreter.allocateTensors(); // Allocate memory for input and output tensors
//     return interpreter;
//   } catch (e) {
//     print('Error loading model: $e');
//     throw e; // Rethrow the error to handle it elsewhere if needed
//   }
// }


//tflite_v2 attempt for connecting model 


