import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:file_picker/file_picker.dart';

const _imageQuality = 25;

getFileSize(String filepath, int decimals) async {
  var file = File(filepath);
  int bytes = await file.length();
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
}

class ImagePickerService {
  // static Future<File> scan(context) async {
  //   bool isCameraGranted = await Permission.camera.request().isGranted;
  //   if (!isCameraGranted) {
  //     isCameraGranted = await Permission.camera.request() == PermissionStatus.granted;
  //   }
  //   if (!isCameraGranted) {}
  //   String imagePath = join((await getApplicationDocumentsDirectory()).path, "${(DateTime.now().toString())}.png");
  //   print("path $imagePath");
  //   await EdgeDetection.detectEdge(
  //     imagePath,
  //     canUseGallery: true,
  //     androidScanTitle: 'Scanning',
  //     androidCropTitle: 'Crop',
  //     androidCropBlackWhiteTitle: 'Black White',
  //     androidCropReset: 'Reset',
  //   );
  //   return File(imagePath);
  // }

  static Future<File?> scan(context) async {
    var status = await Permission.camera.status;
    try {
      if (status.isPermanentlyDenied) {
      } else {
        final pickedImage = await ImagePicker()
            .pickImage(imageQuality: _imageQuality, source: ImageSource.camera, maxHeight: 300, maxWidth: 300);
        if (pickedImage != null) {
          return File(pickedImage.path);
        } else {
          return null;
        }
      }
    } catch (e) {}
    return null;
  }

  static Future<File?> singleGalleryImage(context) async {
    var status = await Permission.photos.status;

    try {
      if (status.isPermanentlyDenied) {
        await Permission.photos.request();
      } else {
        final pickedImage = await ImagePicker().pickImage(
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: _imageQuality,
          source: ImageSource.gallery,
        );

        if (pickedImage != null) {
          return File(pickedImage.path);
        } else {
          return null;
        }
      }
    } catch (e) {}
    return null;
  }

  static Future<File?> singleFileUpload(context) async {
    try {
      final pickedImage = await FilePicker.platform.pickFiles();
      if (pickedImage != null) {
        print("pickedImage.paths: ${pickedImage.paths}");
        return File(pickedImage.paths[0]!);
      } else {
        return null;
      }
    } catch (e) {
      print("error is: $e");
    }
    return null;
  }

  static Future multiGalleryImage(context) async {
    var status = await Permission.photos.status;
    try {
      if (status.isPermanentlyDenied) {
      } else {
        // final pickedImage = await ImagePicker().pickMultiImage(
        //   imageQuality: _imageQuality,
        // );
        var pickedImage = await FilePicker.platform.pickFiles(allowMultiple: true);
        return pickedImage!.paths.map((path) => File(path!)).toList();
      }
    } catch (e) {}
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImagePickerProvider extends ChangeNotifier {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _image;
//
//   XFile? get image => _image;
//
//   Future<void> pickImage(ImageSource source) async {
//     final XFile? selectedImage = await _picker.pickImage(source: source);
//     if (selectedImage != null) {
//       _image = selectedImage;
//       notifyListeners();
//     }
//   }
//
//   void clearImage() {
//     _image = null;
//     notifyListeners();
//   }
// }
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'image_picker_provider.dart';
//
// class ImagePickerWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ImagePickerProvider>(
//       builder: (context, imageProvider, child) {
//         return Column(
//           children: [
//             if (imageProvider.image != null)
//               Image.file(File(imageProvider.image!.path)),
//             ElevatedButton(
//               onPressed: () => _showImageSourceDialog(context),
//               child: Text('Pick Image'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showImageSourceDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Choose Image Source'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.camera),
//                 title: Text('Camera'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Provider.of<ImagePickerProvider>(context, listen: false)
//                       .pickImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Provider.of<ImagePickerProvider>(context, listen: false)
//                       .pickImage(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
