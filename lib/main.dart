import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  MusicApp();

  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  bool isPlaying = false;
  Icon iconPlay = Icon(Icons.play_arrow);

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };

    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.blue[800],
        inactiveColor: Colors.blue[350],
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        });
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue[800], Colors.blue[200]],
      )),
      child: Padding(
          padding: EdgeInsets.only(
            top: 48.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  'Music Beats',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  'Listen to your favourite Music',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                        image: AssetImage('assets/shibayan.jpg')),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  'Toho Bosa Nov2.mp3',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${position.inMinutes}:${position.inSeconds.remainder(60)}',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              slider(),
                              Text(
                                '${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(Icons.skip_previous),
                            iconSize: 45.0,
                            color: Colors.blue,
                            onPressed: () {}),
                        IconButton(
                            icon: iconPlay,
                            iconSize: 45.0,
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                iconPlay = isPlaying
                                    ? Icon(Icons.play_arrow)
                                    : Icon(Icons.pause);
                                isPlaying = !isPlaying;
                                if (isPlaying) {
                                  cache.play('Toho Bosa Nov2.mp3');
                                } else {
                                  _player.pause();
                                }
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.skip_next),
                            iconSize: 45.0,
                            color: Colors.blue,
                            onPressed: () {})
                      ],
                    )
                  ],
                ),
              ))
            ],
          )),
    ));
  }
}
