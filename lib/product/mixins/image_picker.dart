import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


mixin ImagePickerMixin<T extends StatefulWidget> on State<T> {
  File? imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {

      PermissionStatus status;

      if (Platform.isIOS) {
        // iOS → Fotoğraflar izni
        status = await Permission.photos.request();
      } else if (Platform.isAndroid) {
        // Android 13+ için photos, daha düşük sürümler için storage
        status = await Permission.photos.request();
        if (status.isDenied) {
          status = await Permission.storage.request();
        }
      } else {
        status = PermissionStatus.denied;
      }

      if (status.isGranted) {
        final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: ImageSizeEnum.imagePickerWidthAndHeight.value,
          maxHeight: ImageSizeEnum.imagePickerWidthAndHeight.value,
          imageQuality: ImageSizeEnum.imagePickerImageQuality.value.toInt(),
        );

        print("🔥 Image picker tamamlandı. Seçilen dosya: ${pickedFile?.path}");

        if (pickedFile != null) {
          setState(() {
              imageFile = File(pickedFile.path);
          });

          // Başarı mesajı göster
          showSnackBar(context, "✅ Resim başarıyla seçildi!");
        } else {
          showSnackBar(context, "❌ Resim seçilmedi");
        }
      } else if (status.isDenied) {
        showSnackBar(context, "Fotoğraflara erişim izni gerekli");
      } else if (status.isPermanentlyDenied) {
        // Ayarlara yönlendir
        openAppSettings();
      }
    } catch (e) {

      showSnackBar(context, "❌ Hata oluştu: $e");
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}