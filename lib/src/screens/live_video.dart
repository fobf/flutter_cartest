// ignore_for_file: sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cartest/const.dart';

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late VideoPlayerController _controller1;
  late Future<void> _initializeVideoPlayerFuture;
  late Future<void> _initializeVideoPlayerFuture1;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      kvideoUrl1,
    );
    _controller1 = VideoPlayerController.network(
      kvideoUrl2,
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    _initializeVideoPlayerFuture1 = _controller1.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    _controller.setVolume(0);
    _controller.play();

    _controller1.setLooping(true);
    _controller1.setVolume(0);
    _controller1.play();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    _controller1.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kspacer100,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Stack(
                alignment: kstackAlignmentBottomCenter,
                children: [
                  Container(
                    height: kwindow550,
                    width: kwindow500,
                    color: ksecondaryColor,
                  ),
                  Container(
                    height: kwindow500,
                    width: kwindow500,
                    child: MyVideo(url: kvideoUrl1),
                  ),
                  const Positioned(
                    top: 10,
                    right: 60,
                    child: Icon(
                      Icons.mic,
                      color: kiconColor,
                      size: kiconSize,
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 20,
                    child: Icon(
                      Icons.zoom_out_map,
                      color: kiconColor,
                      size: kiconSize,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      alignment: kwindowTextAlignment,
                      child: const Text(
                        kfirstWindowText,
                        style: kwindowTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: kstackAlignmentBottomCenter,
                children: [
                  Container(
                    height: kwindow550,
                    width: kwindow500,
                    color: ksecondaryColor,
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: kwindow500,
                    width: kwindow500,
                    child: MyVideo(url: kvideoUrl2),
                  ),
                  const Positioned(
                    top: 10,
                    right: 60,
                    child: Icon(
                      Icons.mic_off,
                      color: kiconColor,
                      size: kiconSize,
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 20,
                    child: Icon(
                      Icons.zoom_out_map,
                      color: kiconColor,
                      size: kiconSize,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      alignment: kwindowTextAlignment,
                      child: const Text(
                        ksecondWindowText,
                        style: kwindowTextStyle,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }
}

class MyVideo extends StatefulWidget {
  late String url = "";
  MyVideo({Key? key, required this.url}) : super(key: key);

  @override
  __MyVideoState createState() => __MyVideoState();
}

class __MyVideoState extends State<MyVideo> {
  late VideoPlayerController _controller;

  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.

    _controller = VideoPlayerController.network(widget.url,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    _controller.setVolume(0);
    _controller.play();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
              ),
              InkWell(
                onTap: () {
                  _controller.play();
                },
              )
            ],
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
