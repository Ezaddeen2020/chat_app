import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, required this.path});
  final String path;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.crop_rotate, size: 27)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.emoji_emotions_outlined, size: 27)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.title, size: 27)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit, size: 27)),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: TextFormField(
                  maxLines: 7,
                  minLines: 1,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Add Caption....",
                    prefix: Icon(Icons.add_photo_alternate, color: Colors.red),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    suffix: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.check),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying ? _controller.pause() : _controller.play();
                  });
                },
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.black,
                    size: 80,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
