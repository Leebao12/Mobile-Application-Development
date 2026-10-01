import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MusicApp());
}

// APP
class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Music',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF09091A),
        fontFamily: 'Roboto',
      ),
      home: const MusicHomePage(),
    );
  }
}

// MÀN HÌNH CHÍNH
class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  late AnimationController _rotationController;

  int _currentSongIndex = 0;

  bool _isPlaying = false;
  bool _isFavorite = false;

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  // DANH SÁCH NHẠC
  final List<String> _songs = [
    'assets/audios/chờ chút....mp3',
    'assets/audios/dự báo thời tiết hôm nay mưa.mp3',
    'assets/audios/Tìm Em.mp3',
  ];

  final List<String> _songTitles = [
    'Chờ chút',
    'Dự báo thời tiết hôm nay mưa',
    'Tìm Em',
  ];

  final List<String> _artists = ['My Playlist', 'My Playlist', 'My Playlist'];

  // Mỗi bài có một bộ màu riêng
  final List<List<Color>> _songGradients = [
    [const Color(0xFF7F00FF), const Color(0xFFE100FF)],
    [const Color(0xFF00C6FF), const Color(0xFF0072FF)],
    [const Color(0xFFFF512F), const Color(0xFFDD2476)],
  ];

  final List<IconData> _songIcons = [
    Icons.nightlife_rounded,
    Icons.cloud_rounded,
    Icons.favorite_rounded,
  ];

  // KHỞI TẠO
  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    // Thời lượng
    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (!mounted) return;

      setState(() {
        _duration = newDuration;
      });
    });

    // Vị trí phát
    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (!mounted) return;

      setState(() {
        _position = newPosition;
      });
    });

    // Trạng thái phát
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;

      final playing = state == PlayerState.playing;

      setState(() {
        _isPlaying = playing;
      });

      if (playing) {
        _rotationController.repeat();
      } else {
        _rotationController.stop();
      }
    });

    // Khi bài hát kết thúc
    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong();
    });
  }

  // PLAY
  Future<void> _playSong() async {
    await _audioPlayer.play(
      AssetSource(_songs[_currentSongIndex].replaceFirst('assets/', '')),
    );
  }

  // PAUSE / RESUME
  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _playSong();
    }
  }

  // STOP
  Future<void> _stopSong() async {
    await _audioPlayer.stop();

    if (!mounted) return;

    setState(() {
      _position = Duration.zero;
    });

    _rotationController.stop();
    _rotationController.reset();
  }

  // NEXT
  Future<void> _nextSong() async {
    await _audioPlayer.stop();

    if (!mounted) return;

    setState(() {
      if (_currentSongIndex < _songs.length - 1) {
        _currentSongIndex++;
      } else {
        _currentSongIndex = 0;
      }

      _position = Duration.zero;
      _duration = Duration.zero;
      _isFavorite = false;
    });

    _rotationController.reset();

    await _playSong();
  }

  // PREVIOUS
  Future<void> _previousSong() async {
    await _audioPlayer.stop();

    if (!mounted) return;

    setState(() {
      if (_currentSongIndex > 0) {
        _currentSongIndex--;
      } else {
        _currentSongIndex = _songs.length - 1;
      }

      _position = Duration.zero;
      _duration = Duration.zero;
      _isFavorite = false;
    });

    _rotationController.reset();

    await _playSong();
  }

  // CHỌN BÀI
  Future<void> _selectSong(int index) async {
    await _audioPlayer.stop();

    if (!mounted) return;

    setState(() {
      _currentSongIndex = index;
      _position = Duration.zero;
      _duration = Duration.zero;
      _isFavorite = false;
    });

    _rotationController.reset();

    await _playSong();
  }

  // FORMAT THỜI GIAN
  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      return n.toString().padLeft(2, '0');
    }

    final minutes = twoDigits(duration.inMinutes.remainder(60));

    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$minutes:$seconds';
  }

  // ALBUM COVER
  Widget _buildAlbumCover() {
    final gradient = _songGradients[_currentSongIndex];
    final icon = _songIcons[_currentSongIndex];

    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationController.value * 2 * 3.141592653589793,
          child: child,
        );
      },
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.45),
              blurRadius: 35,
              spreadRadius: 5,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Vòng ngoài
            Container(
              width: 225,
              height: 225,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 2,
                ),
              ),
            ),

            // Vòng giữa
            Container(
              width: 175,
              height: 175,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 2,
                ),
              ),
            ),

            // Icon
            Icon(icon, size: 90, color: Colors.white),

            // Tâm đĩa
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.95),
                border: Border.all(color: gradient.first, width: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // NÚT ĐIỀU KHIỂN
  Widget _controlButton({
    required IconData icon,
    required VoidCallback onPressed,
    double size = 54,
    double iconSize = 28,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.08),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize, color: Colors.white),
      ),
    );
  }

  // PLAY BUTTON
  Widget _buildPlayButton() {
    final gradient = _songGradients[_currentSongIndex];

    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient.last.withOpacity(0.5),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        onPressed: _togglePlayPause,
        icon: Icon(
          _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          size: 42,
          color: Colors.white,
        ),
      ),
    );
  }

  // PLAYLIST ITEM
  Widget _buildPlaylistItem(int index) {
    final bool isCurrent = index == _currentSongIndex;
    final gradient = _songGradients[index];

    return GestureDetector(
      onTap: () => _selectSong(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isCurrent
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    gradient.first.withOpacity(0.28),
                    gradient.last.withOpacity(0.12),
                  ],
                )
              : null,
          color: isCurrent ? null : Colors.white.withOpacity(0.05),
          border: Border.all(
            color: isCurrent
                ? gradient.first.withOpacity(0.45)
                : Colors.white.withOpacity(0.08),
          ),
        ),
        child: Row(
          children: [
            // SỐ THỨ TỰ
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [gradient.first, gradient.last],
                ),
              ),
              child: Center(
                child: isCurrent && _isPlaying
                    ? const Icon(Icons.equalizer_rounded, color: Colors.white)
                    : Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),

            const SizedBox(width: 14),

            // TÊN BÀI
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _songTitles[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _artists[index],
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.55),
                    ),
                  ),
                ],
              ),
            ),

            // ICON
            Icon(
              isCurrent
                  ? Icons.volume_up_rounded
                  : Icons.play_circle_outline_rounded,
              color: isCurrent ? gradient.last : Colors.white.withOpacity(0.6),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    final gradient = _songGradients[_currentSongIndex];

    final double maxPosition = _duration.inMilliseconds > 0
        ? _duration.inMilliseconds.toDouble()
        : 1;

    final double currentPosition = _position.inMilliseconds
        .clamp(0, _duration.inMilliseconds)
        .toDouble();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F1026), Color(0xFF18113A), Color(0xFF100B22)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TOP BAR

                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.08),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: const Icon(
                        Icons.music_note_rounded,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MY MUSIC',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Your personal music space',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                      icon: Icon(
                        _isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: _isFavorite ? Colors.pinkAccent : Colors.white70,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // NOW PLAYING
                Center(
                  child: Text(
                    'NOW PLAYING',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      color: gradient.last,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ALBUM COVER
                Center(child: _buildAlbumCover()),

                const SizedBox(height: 28),

                // TÊN BÀI
                Center(
                  child: Text(
                    _songTitles[_currentSongIndex],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Center(
                  child: Text(
                    _artists[_currentSongIndex],
                    style: const TextStyle(color: Colors.white54, fontSize: 15),
                  ),
                ),

                const SizedBox(height: 25),

                // GLASS MUSIC PANEL
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Colors.white.withOpacity(0.06),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.09),
                        ),
                      ),
                      child: Column(
                        children: [

                          // SLIDER
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: gradient.last,
                              inactiveTrackColor: Colors.white.withOpacity(
                                0.12,
                              ),
                              thumbColor: Colors.white,
                              overlayColor: gradient.last.withOpacity(0.15),
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 7,
                              ),
                            ),
                            child: Slider(
                              value: currentPosition,
                              min: 0,
                              max: maxPosition,
                              onChanged: (value) {
                                _audioPlayer.seek(
                                  Duration(milliseconds: value.toInt()),
                                );
                              },
                            ),
                          ),

                          // TIME
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(_position),
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  _formatDuration(_duration),
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          // CONTROL
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _controlButton(
                                icon: Icons.skip_previous_rounded,
                                onPressed: _previousSong,
                              ),

                              const SizedBox(width: 18),

                              _controlButton(
                                icon: Icons.stop_rounded,
                                onPressed: _stopSong,
                              ),

                              const SizedBox(width: 18),

                              _buildPlayButton(),

                              const SizedBox(width: 18),

                              _controlButton(
                                icon: Icons.skip_next_rounded,
                                onPressed: _nextSong,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // PLAYLIST HEADER
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Your Playlist',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.07),
                      ),
                      child: Text(
                        '${_songs.length} songs',
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // PLAYLIST
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _songs.length,
                  itemBuilder: (context, index) {
                    return _buildPlaylistItem(index);
                  },
                ),

                const SizedBox(height: 10),

                // FOOTER
                Center(
                  child: Text(
                    '♫  Enjoy your music  ♫',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.35),
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // DISPOSE
  @override
  void dispose() {
    _audioPlayer.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}
