// import 'package:firebase_ml_custom/firebase_ml_custom.dart';
// import 'dart:typed_data';

// // Define your Firebase Custom Model
// final FirebaseCustomRemoteModel remoteModel = FirebaseCustomRemoteModel('your_custom_model');

// // Function to preprocess the user inputaa
// List<List<double>> preprocessUserInput(String userInput) {
//   // Preprocess the user input text
//   List<double> userInputSequence = preprocessData(userInput);

//   // Pad or truncate the sequence to match the model's input length
//   List<double> processedSequence = List<double>.from(userInputSequence.take(66));
//   int remainingLength = 66 - userInputSequence.length;
//   if (remainingLength > 0) {
//     processedSequence.addAll(List<double>.filled(remainingLength, 0));
//   }

//   // Convert the input to a list of lists (required format for Firebase ML Custom input)
//   List<List<double>> userX = [processedSequence];

//   return userX;
// }

// // Function to preprocess the input text
// List<double> preprocessData(String userInput) {
//   // Tokenize the input text
//   List<String> tokens = userInput.split(' ');

//   // Encode the tokens into numerical values
//   List<double> encodedInput = encodeInput(tokens, wordIndex2);

//   return encodedInput;
// }

// // Function to encode input tokens
// List<double> encodeInput(List<String> tokens, Map<String, int> wordIndex2) {
//   List<double> encodedInput = [];

//   for (String token in tokens) {
//     if (wordIndex2.containsKey(token)) {
//       int index = wordIndex2[token]!;
//       encodedInput.add(index.toDouble());
//     } else {
//       encodedInput.add(0);
//     }
//   }

//   return encodedInput;
// }

// // Function to make the prediction using the Firebase ML Custom model
// Future<int> makePrediction(List<List<double>> userX) async {
//   // Get the Firebase ML Custom model
//   final FirebaseModelManager modelManager = FirebaseModelManager.instance;
//   await modelManager.registerRemoteModel(remoteModel);
//   await modelManager.downloadRemoteModelIfNeeded(remoteModel);

//   // Initialize Firebase ML Custom interpreter
//   final FirebaseModelInterpreter interpreter = FirebaseModelInterpreter.instance;

//   // Define the input and output options
//   final FirebaseModelInputOutputOptions inputOutputOptions =
//       FirebaseModelInputOutputOptions([your_input_details], [your_output_details]);

//   // Run the model
//   final results = await interpreter.run(
//     FirebaseModelInterpreterOptions(remoteModel),
//     inputOutputOptions,
//     userX,
//   );

//   // Decode the output to obtain the predicted emotion label
//   var output = results[0][0];
//   int predictedLabel = output.indexOf(output.reduce((value, element) => value > element ? value : element));

//   return predictedLabel;
// }

// // Example usage
// void main() async {
//   String userInput = "hello";
//   List<List<double>> userX = preprocessUserInput(userInput);
//   int predictedLabel = await makePrediction(userX);

//   // Print the results
//   print("User Input: $userInput");
//   print("Predicted Emotion Label: $predictedLabel");
// }
