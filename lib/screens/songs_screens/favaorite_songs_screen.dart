import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/player_bloc/player_bloc.dart';
import '../../components/empty_component.dart';
import '../../components/loading_component.dart';
import 'all_songs_screen.dart';
class FavouriteSongsScreen extends StatefulWidget {
  const FavouriteSongsScreen({super.key});

  @override
  State<FavouriteSongsScreen> createState() => _FavouriteSongsScreenState();
}

class _FavouriteSongsScreenState extends State<FavouriteSongsScreen> {
  final List<SongModel> allSongs=[];
  final List<SongModel> allSongsInOrder=[];
  List<String>?favouriteIds=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkMyFavourite();
    });
  }

  checkMyFavourite()async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favouriteIds = prefs.getStringList('myFavourite')??[];
      favouriteIds= favouriteIds!.reversed.toList();
    });
  }

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
            } else{
              for(int i=0;i<snapshot.data!.length;i++){
                if( favouriteIds!.contains(snapshot.data![i].id.toString())){
                  allSongs.add(snapshot.data![i]);
                }
              }

              for(int i=0;i<favouriteIds!.length;i++){
                allSongsInOrder.add(allSongs.firstWhere((element) => element.id.toString()==favouriteIds![i]));
              }

              return allSongsInOrder.isEmpty?const Center(child: EmptyScreenWidget()): ListView.builder(
                  itemCount: allSongsInOrder.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    SongModel song = allSongsInOrder[index];
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
                        context.read<PlayerBLoc>().playSong(allSongsInOrder, index);
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayAllSongs(audioPlayer: widget.audioPlayer,songList: allSongs,currentIndex: index,)));

                      },
                    );
                  });
            }
          }),
    );
  }
}
