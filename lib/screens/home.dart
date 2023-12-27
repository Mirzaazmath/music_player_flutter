import 'package:audio_player_app/screens/songs_screens/all_songs_screen.dart';
import 'package:audio_player_app/screens/songs_screens/favaorite_songs_screen.dart';
import 'package:audio_player_app/screens/songs_screens/recent_songs.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();

  List<String>categories=["Favourite","Recent Added","All Songs",];
  List<Widget>songsScreen=[];
  int selectedScreen=2;
  bool isPLaying=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    songsScreen.addAll([const FavouriteSongsScreen(), RecentSongsScreen(audioPlayer: audioPlayer),AllSongsScreen(audioPlayer: audioPlayer)]);
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
        backgroundColor: Colors.transparent,
        title: const Text("Music Player"),
      ),
      bottomNavigationBar: isPLaying? Container(
        decoration:const  BoxDecoration(
         gradient: LinearGradient(
           colors: [
             Colors.black54,
             Colors.transparent
           ]
         )
        ),
        child: Container(
          height:80,
         decoration:const  BoxDecoration(
           color: Colors.black,
           borderRadius: BorderRadius.vertical(top: Radius.circular(25))
         ),
          padding:const  EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  shape: BoxShape.circle,
                  image:const  DecorationImage(
                      image: AssetImage("assets/circleBg.gif"),fit: BoxFit.cover
                  ),
                  boxShadow:const  [
                    BoxShadow(
                        color: Colors.blue,
                        offset: Offset(-3,-3),
                        blurRadius: 5
                    ),
                    BoxShadow(
                        color: Colors.purple,
                        offset: Offset(3,3),
                        blurRadius: 5
                    )
                  ],
                ),

              ),
             const  SizedBox(width: 20,),
              Expanded(child: ListTile(
                contentPadding: EdgeInsets.zero,

                title: Text(
                  "Tera Mera Hai Pyar Amarsgbis",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Text(
                  "world",
                  maxLines: 1,
                ),
                trailing:   Row(
                 mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          // if(widget.audioPlayer.hasPrevious){
                          //   widget.audioPlayer.seekToPrevious();
                          // }
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          size: 20,
                        )),
                    IconButton(
                        onPressed: () {
                          // setState(() {
                          //   if (isPlaying) {
                          //     widget.audioPlayer.pause();
                          //   } else {
                          //     widget.audioPlayer.play();
                          //   }
                          //   isPlaying = !isPlaying;
                          // });
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {
                          // if(widget.audioPlayer.hasNext){
                          //   widget.audioPlayer.seekToNext();
                          // }
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          size: 20,
                        ))
                  ],
                ),
                onTap: () {
                 // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayAllSongs(audioPlayer: widget.audioPlayer,songList: allSongs,currentIndex: index,)));

                },
              )
              )

            ],
          ),
        ),
      ):const SizedBox(),
        body: Row(
        children: [
      Container(
      padding:const EdgeInsets.symmetric(vertical: 50,horizontal: 0),
      height: double.infinity,
        width: 60,
        color: Colors.black54,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        const Expanded(child: SizedBox()),
          for(int i=0;i<categories.length;i++)...[
            GestureDetector(
              onTap: (){
                setState(() {
                  selectedScreen=i;
                });
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10,top: 60),
                child: RotatedBox(

                    quarterTurns: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(categories[i],style:const  TextStyle(fontWeight: FontWeight.bold),),
                        const   SizedBox(height: 8,),
                        Container(
                            width: 30,
                            height: 4,
                           decoration: BoxDecoration(
                               color: i==selectedScreen? const Color(0xffa3bab6):Colors.transparent,
                             borderRadius: BorderRadius.circular(3)
                           ),
                        )
                      ],
                    )),
              ),
            )],


        ],

      ),
    ),
          Expanded(child: songsScreen[selectedScreen])
        ],
      )
    );
  }
}
