import 'package:flutter/material.dart';
class FavouriteSongsScreen extends StatefulWidget {
  const FavouriteSongsScreen({super.key});

  @override
  State<FavouriteSongsScreen> createState() => _FavouriteSongsScreenState();
}

class _FavouriteSongsScreenState extends State<FavouriteSongsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Song Found"),
    );
  }
}
