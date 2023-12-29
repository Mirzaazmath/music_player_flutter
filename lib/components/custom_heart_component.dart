import 'package:audio_player_app/components/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FavouriteWidget extends StatefulWidget {
  String id;
  FavouriteWidget({super.key, required this.id});

  @override
  State<FavouriteWidget> createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget>{

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

   });

  }
  addToFavourite() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    favouriteIds?.add(widget.id);
    await prefs.setStringList('myFavourite', favouriteIds!);
    setState(() {});
    showToast("Added To Favourite");
  }
  removeFromFavourite() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    favouriteIds?.remove(widget.id);
    await prefs.setStringList('myFavourite', favouriteIds!);
    setState(() {});
    showToast("Remove From Favourite");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       if(favouriteIds!.contains(widget.id)){
         removeFromFavourite();
       }else{
         addToFavourite();
       }
      },
      child: AnimatedContainer(
        duration:const  Duration(milliseconds: 100),
        curve: Curves.easeInOutQuint,
        height:favouriteIds!.contains(widget.id)? 40:30,
       width: favouriteIds!.contains(widget.id)? 40:30,
        child: Icon(
          Icons.favorite,size: favouriteIds!.contains(widget.id)? 40:30,color:favouriteIds!.contains(widget.id)?Colors.red: Colors.grey[400],),
      ),
    );
  }
}
