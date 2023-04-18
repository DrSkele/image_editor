import 'package:flutter/material.dart';
import 'package:image_editor/edit_view.dart';
import 'package:image_editor/selected_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final _imagePicker = ImagePicker();

  void _showError() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('error')));
  }

  void _pushEditor(SelectedImage image) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: image,
          child: const EditView(),
        ),
      ),
    );
  }

  void _pickImage() async {
    var pickedImage = SelectedImage(
        await _imagePicker.pickImage(source: ImageSource.gallery));

    if (pickedImage.usable) {
      _pushEditor(pickedImage);
    } else {
      _showError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _pickImage),
    );
  }
}
