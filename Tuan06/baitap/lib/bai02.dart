import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const PhotoCaptureApp());
}

class PhotoCaptureApp extends StatelessWidget {
  const PhotoCaptureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Capture & Preview',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const PhotoCaptureHome(),
    );
  }
}

// MÀN HÌNH CHÍNH

class PhotoCaptureHome extends StatefulWidget {
  const PhotoCaptureHome({super.key});

  @override
  State<PhotoCaptureHome> createState() => _PhotoCaptureHomeState();
}

class _PhotoCaptureHomeState extends State<PhotoCaptureHome> {
  // Lưu ảnh đang được chọn/chụp
  File? _imageFile;

  // ImagePicker
  final ImagePicker _picker = ImagePicker();

  // XIN QUYỀN CAMERA
  Future<bool> _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;

    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    return status.isGranted;
  }

  // CHỌN ẢNH TỪ GALLERY
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) {
      return;
    }

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  // CHỤP ẢNH TỪ CAMERA
  Future<void> _captureImageFromCamera() async {
    final bool granted = await _requestCameraPermission();

    if (!granted) {
      _showMessage('Chưa được cấp quyền sử dụng camera.');
      return;
    }

    final XFile? capturedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (capturedFile == null) {
      return;
    }

    setState(() {
      _imageFile = File(capturedFile.path);
    });
  }

  // HIỂN THỊ THÔNG BÁO
  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // XEM ẢNH TOÀN MÀN HÌNH
  void _showFullScreenPreview() {
    if (_imageFile == null) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageFile: _imageFile!),
      ),
    );
  }

  // GIAO DIỆN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Capture & Preview')),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // KHU VỰC HIỂN THỊ ẢNH
            Expanded(
              child: Center(
                child: _imageFile == null
                    ? const Text(
                        'Chưa có ảnh nào được chọn.',
                        style: TextStyle(fontSize: 18),
                      )
                    : GestureDetector(
                        onTap: _showFullScreenPreview,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(_imageFile!, fit: BoxFit.contain),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // NÚT CHỌN ẢNH GALLERY
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickImageFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('Chọn ảnh từ Gallery'),
              ),
            ),

            const SizedBox(height: 10),

            // NÚT CHỤP ẢNH CAMERA
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _captureImageFromCamera,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Chụp ảnh từ Camera'),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// MÀN HÌNH XEM ẢNH TOÀN MÀN HÌNH
class FullScreenImage extends StatelessWidget {
  final File imageFile;

  const FullScreenImage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Xem trước')),

      body: Center(
        child: InteractiveViewer(
          child: Image.file(imageFile, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
