import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  static Future<Uint8List?> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    Uint8List? bytes = await image?.readAsBytes();
    return bytes;
  }
}
