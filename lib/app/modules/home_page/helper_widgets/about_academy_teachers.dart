import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:step/app/widgets/status_widgets.dart';
import 'package:video_player/video_player.dart';

class AboutAcademyTeachers extends StatefulWidget {
  const AboutAcademyTeachers({super.key, required this.url});

  final String url;
  @override
  State<AboutAcademyTeachers> createState() => _AboutAcademyTeachersState();
}

class _AboutAcademyTeachersState extends State<AboutAcademyTeachers> {
  @override
  void initState() {
    super.initState();
    initVideo();
  }

  ChewieController? chewieController;
  late final VideoPlayerController videoPlayerController;

  initVideo() async {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));

    await videoPlayerController
        .initialize()
        .catchError((e) {})
        .onError((error, stackTrace) {});
    setState(() {
      chewieController =
          ChewieController(videoPlayerController: videoPlayerController);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    videoPlayerController.dispose();
    chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chewieController != null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Chewie(
          controller: chewieController!,
        ),
      );
    } else {
      return BussyWidget();
    }
  }
}
