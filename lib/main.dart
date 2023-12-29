import 'package:audio_player_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'bloc/player_bloc/player_bloc.dart';
import 'bloc/screen_index_bloc/index_bloc.dart';

Future<void> main() async {
  //// **** For Background PLay  *** ////////
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain shared preferences.


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => IndexCubit(),),
          BlocProvider(create: (context) => PlayerBLoc(),),
        ],
        child: MaterialApp(
          title: "Audio Player",
          theme: ThemeData.dark(),
          home: const HomeScreen(),
        )

    );
  }
}