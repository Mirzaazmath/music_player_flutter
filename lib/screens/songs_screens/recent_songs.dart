import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/player_bloc/player_bloc.dart';
import '../../components/empty_component.dart';
import '../../components/loading_component.dart';
import 'all_songs_screen.dart';


final List<SongModel> allSongs=[];

class RecentSongsScreen extends StatelessWidget {

  const RecentSongsScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
              sortType: SongSortType.DATE_ADDED,
              orderType: OrderType.DESC_OR_GREATER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const  LoadingWidget();
            } else if (snapshot.data!.isEmpty) {
              return const  EmptyScreenWidget();
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
                        context.read<PlayerBLoc>().playSong(allSongs, index);
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayAllSongs(audioPlayer: widget.audioPlayer,songList: allSongs,currentIndex: index,)));

                      },
                    );
                  });
            }
          }),
    );
  }
}
