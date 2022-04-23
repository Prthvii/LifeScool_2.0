import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';


import 'package:video_player/video_player.dart';



class PlayVideo extends StatefulWidget {
  final String url;

  PlayVideo({Key key, @required this.url}) : super(key: key);

  @override
  _ChewieDemoState createState() => _ChewieDemoState(url);


}

class _ChewieDemoState extends State<PlayVideo> {
  String url;
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;


  _ChewieDemoState(this.url);

  @override
  void initState() {
    super.initState();
    this.initializePlayer();

  }



  @override
  void dispose() {
    _videoPlayerController1.dispose();

    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
        url);
    await _videoPlayerController1.initialize();


    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
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
    // _chewieController.enterFullScreen();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


       backgroundColor: Colors.black87,
      body:  Center(
        child: _chewieController != null &&
            _chewieController
                .videoPlayerController.value.initialized
            ? Chewie(
          controller:  ChewieController(
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
            Container(
                child: Center(
                    child: Image.asset(
                      "assets/images/loading.gif",
                      height: 40,
                    ))),
            SizedBox(height: 20),
            Text('Loading'),
          ],
        ),
      ),
    );
  }
  Future<bool> _onBackPressed()  {

    Navigator.of(context).pop();

  }

}



// class FullPhotoScreen extends StatefulWidget {
//   final String url;
//
//   FullPhotoScreen({Key key, @required this.url}) : super(key: key);
//
//   @override
//   State createState() => FullPhotoScreenState(url: url);
// }
//
// class FullPhotoScreenState extends State<FullPhotoScreen> {
//   final String url;
//
//   FullPhotoScreenState({Key key, @required this.url});
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: PhotoView(imageProvider: CachedNetworkImageProvider(url)));
//   }
// }
