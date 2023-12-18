import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingScreen extends StatefulWidget {
  final SongModel song;
  final AudioPlayer audioPlayer;
  NowPlayingScreen({Key? key, required this.song, required this.audioPlayer})
      : super(key: key);

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlayingScreen> {
  bool isPlaying = false;
  Duration duration = const Duration();
  Duration postion = const Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      playSong();
    });
  }

  playSong() {
    try {
      widget.audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(widget.song.uri!),
            tag: MediaItem(
              // Specify a unique ID for each media item:
              id: "${widget.song.id}",
              // Metadata to display in the notification:
              album: "${widget.song.album}",
              title: widget.song.displayNameWOExt,
              artUri: Uri.parse('https://example.com/albumart.jpg'),
            )),
      );
      widget.audioPlayer.play();
      isPlaying = true;
    } on Exception {
      // need to add something to show when the song is currpted
      debugPrint("Cannot Play song");
    }
    widget.audioPlayer.durationStream.listen((d) {
      setState(() {
        duration = d!;
      });
    });
    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        postion = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 100,
                    child: Icon(
                      Icons.music_note,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    widget.song.displayNameWOExt,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    widget.song.artist ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(postion.toString().split(".")[0]),
                    Expanded(
                        child: Slider(
                      min: const Duration(seconds: 0).inSeconds.toDouble(),
                      value: postion.inSeconds.toDouble(),
                      max: duration.inSeconds.toDouble(),
                      onChanged: (val) {
                        setState(() {
                          changeSlideValue(val.toInt());
                          val = val;
                        });
                      },
                    )),
                    Text(duration.toString().split(".")[0])
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_previous,
                          size: 50,
                        )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (isPlaying) {
                              widget.audioPlayer.pause();
                            } else {
                              widget.audioPlayer.play();
                            }
                            isPlaying = !isPlaying;
                          });
                        },
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 70,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_next,
                          size: 50,
                        ))
                  ],
                )
              ])),
    );
  }

  changeSlideValue(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}
