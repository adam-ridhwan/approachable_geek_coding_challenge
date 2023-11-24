import 'package:flutter/material.dart';

class EditPhotoPage extends StatelessWidget {
  const EditPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload a photo of yourself:'),
      ),
      body: const Center(
        child: Text('Photo'),
      ),
    );
  }
}
