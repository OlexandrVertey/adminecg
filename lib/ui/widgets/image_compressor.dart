import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

Future<void> resizeAndCompressImage(Uint8List bytes, Function(Uint8List) callback) async {
  final codec = await ui.instantiateImageCodec(bytes);
  final frameInfo = await codec.getNextFrame();
  int width = frameInfo.image.width;
  int height = frameInfo.image.height;
  final maxWidth = 800.0;
  final maxHeight = 600.0;

  if (width > maxWidth || height > maxHeight) {
    final aspectRatio = width / height;
    if (aspectRatio > 1) {
      width = maxWidth.toInt();
      height = (maxWidth / aspectRatio).toInt();
    } else {
      width = (maxHeight * aspectRatio).toInt();
      height = maxHeight.toInt();
    }
  }

  decodeImageFromPixels(
    (await frameInfo.image.toByteData(format: ui.ImageByteFormat.rawRgba))!
        .buffer
        .asUint8List(),
    width,
    height,
    ui.PixelFormat.rgba8888,
    (resizedImage) async {
      final byteData =
          await resizedImage.toByteData(format: ui.ImageByteFormat.png);
      Uint8List compressedBytes = byteData!.buffer.asUint8List();

      // Повторюємо процес зі стисненням до досягнення цілі (200 кБ)
      int quality = 100;
      while (compressedBytes.length / 1024 > 200 && quality > 10) {
        compressedBytes =
            (await resizedImage.toByteData(format: ui.ImageByteFormat.png))!
                .buffer
                .asUint8List();
        quality -= 10;
      }
      callback(compressedBytes);
    },
  );
}
