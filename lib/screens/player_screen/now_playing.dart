import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/player_bloc/player_states.dart';
import '../../bloc/player_bloc/player_bloc.dart';
import '../../components/custom_heart_component.dart';
class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.grey,
        title:const  Text("Now Playing"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: "hero",
                  child: Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        shape: BoxShape.circle,
                        image:const  DecorationImage(
                            image: AssetImage("assets/circleBg.gif"),fit: BoxFit.cover
                        ),
                        boxShadow:const  [
                          BoxShadow(
                              color: Colors.blue,
                              offset: Offset(-5,-5),
                              blurRadius: 15
                          ),
                          BoxShadow(
                              color: Colors.purple,
                              offset: Offset(5,5),
                              blurRadius: 15
                          )
                        ],
                      ),

                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                BlocBuilder<PlayerBLoc,PlayerStates>(
                    builder: (context,state) {
                   if(state is PlayerStatesUpdatedState){
                     var position=  context.read<PlayerBLoc>().postion;
                     var duration=  context.read<PlayerBLoc>().duration;
                     var isShuffle=  context.read<PlayerBLoc>().isShuffle;
                     return  Column(
                       children: [


                         Center(
                           child: Text(
                             state.title,
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
                             state.artist,
                             textAlign: TextAlign.center,
                             style: const TextStyle(fontSize: 16, color: Colors.grey),
                             maxLines: 2,
                             overflow: TextOverflow.ellipsis,
                           ),
                         ),
                         const SizedBox(
                           height: 20,
                         ),
                         SizedBox(
                           height: 50,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                             isShuffle?  Shimmer.fromColors(
                                 baseColor: Colors.blueAccent,
                                 highlightColor: Colors.purple,
                                 child: IconButton(onPressed: (){
                                   context.read<PlayerBLoc>().shuffleSongs();
                                   }, icon: const  Icon(Icons.shuffle,color: Colors.grey,size: 30,)),
                               ):IconButton(onPressed: (){
                               context.read<PlayerBLoc>().shuffleSongs();
                             }, icon: const  Icon(Icons.shuffle,color: Colors.grey,size: 30,)),

                               FavouriteWidget( id: state.id,)
                             ],

                           ),
                         ),
                       const   SizedBox(height: 10,),
                         Row(
                           children: [
                             Text(position.toString().split(".")[0]),
                             Expanded(
                                 child: Slider(
                                   min: const Duration(seconds: 0).inSeconds.toDouble(),
                                   value: position.inSeconds.toDouble(),
                                   max: duration.inSeconds.toDouble(),
                                   onChanged: (val) {
                                     context.read<PlayerBLoc>().changeSlideValue(val.toInt());
                                       val = val;

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
                                 onPressed: () {
                                   context.read<PlayerBLoc>().moveToPreviousSong();
                                 },
                                 icon: const Icon(
                                   Icons.skip_previous,
                                   size: 50,
                                 )),
                             IconButton(
                                 onPressed: () {
                                   context.read<PlayerBLoc>().playAndPause();
                                 },
                                 icon: Icon(
                                   state.isPlaying ? Icons.pause : Icons.play_arrow,
                                   size: 70,
                                 )),
                             IconButton(
                                 onPressed: () {
                                   context.read<PlayerBLoc>().moveToNextSong();
                                 },
                                 icon: const Icon(
                                   Icons.skip_next,
                                   size: 50,
                                 ))
                           ],
                         )
                       ],
                     );
                   }
                   else{
                     return const SizedBox();
                   }

                  }
                )
              ])),
    );
  }
}
