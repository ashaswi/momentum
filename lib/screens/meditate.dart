import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:momentum/api/service/notification/notification_service.dart';


class Meditate extends StatefulWidget {
  const Meditate({super.key});

  @override
  _MeditateState createState() => _MeditateState();
}

class _MeditateState extends State<Meditate> {
  late VideoPlayerController _videoController;
  bool _isPlaying = true;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _notificationShown = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  void _initVideoPlayer() {
  _videoController = VideoPlayerController.asset('assets/images/breathe.mp4')
    ..initialize().then((_) {
      setState(() {});
      _videoController.play();
      // _videoController.setLooping(true); // remove this to allow detection of end
      _videoController.addListener(() {
        final position = _videoController.value.position;
        final duration = _videoController.value.duration;

        setState(() {
          _position = position;
          _duration = duration;
        });

        if (!_notificationShown &&
            duration.inSeconds > 0 &&
            position >= duration) {
          _notificationShown = true;
          showNotification("Your session is complete. Breathe in the peace.",""); // Call your notification method here
        }
      });
    });
}

  String _formatDuration(Duration duration) {
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF371B34)), 
          onPressed: () {
            Navigator.pushNamed(context, '/dashboard'); 
          },
        ),
        title: const Text(
          'Meditation',
          style: TextStyle(
            color: Color(0xFF371B34), 
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/icons/background_elements.svg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Video
                _videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      )
                    : const CircularProgressIndicator(),
                // Teal circle with "Inhale" text
              ],
            ),
          ),
          // Progress bar and controls
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // Progress bar with times
                Row(
                  children: [
                    Text(_formatDuration(_position)),
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 4,
                          activeTrackColor: Colors.purple,
                          inactiveTrackColor: Colors.grey.shade300,
                          thumbColor: Colors.purple,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                        ),
                        child: Slider(
                          value: _position.inSeconds.toDouble(),
                          max: _duration.inSeconds.toDouble(),
                          onChanged: (value) {
                            final newPosition = Duration(seconds: value.toInt());
                            _videoController.seekTo(newPosition);
                          },
                        ),
                      ),
                    ),
                    Text(_formatDuration(_duration)),
                  ],
                ),
                SizedBox(height: 20),
                // Play/Pause controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Play button
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E1FA),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.play_arrow, color: Colors.purple),
                        onPressed: () {
                          if (!_isPlaying) {
                            setState(() {
                              _videoController.play();
                              _isPlaying = true;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    // Pause button
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E1FA),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.pause, color: Colors.purple),
                        onPressed: () {
                          if (_isPlaying) {
                            setState(() {
                              _videoController.pause();
                              _isPlaying = false;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
