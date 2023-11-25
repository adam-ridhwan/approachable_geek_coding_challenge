import 'package:flutter/material.dart';
import 'package:flutter_learn_the_basics/widgets/custom_edit_page_header.dart';
import 'package:flutter_learn_the_basics/widgets/custom_update_button.dart';
import 'package:image_picker/image_picker.dart';

class EditPhotoPage extends StatefulWidget {
  final String image;
  final Function(String) updateUserProfile;

  const EditPhotoPage({
    Key? key,
    required this.image,
    required this.updateUserProfile,
  }) : super(key: key);

  @override
  _EditPhotoPageState createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {
  bool isLoading = false;

  String image = '';

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = image.path;
      setState(() => this.image = imageTemporary);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    image = widget.image;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleUpdatePhoto(BuildContext context) async {
    if (!mounted) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Simulate a delay
      await Future.delayed(const Duration(seconds: 2));

      // Check if the widget is still mounted before updating
      if (!mounted) {
        return;
      }

      // Update the photo
      widget.updateUserProfile(image);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      // Check if the widget is still mounted before navigating
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = 40;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 25),
            const CustomEditPageHeader(text: "Upload a photo of yourself:"),
            const SizedBox(height: 35),
            Form(
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: _pickImage, // Call the image picker function on tap
                    child: Container(
                      height: screenWidth - (padding * 2),
                      width: screenWidth,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey), // Optional border
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(image), // Replace with
                          // your asset
                          // image
                        ), // Display nothing if no image selected
                      ),
                    ),
                  ),
                  // Container(
                  //   height: screenWidth - (padding * 2),
                  //   width: screenWidth,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey), // Optional border
                  //     image: DecorationImage(
                  //       fit: BoxFit.cover,
                  //       image: AssetImage(widget.image), // Replace with your asset image
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 50),
                  CustomGlowButton(
                      isLoading: isLoading, onPressed: () => _handleUpdatePhoto(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
