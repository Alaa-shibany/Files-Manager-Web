import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoPath;

  const FullScreenVideoPlayer({super.key, required this.videoPath});

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    print('Video Link to play is : ${widget.videoPath}');
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      if (widget.videoPath.startsWith('http') ||
          widget.videoPath.startsWith('https')) {
        _controller = VideoPlayerController.network(widget.videoPath)
          ..initialize().then((_) {
            setState(() {
              _isInitialized = true;
            });
            _controller.play();
          });
      } else {
        final file = File(widget.videoPath);
        if (await file.exists()) {
          _controller = VideoPlayerController.file(file)
            ..initialize().then((_) {
              setState(() {
                _isInitialized = true;
              });
              _controller.play();
            });
        } else {
          setState(() {
            _isError = true;
          });
        }
      }
    } catch (e) {
      setState(() {
        _isError = true;
      });
      print('Error initializing video: $e');
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
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('فشل تحميل الفيديو.')),
      );
    }

    if (!_isInitialized) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
