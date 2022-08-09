import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:orange_valley_caa/utils/constants.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  const VideoPlayerScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller!.initialize();
    _chewieController = ChewieController(videoPlayerController: _controller!);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        color: backgroundColor,
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: Chewie(controller: _chewieController!),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
