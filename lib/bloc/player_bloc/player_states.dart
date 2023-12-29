abstract class PlayerStates{}

class PlayerInitialState extends PlayerStates{}

class PlayerStatesUpdatedState extends PlayerStates{
  bool isPlaying;
  String title;
  String artist;
  String id;
  PlayerStatesUpdatedState(this.isPlaying,this.title,this.artist,this.id);

}