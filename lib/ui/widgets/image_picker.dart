import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class AppImagePicker {
  static Future<Uint8List?> getImage({int? size}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    Uint8List? bytes = await image?.readAsBytes();
    Uint8List bytesres = await resizeAndCompressImage(bytes!, size ?? 50);
    return bytesres;
  }

  static Future<Uint8List> resizeAndCompressImage(Uint8List data, int targetSizeKb) async {
    // Декодуємо зображення з Uint8List.
    img.Image image = img.decodeImage(data)!;

    // Ініціалізуємо змінні для циклу.
    Uint8List compressedData;
    int quality = 100; // Початкова якість.
    int targetSizeBytes = targetSizeKb * 1024;

    do {
      // Змінюємо розмір зображення, наприклад, до половини.
      img.Image resizedImage = img.copyResize(image,
          width: (image.width * 0.5).toInt(),
          height: (image.height * 0.5).toInt());

      // Кодуємо зображення з новою якістю.
      compressedData = Uint8List.fromList(img.encodeJpg(resizedImage, quality: quality));

      // Зменшуємо якість на наступний крок.
      quality -= 5;

      // Якщо вже не може більше знижуватись якість (бо дійшло до 0), виходимо.
      if (quality <= 0) break;

    } while (compressedData.length > targetSizeBytes);

    return compressedData;
  }
}
