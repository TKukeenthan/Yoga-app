import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yogaapp/constents/app_colors.dart';
import 'package:yogaapp/constents/app_size.dart';
import 'package:yogaapp/model/lession_model.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:yogaapp/provider/lession_provider.dart';

class LessionVideoPlayer extends StatefulWidget {
  final Lesson lesson;
  const LessionVideoPlayer({super.key, required this.lesson});

  @override
  State<LessionVideoPlayer> createState() => _LessionVideoPlayerState();
}

class _LessionVideoPlayerState extends State<LessionVideoPlayer> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    final provider = Provider.of<LessonProvider>(context, listen: false);
    provider.customVideoPlayerController.dispose();
    provider.videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LessonProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: () {
          return provider.willPop();
        },
        child: Scaffold(
          body: provider.isloading
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Container(
                    height: screenHeight(812, context),
                    child: Stack(
                      children: [
                        _buildVideoPlayer(context, provider),
                        _appBar(context, provider),
                        _buildWaveTimerAndPlayButtonNextButton(
                            context, provider)
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }

  Widget _buildWaveTimerAndPlayButtonNextButton(
      BuildContext context, LessonProvider provider) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: screenWidth(375, context),
        height: screenHeight(300, context),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Timer widget
              h16,
              Row(
                children: [
                  Text('00.00 '),
                  SvgPicture.asset('assets/svg/Equalizador.svg'),
                  Text(
                      '${provider.videoPlayerController.value.duration.toString().split('.').first}')
                ],
              ),

              // Play and Next buttons
              h24,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {},
                  ),
                  CircleAvatar(
                    radius: 29,
                    backgroundColor: basePurple,
                    child: IconButton(
                      icon: Icon(
                        provider.isPlay ? Icons.pause : Icons.play_arrow,
                        color: baseWhite,
                      ),
                      onPressed: () {
                        provider.tonglePlayButton();
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _appBar(BuildContext context, LessonProvider provider) {
    return Positioned(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: baseWhite,
              radius: 24,
              child: Icon(Icons.close),
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildVideoPlayer(BuildContext context, LessonProvider provider) {
    return Positioned(
      child: Stack(
        children: [
          Container(
            width: screenWidth(375, context),
            height: screenHeight(597, context),
            child: CustomVideoPlayer(
                customVideoPlayerController:
                    provider.customVideoPlayerController),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: screenWidth(375, context),
                height: screenHeight(300, context),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      const Color.fromARGB(0, 0, 0, 0),
                      Colors.black
                    ])),
              )),
          Positioned(
            bottom: screenHeight(130, context),
            left: 24,
            child: SizedBox(
              width: screenWidth(327, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h16,
                  Text(
                    widget.lesson.title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: baseWhite),
                  ),
                  Text(
                    widget.lesson.description,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: baseWhite),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
