import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const VideoRecorderApp());
}

class VideoRecorderApp extends StatelessWidget {
  const VideoRecorderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Recorder & Playback',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const VideoRecorderHome(),
    );
  }
}

// MÀN HÌNH CHÍNH
class VideoRecorderHome extends StatefulWidget {
  const VideoRecorderHome({super.key});

  @override
  State<VideoRecorderHome> createState() => _VideoRecorderHomeState();
}

class _VideoRecorderHomeState extends State<VideoRecorderHome> {
  // File video hiện tại
  File? _videoFile;

  // Controller để phát video
  VideoPlayerController? _videoController;

  // ImagePicker
  final ImagePicker _picker = ImagePicker();

  // CHỌN VIDEO TỪ GALLERY
  Future<void> _pickVideoFromGallery() async {
    final XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) {
      return;
    }

    await _loadVideo(File(pickedFile.path));
  }

  // QUAY VIDEO TỪ CAMERA
  Future<void> _recordVideoFromCamera() async {
    // Xin quyền camera
    final PermissionStatus cameraStatus = await Permission.camera.request();

    if (!cameraStatus.isGranted) {
      _showMessage('Chưa được cấp quyền Camera.');
      return;
    }

    // Xin quyền microphone
    final PermissionStatus microphoneStatus = await Permission.microphone
        .request();

    if (!microphoneStatus.isGranted) {
      _showMessage('Chưa được cấp quyền Microphone.');
      return;
    }

    final XFile? recordedFile = await _picker.pickVideo(
      source: ImageSource.camera,
    );

    if (recordedFile == null) {
      return;
    }

    await _loadVideo(File(recordedFile.path));
  }

  // LOAD VIDEO
  Future<void> _loadVideo(File videoFile) async {
    // Hủy controller cũ
    await _videoController?.dispose();

    final VideoPlayerController controller = VideoPlayerController.file(
      videoFile,
    );

    try {
      await controller.initialize();

      setState(() {
        _videoFile = videoFile;
        _videoController = controller;
      });

      // Tự động phát sau khi chọn video
      await controller.play();
    } catch (e) {
      await controller.dispose();

      _showMessage('Không thể mở video.');
    }
  }

  // PLAY / PAUSE
  Future<void> _togglePlayPause() async {
    if (_videoController == null) {
      return;
    }

    if (_videoController!.value.isPlaying) {
      await _videoController!.pause();
    } else {
      await _videoController!.play();
    }

    setState(() {});
  }

  // THÔNG BÁO
  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // DISPOSE
  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  // UI
  @override
  Widget build(BuildContext context) {
    final bool hasVideo =
        _videoController != null && _videoController!.value.isInitialized;

    final bool isPlaying = hasVideo && _videoController!.value.isPlaying;

    return Scaffold(
      appBar: AppBar(title: const Text('Video Recorder & Playback')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // KHU VỰC VIDEO
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: hasVideo
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Chưa có video nào được chọn.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            // THANH TIẾN TRÌNH VIDEO
            if (hasVideo)
              VideoProgressIndicator(
                _videoController!,
                allowScrubbing: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),

            const SizedBox(height: 10),

            // NÚT PLAY / PAUSE
            if (hasVideo)
              ElevatedButton.icon(
                onPressed: _togglePlayPause,
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                label: Text(isPlaying ? 'Pause' : 'Play'),
              ),

            const SizedBox(height: 20),

            // CHỌN VIDEO GALLERY
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickVideoFromGallery,
                icon: const Icon(Icons.video_library),
                label: const Text('Chọn video từ Gallery'),
              ),
            ),

            const SizedBox(height: 10),

            // QUAY VIDEO CAMERA
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _recordVideoFromCamera,
                icon: const Icon(Icons.videocam),
                label: const Text('Quay video từ Camera'),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
