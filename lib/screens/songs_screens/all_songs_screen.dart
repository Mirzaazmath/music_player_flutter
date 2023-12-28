import 'package:audio_player_app/bloc/player_bloc/player_bloc.dart';
import 'package:audio_player_app/components/empty_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';


import '../../components/loading_component.dart';
final List<SongModel> allSongs=[];
final audioQuery = OnAudioQuery();

class AllSongsScreen extends StatelessWidget {
  const AllSongsScreen({super.key,});

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
                    trailing:const  Icon(Icons.play_arrow),
                    onTap: () {
                      //// here we calling the ploySong function to play the song
                      context.read<PlayerBLoc>().playSong(allSongs, index);
                      },
                  );
                });
          }
        });
  }
}
