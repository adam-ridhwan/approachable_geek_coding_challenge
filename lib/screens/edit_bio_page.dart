import 'package:flutter/material.dart';

class EditBioPage extends StatelessWidget {
  const EditBioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("What type of passenger are you?"),
      ),
      body: const Center(
        child: Text('Write a little bit about yourself. Do you like Chatting?'
            ' Are you a smoker? Do you bring pets with you? Etc.'),
      ),
    );
  }
}
