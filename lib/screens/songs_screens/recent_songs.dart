import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../play_all_songs.dart';

class RecentSongsScreen extends StatefulWidget {
  final AudioPlayer audioPlayer;
  const RecentSongsScreen({Key? key,required this.audioPlayer}) : super(key: key);

  @override
  State<RecentSongsScreen> createState() => _RecentSongsScreenState();
}

class _RecentSongsScreenState extends State<RecentSongsScreen> {
  final audioQuery = OnAudioQuery();

  final List<SongModel> allSongs=[];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayAllSongs(audioPlayer: audioPlayer,songList: allSongs,)));
        },),
      body: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
              sortType: SongSortType.DATE_ADDED,
              orderType: OrderType.DESC_OR_GREATER,
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayAllSongs(audioPlayer: widget.audioPlayer,songList: allSongs,currentIndex: index,)));

                      },
                    );
                  });
            }
          }),
    );
  }
}
