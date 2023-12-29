import 'package:audio_player_app/components/side_bar_component.dart';
import 'package:audio_player_app/screens/songs_screens/all_songs_screen.dart';
import 'package:audio_player_app/screens/songs_screens/favaorite_songs_screen.dart';
import 'package:audio_player_app/screens/songs_screens/recent_songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../bloc/screen_index_bloc/index_bloc.dart';
import '../components/mini_player_component.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Widget>songsScreen=[const FavouriteSongsScreen(),const  RecentSongsScreen() ,const AllSongsScreen()];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestStoragePermission();
  //  requestPermission();

  }
  Future<void> requestStoragePermission() async {
    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        debugPrint('Storage permission granted');

      } else {

        debugPrint('Storage permission denied');
      }
    } catch (e) {
      debugPrint('Error requesting storage permission: $e');
      // Handle the error appropriately
    }
  }

  // requestPermission() async {
  //
  //   var status = await Permission.storage.status;
  //   if (status.isDenied) {
  //     // We haven't asked for permission yet or the permission has been denied before, but not permanently.
  //     Permission.storage.request();
  //   } else {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /////////// ***************** APP BAR  **************////////////////
      appBar: AppBar(

        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: const Text("Music Player"),
      ),
      /////////// ***************** MINI PLAYER **************////////////////
      bottomNavigationBar:const  MiniPLayer(),
        /////////// ***************** BODY **************////////////////
        body: Row(
        children: [
          /////////// ***************** SIDE BAR **************////////////////
         const  SideBarWidget(),
          /////////// ***************** SONG SCREEN **************////////////////
          Expanded(child: BlocBuilder<IndexCubit,int>(
            builder: (context,state){
              return songsScreen[state];
            },
          ))
        ],
      )
    );
  }
}

