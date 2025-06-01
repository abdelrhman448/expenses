import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<String?> pickImage(BuildContext context) async {
    final picker = ImagePicker();
    String? imagePath;

    await showModalBottomSheet(
      context: context,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title:  Text(
                    'Take Photo',
                  style: Theme.of(context).textTheme.font14With400(),
                ),
                onTap: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  imagePath = pickedFile?.path;
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title:  Text(
                    'Choose from Gallery',
                  style: Theme.of(context).textTheme.font14With400(),
                ),
                onTap: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  imagePath = pickedFile?.path;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );

    return imagePath;
  }
}
