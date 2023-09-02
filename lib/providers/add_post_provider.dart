import 'dart:typed_data';
import 'package:flutter/material.dart';

class AddPostProvider extends ChangeNotifier {
  bool _isLoading = false;
  Uint8List? _file;

  bool get isLoading => _isLoading;

  set changeIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Uint8List? get getFile {
    if (_file == null) {
      return null;
    }
    return _file;
  }

  set setImage(Uint8List image) {
    _file = image;
    notifyListeners();
  }

  resetImage() {
    _file = null;
    notifyListeners();
  }
}
