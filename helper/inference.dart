import 'dart:io';
import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:welcome_app/helper/load_model.dart';
// import 'package:tflite_flutter_select_tf_ops/tflite_flutter_select_tf_ops.dart';

// String modelFilePath = 'assets/lstm_ed';

// Define wordIndex2 as a global variable or import it from another file
Map<String, int> wordIndex2 = {
  'word1': 1,
  'word2': 2,
  // Add more words and their corresponding indices as needed
};


// Function to preprocess the user input
List<List<double>> preprocessUserInput(String userInput) {
  // Preprocess the user input text
  List<double> userInputSequence = preprocessData(userInput);

  // Pad or truncate the sequence to match the model's input length
  List<double> processedSequence = List<double>.from(userInputSequence.take(66));
  int remainingLength = 66 - userInputSequence.length;
  if (remainingLength > 0) {
    processedSequence.addAll(List<double>.filled(remainingLength, 0));
  }

  // Convert the input to a list of lists (required format for TFLite input)
  List<List<double>> userX = [processedSequence];

  return userX;
}

// Function to preprocess the input text
List<double> preprocessData(String userInput) {
  // Tokenize the input text
  List<String> tokens = userInput.split(' ');

  // Encode the tokens into numerical values
  List<double> encodedInput = encodeInput(tokens, wordIndex2);

  return encodedInput;
}

// Function to encode input tokens
List<double> encodeInput(List<String> tokens, Map<String, int> wordIndex2) {
  List<double> encodedInput = [];

  for (String token in tokens) {
    if (wordIndex2.containsKey(token)) {
      int index = wordIndex2[token]!;
      encodedInput.add(index.toDouble());
    } else {
      encodedInput.add(0);
    }
  }

  return encodedInput;
}


Future<int> makePrediction(List<List<double>> userX) async {
  try {
    final Interpreter interpreter = await loadModelData();
    interpreter.allocateTensors();

    // Get input and output tensor indices
    final inputTensor = interpreter.getInputTensor(0);
    final outputTensor = interpreter.getOutputTensor(0);

    // Prepare input data
    final input = userX.expand((element) => element).toList();
    final inputUint8 = Uint8List.fromList(input.map((e) => e.toInt()).toList());
    inputTensor.data = inputUint8;

    // Run inference
    interpreter.invoke();

    // Get output data
    final output = outputTensor.data as List<double>;

    // Decode the output to obtain the predicted label
    int predictedLabel = output.indexOf(output.reduce((value, element) => value > element ? value : element));

    return predictedLabel;
  } catch (e) {
    print("Error making prediction: $e");
    throw e;
  }
}




// Future<void> applyFlexDelegate(Interpreter interpreter) async {
//   try {
//     final delegate = await TfliteDelegate.create();
//     interpreter.addDelegate(delegate);
//   } catch (e) {
//     print("Error applying Flex delegate: $e");
//     throw e;
//   }
// }







// Example usage

void main() async {
  String userInput = "hello";
  List<List<double>> userX = preprocessUserInput(userInput);
  int predictedLabel = await makePrediction(userX);

  // Print the results
  print("User Input: $userInput");
  print("Predicted Emotion Label: $predictedLabel");
}
