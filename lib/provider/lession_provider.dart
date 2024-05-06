import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:yogaapp/constents/app_size.dart';
import 'package:yogaapp/model/lession_model.dart';

class LessonProvider extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController customVideoPlayerController;
  bool isloading = true;
  bool isPlay = false;
  Lesson? _selectedLesson;
  Lesson? get selectedLesson => _selectedLesson;

  Future<void> selectLession(Lesson les) async {
    _selectedLesson = les;
    notifyListeners();
  }

  void tonglePlayButton() {
    isPlay ? videoPlayerController.pause() : videoPlayerController.play();
    isPlay = !isPlay;
    notifyListeners();
  }

  Future<bool> willPop() async {
    // videoPlayerController.dispose();
    // customVideoPlayerController.dispose();

    // notifyListeners();
    return true;
  }

  void lessionDispose(BuildContext context) {
    Navigator.pop(context);
    videoPlayerController.dispose();
    customVideoPlayerController.dispose();

    notifyListeners();
  }

  void inistialiseVideoPlayer(BuildContext context) {
    try {
      videoPlayerController =
          VideoPlayerController.asset('assets/images/lesson_test3.mp4')
            ..initialize().then((value) {
              isloading = false;
              notifyListeners();
            });

      customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: videoPlayerController,
        customVideoPlayerSettings: CustomVideoPlayerSettings(
            customAspectRatio: 375 / 597,
            thumbnailWidget: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/lession1.png'),
                      fit: BoxFit.cover)),
            )

            //  Image.asset('assets/images/lession1.png')

            ),
      );
    } catch (e) {
      throw Exception(e);
    } finally {
      isloading = false;
      notifyListeners();
    }

    notifyListeners();
  }

  LessonProvider(BuildContext context) {
    inistialiseVideoPlayer(context);
  }
}
