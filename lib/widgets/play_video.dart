import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  final String url;

  PlayVideo({this.url});

  @override
  _ChewieDemoState createState() => _ChewieDemoState();
}

class _ChewieDemoState extends State<PlayVideo> {
  String url;
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;

  ChewieController _chewieController;
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    this.initializePlayer();
    print("vedioo");
    print(widget.url);
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();

    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.url);
    await _videoPlayerController1.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: true,

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    print("vedioo");
    print(widget.url);

    // _chewieController.enterFullScreen();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("vedioo");
    print(widget.url);
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: _chewieController != null &&
                      _chewieController.videoPlayerController.value.initialized
                  ? Chewie(
                      controller: ChewieController(
                        videoPlayerController: _videoPlayerController1,
                        autoPlay: true,
                        //  looping: true,
                        //  fullScreenByDefault: true,

                        // Try playing around with some of these other options:

                        // showControls: false,
                        // materialProgressColors: ChewieProgressColors(
                        //   playedColor: Colors.red,
                        //   handleColor: Colors.blue,
                        // backgroundColor: Colors.grey,
                        //   bufferedColor: Colors.lightGreen,
                        // ),
                        // placeholder: Container(
                        //   color: Colors.grey,
                        // ),
                        // autoInitialize: true,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    ),
            ),
    );
  }
}
