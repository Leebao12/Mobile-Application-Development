import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MediaPickerApp());
}

// APP
class MediaPickerApp extends StatelessWidget {
  const MediaPickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Picker App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MediaPickerHome(),
    );
  }
}

// MÀN HÌNH CHÍNH
class MediaPickerHome extends StatefulWidget {
  const MediaPickerHome({super.key});

  @override
  State<MediaPickerHome> createState() => _MediaPickerHomeState();
}

class _MediaPickerHomeState extends State<MediaPickerHome> {
  File? _mediaFile;

  VideoPlayerController? _videoController;

  final ImagePicker _picker = ImagePicker();

  // YÊU CẦU QUYỀN
  Future<bool> _requestPermission(Permission permission) async {
    PermissionStatus status = await permission.status;

    if (!status.isGranted) {
      status = await permission.request();
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

    await _showImage(File(pickedFile.path));
  }

  // CHỤP ẢNH TỪ CAMERA
  Future<void> _captureImageFromCamera() async {
    final bool granted = await _requestPermission(Permission.camera);

    if (!granted) {
      _showMessage('Chưa được cấp quyền camera.');
      return;
    }

    final XFile? capturedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (capturedFile == null) {
      _showMessage('Bạn chưa chụp ảnh.');
      return;
    }

    await _showImage(File(capturedFile.path));
  }

  // HIỂN THỊ ẢNH
  Future<void> _showImage(File file) async {
    _videoController?.dispose();
    _videoController = null;

    setState(() {
      _mediaFile = file;
    });
  }

  // CHỌN VIDEO TỪ GALLERY
  Future<void> _pickVideoFromGallery() async {
    final XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) {
      _showMessage('Bạn chưa chọn video.');
      return;
    }

    await _loadVideo(File(pickedFile.path));
  }

  // QUAY VIDEO TỪ CAMERA
  Future<void> _captureVideoFromCamera() async {
    final bool cameraGranted = await _requestPermission(Permission.camera);

    if (!cameraGranted) {
      _showMessage('Chưa được cấp quyền camera.');
      return;
    }

    final bool microphoneGranted = await _requestPermission(
      Permission.microphone,
    );

    if (!microphoneGranted) {
      _showMessage('Chưa được cấp quyền microphone.');
      return;
    }

    final XFile? capturedFile = await _picker.pickVideo(
      source: ImageSource.camera,
    );

    if (capturedFile == null) {
      _showMessage('Bạn chưa quay video.');
      return;
    }

    await _loadVideo(File(capturedFile.path));
  }

  // LOAD VIDEO
  Future<void> _loadVideo(File file) async {
    _videoController?.dispose();

    final controller = VideoPlayerController.file(file);

    try {
      await controller.initialize();

      setState(() {
        _mediaFile = file;
        _videoController = controller;
      });

      await controller.play();
    } catch (e) {
      controller.dispose();
      _showMessage('Không thể phát video.');
    }
  }

  // HIỂN THỊ THÔNG BÁO
  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // GIẢI PHÓNG VIDEO CONTROLLER
  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  // GIAO DIỆN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Media Picker App')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // KHU VỰC HIỂN THỊ 
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildMediaPreview(),
            ),

            const SizedBox(height: 25),

            // CHỌN ẢNH GALLERY
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickImageFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('Chọn ảnh từ Gallery'),
              ),
            ),

            const SizedBox(height: 10),

            // CHỤP ẢNH CAMERA
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _captureImageFromCamera,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Chụp ảnh từ Camera'),
              ),
            ),

            const SizedBox(height: 10),

            // CHỌN VIDEO
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickVideoFromGallery,
                icon: const Icon(Icons.video_library),
                label: const Text('Chọn video từ Gallery'),
              ),
            ),

            const SizedBox(height: 10),

            // QUAY VIDEO
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _captureVideoFromCamera,
                icon: const Icon(Icons.videocam),
                label: const Text('Quay video từ Camera'),
              ),
            ),

            const SizedBox(height: 20),

            // NÚT PLAY / PAUSE
            if (_videoController != null &&
                _videoController!.value.isInitialized)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 50,
                    onPressed: () {
                      setState(() {
                        if (_videoController!.value.isPlaying) {
                          _videoController!.pause();
                        } else {
                          _videoController!.play();
                        }
                      });
                    },
                    icon: Icon(
                      _videoController!.value.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // WIDGET HIỂN THỊ MEDIA
  Widget _buildMediaPreview() {
    // Chưa chọn gì
    if (_mediaFile == null) {
      return const Center(
        child: Text(
          'Chưa chọn ảnh hoặc video.',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    // NẾU LÀ VIDEO
    if (_videoController != null && _videoController!.value.isInitialized) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: _videoController!.value.size.width,
            height: _videoController!.value.size.height,
            child: VideoPlayer(_videoController!),
          ),
        ),
      );
    }

    // NẾU LÀ ẢNH
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(_mediaFile!, fit: BoxFit.contain),
    );
  }
}
