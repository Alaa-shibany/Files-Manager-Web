import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({
    super.key,
    required this.videoPath,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      final file = File(widget.videoPath);
      if (await file.exists()) {
        _controller = VideoPlayerController.file(file)
          ..initialize().then((_) {
            setState(() {
              _isInitialized = true;
            });
          });
      } else {
        setState(() {
          _isError = true;
        });
      }
    } catch (e) {
      setState(() {
        _isError = true;
      });
      print('Error initializing video: $e');
    }
  }

  void _playPause() {
    if (_isInitialized) {
      setState(() {
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
      });
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return const Center(child: Text('فشل تحميل الفيديو.'));
    }

    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: _playPause,
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(_controller),
            if (!_controller.value.isPlaying)
              const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 50,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
