import 'package:audio_player_app/screens/now_playing.dart';
import 'package:audio_player_app/screens/play_all_songs.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<SongModel> allSongs=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      Permission.storage.request();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Player"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
        //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayAllSongs(audioPlayer: audioPlayer,songList: allSongs,)));
        },),
      body: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Songs Found"),
              );
            } else {
              allSongs.addAll(snapshot.data!);
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    SongModel song = snapshot.data![index];
                    debugPrint(song.id.toString());
                    return ListTile(
                      leading: QueryArtworkWidget(
                        id: song.id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(Icons.music_note),
                      ),
                      title: Text(
                        song.displayNameWOExt,
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        song.artist ?? "",
                        maxLines: 1,
                      ),
                      trailing: const Icon(Icons.play_arrow),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayAllSongs(audioPlayer: audioPlayer,songList: allSongs,currentIndex: index,)));
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         NowPlayingScreen(
                        //           song: song,
                        //           audioPlayer: audioPlayer,
                        //         ))
                        // );
                      },
                    );
                  });
            }
          }),
    );
  }
}
