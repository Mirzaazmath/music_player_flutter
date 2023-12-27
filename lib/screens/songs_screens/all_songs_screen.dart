import 'package:audio_player_app/screens/play_all_songs.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
class AllSongsScreen extends StatefulWidget {
  final AudioPlayer audioPlayer;
  const AllSongsScreen({super.key,required this.audioPlayer});

  @override
  State<AllSongsScreen> createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {
  final List<SongModel> allSongs=[];
  final audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
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
                    trailing:const  Icon(Icons.play_arrow),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayAllSongs(audioPlayer: widget.audioPlayer,songList: allSongs,currentIndex: index,)));

                    },
                  );
                });
          }
        });
  }
}
