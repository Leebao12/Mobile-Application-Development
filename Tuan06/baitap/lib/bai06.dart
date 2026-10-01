import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const SimpleAudioPlayer());
}

// APP
class SimpleAudioPlayer extends StatelessWidget {
  const SimpleAudioPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Audio Player',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AudioPlayerHome(),
    );
  }
}

// MÀN HÌNH AUDIO PLAYER
class AudioPlayerHome extends StatefulWidget {
  const AudioPlayerHome({super.key});

  @override
  State<AudioPlayerHome> createState() => _AudioPlayerHomeState();
}

class _AudioPlayerHomeState extends State<AudioPlayerHome> {
  late AudioPlayer _audioPlayer;

  int _currentSongIndex = 0;

  bool _isPlaying = false;

  // DANH SÁCH FILE AUDIO
  final List<String> _songs = [
    'assets/audios/chờ chút....mp3',
    'assets/audios/dự báo thời tiết hôm nay mưa.mp3',
    'assets/audios/Tìm Em.mp3'
  ];

  // TÊN HIỂN THỊ
  final List<String> _songTitles = [
    'Chờ chút', 'Dự báo thời tiết hôm nay mưa', 'Tìm Em'
  ];

  // KHỞI TẠO
  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();

    // Theo dõi trạng thái phát nhạc
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    // Khi bài hát kết thúc
    // tự động chuyển sang bài kế tiếp
    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong();
    });
  }

  // PLAY
  Future<void> _playSong() async {
    await _audioPlayer.play(
      AssetSource(_songs[_currentSongIndex].replaceAll('assets/', '')),
    );
  }

  // PAUSE
  Future<void> _pauseSong() async {
    await _audioPlayer.pause();

    setState(() {
      _isPlaying = false;
    });
  }

  // STOP
  Future<void> _stopSong() async {
    await _audioPlayer.stop();

    setState(() {
      _isPlaying = false;
    });
  }

  // NEXT
  Future<void> _nextSong() async {
    await _audioPlayer.stop();

    setState(() {
      if (_currentSongIndex < _songs.length - 1) {
        _currentSongIndex++;
      } else {
        _currentSongIndex = 0;
      }
    });

    await _playSong();
  }

  // PREVIOUS
  Future<void> _previousSong() async {
    await _audioPlayer.stop();

    setState(() {
      if (_currentSongIndex > 0) {
        _currentSongIndex--;
      } else {
        _currentSongIndex = _songs.length - 1;
      }
    });

    await _playSong();
  }

  // DISPOSE
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Audio Player')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ICON ÂM NHẠC
            const Icon(Icons.music_note, size: 100),

            const SizedBox(height: 30),

            // TÊN BÀI HÁT
            Text(
              _songTitles[_currentSongIndex],
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            // CÁC NÚT ĐIỀU KHIỂN
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 50,
                  onPressed: _previousSong,
                ),

                // Play / Pause
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle : Icons.play_circle,
                  ),
                  iconSize: 70,
                  onPressed: () {
                    if (_isPlaying) {
                      _pauseSong();
                    } else {
                      _playSong();
                    }
                  },
                ),

                // Stop
                IconButton(
                  icon: const Icon(Icons.stop_circle),
                  iconSize: 50,
                  onPressed: _stopSong,
                ),

                // Next
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 50,
                  onPressed: _nextSong,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // TRẠNG THÁI
            Text(
              _isPlaying ? 'Đang phát' : 'Đang dừng',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
