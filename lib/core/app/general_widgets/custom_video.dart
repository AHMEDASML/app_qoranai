import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

void showHajjVideoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const Dialog(
      insetPadding: EdgeInsets.all(16),
      child: VideoPlayerPopup(),
    ),
  );
}

class VideoPlayerPopup extends StatefulWidget {
  const VideoPlayerPopup({super.key});

  @override
  State<VideoPlayerPopup> createState() => _VideoPlayerPopupState();
}

class _VideoPlayerPopupState extends State<VideoPlayerPopup> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isDisposed = false;
  Duration _videoDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://api.alarqambh.com/videos/haj1.mp4'),
      
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _videoDuration = _controller.value.duration;
            _isPlaying = true;
          });
          _controller.play();
        }

        _controller.addListener(() {
          if (!_isDisposed && mounted) {
            setState(() {
              _currentPosition = _controller.value.position;
              _isPlaying = _controller.value.isPlaying;
            });
          }
        });
      });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      if (_currentPosition >= _videoDuration) {
        _controller.seekTo(Duration.zero);
      }
      _controller.play();
    }
  }

  void _seekForward() {
    final newPos = _currentPosition + const Duration(seconds: 10);
    if (newPos <= _videoDuration) {
      _controller.seekTo(newPos);
    }
  }

  void _seekBackward() {
    final newPos = _currentPosition - const Duration(seconds: 10);
    _controller.seekTo(newPos >= Duration.zero ? newPos : Duration.zero);
  }

  void _replay() {
    _controller.seekTo(Duration.zero);
    _controller.play();
  }

  void _stop() {
    _controller.pause();
    _controller.seekTo(Duration.zero);
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}';
  }

  @override
  Widget build(BuildContext context) {
    final isInitialized = _controller.value.isInitialized;
    final currentMillis = _currentPosition.inMilliseconds.toDouble();
    final totalMillis = _videoDuration.inMilliseconds.toDouble();

    return isInitialized
        ? Padding(
            padding:  EdgeInsets.all(4.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                      const SizedBox(height: 10),
                      Slider(
                        min: 0,
                        max: totalMillis > 0 ? totalMillis : 1,
                        value: currentMillis.clamp(0, totalMillis).toDouble(),
                        onChanged: (value) {
                          _controller.seekTo(Duration(milliseconds: value.toInt()));
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(_currentPosition)),
                          Text(_formatDuration(_videoDuration)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.replay_10),
                            onPressed: _seekBackward,
                          ),
                          IconButton(
                            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                            onPressed: _togglePlayPause,
                          ),
                          IconButton(
                            icon: const Icon(Icons.stop),
                            onPressed: _stop,
                          ),
                          IconButton(
                            icon: const Icon(Icons.forward_10),
                            onPressed: _seekForward,
                          ),
                          IconButton(
                            icon: const Icon(Icons.replay),
                            onPressed: _replay,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
             
              ],
            ),
          )
        :  Container(
          height:300.h,
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
  }
}
