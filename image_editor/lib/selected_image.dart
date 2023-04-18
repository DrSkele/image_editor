import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectedImage extends ChangeNotifier {
  XFile? _imageFile;

  SelectedImage(XFile? file) : _imageFile = file;

  bool get usable => _imageFile != null;
  XFile get file => _imageFile!;
}
