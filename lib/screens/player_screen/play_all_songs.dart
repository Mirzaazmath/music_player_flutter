// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_background/just_audio_background.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// class PlayAllSongs extends StatefulWidget {
//   final List<SongModel> songList;
//   final AudioPlayer audioPlayer;
//    int currentIndex;
//    PlayAllSongs({super.key,required this.audioPlayer,required this.songList,required this.currentIndex});
//
//   @override
//   State<PlayAllSongs> createState() => _PlayAllSongsState();
// }
//
// class _PlayAllSongsState extends State<PlayAllSongs> {
//   bool isPlaying = false;
//   Duration duration = const Duration();
//   Duration postion = const Duration();
//   List<AudioSource>allSongs=[];
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       playSong();
//     });
//   }
//
//   playSong() {
//     try {
//       for(var element in widget.songList){
//         allSongs.add( AudioSource.uri(Uri.parse(element.uri!),
//             tag: MediaItem(
//               // Specify a unique ID for each media item:
//               id: "${element.id}",
//               // Metadata to display in the notification:
//               album: "${element.album}",
//               title: element.displayNameWOExt,
//               artUri: Uri.parse(element.id.toString()),
//             )),);
//
//       }
//       widget.audioPlayer.setAudioSource(
//        ConcatenatingAudioSource(children: allSongs,),initialIndex: widget.currentIndex
//       );
//       widget.audioPlayer.play();
//       isPlaying = true;
//     } on Exception {
//       // need to add something to show when the song is currpted
//       debugPrint("Cannot Play song");
//     }
//     widget.audioPlayer.durationStream.listen((d) {
//       if(mounted){
//         setState(() {
//           duration = d!;
//         });
//       }
//
//
//     });
//     widget.audioPlayer.positionStream.listen((p) {
//       if(mounted){
//         setState(() {
//           postion = p;
//         });
//       }
//
//     });
//     widget.audioPlayer.currentIndexStream.listen((index) {
//       if(mounted){
//         setState(() {
//           if(index!=null){
//             widget.currentIndex=index;
//           }
//         });
//       }
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Colors.grey,
//       ),
//       body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                  Center(
//                  child: Container(
//                    height: 200,
//                    width: 200,
//                    decoration: BoxDecoration(
//                      border: Border.all(color: Colors.black),
//                      shape: BoxShape.circle,
//                      image:const  DecorationImage(
//                        image: AssetImage("assets/circleBg.gif"),fit: BoxFit.cover
//                      ),
//                      boxShadow:const  [
//                        BoxShadow(
//                          color: Colors.blue,
//                          offset: Offset(-5,-5),
//                          blurRadius: 15
//                        ),
//                        BoxShadow(
//                       color: Colors.purple,
//                        offset: Offset(5,5),
//                      blurRadius: 15
//                  )
//                      ],
//                    ),
//
//                  ),
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 Center(
//                   child: Text(
//                     widget.songList[widget.currentIndex].displayNameWOExt,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 22,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Center(
//                   child: Text(
//                     widget.songList[widget.currentIndex].artist ?? "",
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 16, color: Colors.grey),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     Text(postion.toString().split(".")[0]),
//                     Expanded(
//                         child: Slider(
//                           min: const Duration(seconds: 0).inSeconds.toDouble(),
//                           value: postion.inSeconds.toDouble(),
//                           max: duration.inSeconds.toDouble(),
//                           onChanged: (val) {
//                             setState(() {
//                               changeSlideValue(val.toInt());
//                               val = val;
//                             });
//                           },
//                         )),
//                     Text(duration.toString().split(".")[0])
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           if(widget.audioPlayer.hasPrevious){
//                             widget.audioPlayer.seekToPrevious();
//                           }
//                         },
//                         icon: const Icon(
//                           Icons.skip_previous,
//                           size: 50,
//                         )),
//                     IconButton(
//                         onPressed: () {
//                           setState(() {
//                             if (isPlaying) {
//                               widget.audioPlayer.pause();
//                             } else {
//                               widget.audioPlayer.play();
//                             }
//                             isPlaying = !isPlaying;
//                           });
//                         },
//                         icon: Icon(
//                           isPlaying ? Icons.pause : Icons.play_arrow,
//                           size: 70,
//                         )),
//                     IconButton(
//                         onPressed: () {
//                           if(widget.audioPlayer.hasNext){
//                             widget.audioPlayer.seekToNext();
//                           }
//                         },
//                         icon: const Icon(
//                           Icons.skip_next,
//                           size: 50,
//                         ))
//                   ],
//                 )
//               ])),
//     );
//   }
//   changeSlideValue(int seconds) {
//     Duration duration = Duration(seconds: seconds);
//     widget.audioPlayer.seek(duration);
//   }
// }
