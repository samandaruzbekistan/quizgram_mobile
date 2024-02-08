import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizAudioPlayer extends StatefulWidget {
  final String audioUrl;

  const QuizAudioPlayer({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _QuizAudioPlayerState createState() => _QuizAudioPlayerState();
}

class _QuizAudioPlayerState extends State<QuizAudioPlayer> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  String currentTime = "0:00:00";
  String completeTime = "0:00:00";

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    audioPlayer.onPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split(".")[0];
      });
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split(".")[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          width: 240,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(80),
          ),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  if (isPlaying) {
                    audioPlayer.pause();
                  } else {
                    audioPlayer.play(UrlSource(widget.audioUrl));
                    audioPlayer.resume();
                  }
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.stop,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {
                  audioPlayer.stop();
                  setState(() {
                    isPlaying = false;
                  });
                },
              ),
              Text(
                "   " + currentTime,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(" | "),
              Text(
                completeTime,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }
}
