abstract class PlayerStates{}

class PlayerInitialState extends PlayerStates{}

class PlayerStatesUpdatedState extends PlayerStates{
  bool isPlaying;
  String title;
  String artist;
  PlayerStatesUpdatedState(this.isPlaying,this.title,this.artist);

}