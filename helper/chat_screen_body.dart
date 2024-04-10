// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:welcome_app/screens/chat_screen.dart';

// class ChatScreenBody extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChatScreen>(
//       builder: (context, state, _) {
//         return Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: state.messages.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(state.messages[index]),
//                   );
//                 },
//               ),
//             ),
//             TextField(
//               onChanged: (text) {
//                 // Update typing status in the state
//                 state.setTypingStatus(text.isNotEmpty);
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Add new message to the state
//                 state.addMessage('New Message');
//               },
//               child: Text('Send Message'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
