import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quizgram/utils/constant.dart';

class QuizAudioPlayer extends StatefulWidget {
  final String audioUrl;

  const QuizAudioPlayer({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _QuizAudioPlayerState createState() => _QuizAudioPlayerState();
}

class _QuizAudioPlayerState extends State<QuizAudioPlayer> {
  late AudioPlayer audioPlayer;
  bool _isPlay = false;
  String currentTime = "0:00:00";
  String completeTime = "0:00:00";
  Duration maxDuration = const Duration(seconds: 0);
  late ValueListenable<Duration> progress;

  @override
  void initState() {
    audioPlayer = AudioPlayer(playerId: widget.audioUrl);
    // audioPlayer.play(UrlSource(widget.audioUrl));
    setState(() {});
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        getMaxDuration(); // Call getMaxDuration when the audio starts playing
      }
    });
  }

  Future<void> getMaxDuration() async {
    Duration? value = await audioPlayer.getDuration();
    if (value != null) {
      setState(() {
        maxDuration = value;
      });
    }
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.8,
          child: StreamBuilder(
            stream: audioPlayer.onPositionChanged,
            builder: (context, snapshot) {
              return ProgressBar(
                progress: snapshot.data ?? Duration.zero,
                total: maxDuration,
                onSeek: (duration) {
                  audioPlayer.seek(duration);
                },
              );
            },
          ),
        ),
        Container(
          width: 240,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(80),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.fast_rewind,
                  color: ColorsHelpers.primaryColor,
                  size: 25,
                ),
                onPressed: () {
                  audioPlayer.stop();
                  getMaxDuration();
                },
              ),
              IconButton(
                icon: Icon(
                  audioPlayer.state == PlayerState.playing ? Icons.pause_circle_filled : _isPlay ? Icons.downloading : Icons.play_circle_filled,
                  color: ColorsHelpers.primaryColor,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    _isPlay = !_isPlay;
                  });
                  audioPlayer.state == PlayerState.playing
                      ? audioPlayer.pause()
                      : audioPlayer.play(UrlSource(widget.audioUrl));
                  getMaxDuration();
                  setState(() {});
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.fast_forward,
                  color: ColorsHelpers.primaryColor,
                  size: 25,
                ),
                onPressed: () {
                  audioPlayer.stop();
                  audioPlayer.play(UrlSource(widget.audioUrl));
                  getMaxDuration();

                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // @override
  // void dispose() {
  //   audioPlayer.stop();
  //   audioPlayer.dispose();
  //   super.dispose();
  // }
}
