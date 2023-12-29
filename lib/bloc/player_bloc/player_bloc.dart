import 'package:audio_player_app/bloc/player_bloc/player_states.dart';
import 'package:audio_player_app/components/toast_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

final AudioPlayer audioPlayer = AudioPlayer();


class PlayerBLoc extends Cubit<PlayerStates>{
  /// for all songs for play
  List<AudioSource>allSongs=[];
  /// for duration of song
  Duration duration = const Duration();
  /// for position of song
  Duration postion = const Duration();
  /// for title and artist name and etc information
  List<SongModel> playList=[];
  /// for playing state
  bool isPlaying=false;
  /// for current index
  int? currentIndex;
  /// for shuffle
  bool isShuffle=false;

  PlayerBLoc():super(PlayerInitialState());

////////////******** To play the Song ********///////////////
 void  playSong(List<SongModel> songList,int index ) {
   // here we are clearing the all songs list
   // if we do not empty it will give some errors
   allSongs=[];
   // here we are assiging the songlist to playList for songInfo like name etc
   playList=songList;
   // here we are using the try catch
    try {
      // here we are wraping  each song of songList with MediaItem for background play
      // external function
      // Just_audio_background package
      for(var element in songList){
        allSongs.add( AudioSource.uri(Uri.parse(element.uri!),
            tag: MediaItem(
              // Specify a unique ID for each media item:
              id: "${element.id}",
              // Metadata to display in the notification:
              album: "${element.album}",
              title: element.displayNameWOExt,
              artUri: Uri.parse(element.id.toString()),
            )),);

      }
      // here we setting the setAudioSource with ConcatenatingAudioSource for background functionality
      // passing initialIndex to play song which we have tapped
      audioPlayer.setAudioSource(
          ConcatenatingAudioSource(children: allSongs,),initialIndex: index
      );
      //  audioPlayer.play(); this function starts the song
     audioPlayer.play();
     audioPlayer.setLoopMode(LoopMode.all);
     // setting isPlaying to true to update our mini player
      isPlaying = true;
      // setting  currentIndex to given index to get all correct details
      currentIndex=index;
    } on Exception {
      // need to add something to show when the song is currpted
      debugPrint("Cannot Play song");
    }
    // # This function is responsible for  duration of song
   durationStream();
   // # This function is responsible for  position of song
   positionStream();
   // # This function is responsible for  index of song
   indexStream();
   // Update the state
    emit(PlayerStatesUpdatedState(isPlaying,playList[currentIndex!].displayNameWOExt,playList[currentIndex!].artist??"",playList[currentIndex!].id.toString()));
 }
////////////******** To Update the duration of song ********///////////////
  void durationStream(){
   // here we are listening to durationStream and updating the duration
    audioPlayer.durationStream.listen((d) {
      // setting duration to  new value
      duration = d!;
      // Update the state
      emit(PlayerStatesUpdatedState(isPlaying,playList[currentIndex!].displayNameWOExt,playList[currentIndex!].artist??"",playList[currentIndex!].id.toString()));
    });
  }

  ////////////******** To Update the Position on song  ********///////////////
void positionStream(){
  // here we are listening to positionStream and updating the position value
  audioPlayer.positionStream.listen((p) {
    // setting position value to  new value
    postion = p;
    // Update the state
    emit(PlayerStatesUpdatedState(isPlaying,playList[currentIndex!].displayNameWOExt,playList[currentIndex!].artist??"",playList[currentIndex!].id.toString()));

  });
}
////////////******** To Play and Pause the Current Song ********///////////////
  void playAndPause(){
   // first we are checking the is the song is playing or not
    if (isPlaying) {
      // if playing we stop
      audioPlayer.pause();
    } else {
      // if not we play
      audioPlayer.play();
    }
    isPlaying = !isPlaying;
    // Update the state
    emit(PlayerStatesUpdatedState(isPlaying,playList[currentIndex!].displayNameWOExt,playList[currentIndex!].artist??"",playList[currentIndex!].id.toString()));

  }
  ////////////******** To Change the Index when the player play another song ********///////////////
  void indexStream(){
    // here we are listening to currentIndexStream and updating the currentIndex value
    audioPlayer.currentIndexStream.listen((index) {
      if(index!=null){
        currentIndex=index;
        // Update the state
        emit(PlayerStatesUpdatedState(isPlaying,playList[currentIndex!].displayNameWOExt,playList[currentIndex!].artist??"",playList[currentIndex!].id.toString()));
      }

    });
  }
////////////******** To Change Slider on Music ********///////////////
  void  changeSlideValue(int seconds) {
   // here we are changing the song duration with slider
    Duration duration = Duration(seconds: seconds);
    // updating the slider with seek method of audioPlayer
    audioPlayer.seek(duration);
    // Update the state
    emit(PlayerStatesUpdatedState(isPlaying,playList[currentIndex!].displayNameWOExt,playList[currentIndex!].artist??"",playList[currentIndex!].id.toString()));
  }
////////////******** To Play Next Song  ********///////////////
  void moveToNextSong(){
   // here we are checking whether we have next song in the list
    if(audioPlayer.hasNext){
      // if yes then we move to next song
      audioPlayer.seekToNext();
    }
    // Update the state
    emit(PlayerStatesUpdatedState(isPlaying,playList[currentIndex!].displayNameWOExt,playList[currentIndex!].artist??"",playList[currentIndex!].id.toString()));

  }

////////////******** To PLay Previous Song ********///////////////
  void moveToPreviousSong(){
    // here we are checking whether we have previous song in the list
    if(audioPlayer.hasPrevious){
      // if yes then we move to previous song
      audioPlayer.seekToPrevious();
    }
    // Update the state
    emit(PlayerStatesUpdatedState(isPlaying,playList[currentIndex!].displayNameWOExt,playList[currentIndex!].artist??"",playList[currentIndex!].id.toString()));

  }
  void shuffleSongs(){
   audioPlayer.setShuffleModeEnabled(!isShuffle);
   showToast(!isShuffle?"Shuffle ON":"Shuffle OFF");
   isShuffle=!isShuffle;

   emit(PlayerStatesUpdatedState(isPlaying,playList[currentIndex!].displayNameWOExt,playList[currentIndex!].artist??"",playList[currentIndex!].id.toString()));
  }
  ////////////******** Dispose ********///////////////
  @override
  Future<void> close() {
    // TODO: implement close
    audioPlayer.dispose();
    return super.close();
  }

}