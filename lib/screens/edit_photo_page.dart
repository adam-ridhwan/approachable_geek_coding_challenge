import 'package:approachable_geek_coding_challenge/controllers/user_controller.dart';
import 'package:approachable_geek_coding_challenge/utilities/loading_state.dart';
import 'package:approachable_geek_coding_challenge/utilities/update_field.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_edit_page_header.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_update_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditPhotoPage extends StatefulWidget {
  final String image;

  const EditPhotoPage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  _EditPhotoPageState createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {
  late final UserController userController;

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

  void _handleUpdatePhoto(BuildContext context) {
    UpdateUtilities.updateProfileItem(context, {'image': image});
  }

  @override
  Widget build(BuildContext context) {
    final loadingState = Provider.of<LoadingState>(context);

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
                  Opacity(
                    opacity: loadingState.isLoading ? 0.3 : 1,
                    child: InkWell(
                      onTap: loadingState.isLoading ? null : _pickImage,
                      child: Container(
                        height: screenWidth - (padding * 2),
                        width: screenWidth,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  CustomGlowButton(onPressed: () => _handleUpdatePhoto(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
