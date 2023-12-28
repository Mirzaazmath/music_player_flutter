import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/player_bloc/player_bloc.dart';
import '../bloc/player_bloc/player_states.dart';
import 'custom_route_transistion.dart';
class MiniPLayer extends StatelessWidget {
  const MiniPLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBLoc,PlayerStates>(
        builder: (context,state) {
          if(state is PlayerStatesUpdatedState){
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(createRoute());
              },
              child: Container(
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
                      Hero(
                        tag: "hero",
                        child: Container(
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
                      ),
                      const  SizedBox(width: 20,),
                      Expanded(child: ListTile(
                        contentPadding: EdgeInsets.zero,

                        title:  IgnorePointer(
                          child: Text(state.title,

                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        subtitle: IgnorePointer(
                          child:  Text(
                            state.artist,
                            maxLines: 1,
                          ),
                        ),
                        trailing:   Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<PlayerBLoc>().moveToPreviousSong();
                                },
                                icon: const  Icon(
                                  Icons.skip_previous,
                                  size: 20,
                                )),
                            IconButton(
                                onPressed: () {
                                  context.read<PlayerBLoc>().playAndPause();
                                },
                                icon: Icon(state.isPlaying?Icons.pause: Icons.play_arrow,
                                  size: 30,
                                )),
                            IconButton(
                                onPressed: () {
                                  context.read<PlayerBLoc>().moveToNextSong();
                                },
                                icon: const Icon(
                                  Icons.skip_next,
                                  size: 20,
                                ))
                          ],
                        ),

                      )
                      )

                    ],
                  ),
                ),
              ),
            );
          }else{
            return const SizedBox();}
        }
    );
  }
}
