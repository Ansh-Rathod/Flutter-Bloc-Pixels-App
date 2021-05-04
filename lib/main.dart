import 'package:flutter/material.dart';
import 'bloc/pixa_bloc.dart';
import 'pixa_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FlutterDownloader.initialize(debug: true);

//   FlutterDownloader.registerCallback(_emptyCallback);
  runApp(MyApp());
}

// void _emptyCallback(String id, DownloadTaskStatus status, int progress) {}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          body1: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline: GoogleFonts.montserrat(
              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PixaBloc()..add(PixaGetEvent()),
          ),
        ],
        child: PixaHome(),
      ),
    );
  }
}
