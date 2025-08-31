import 'package:evide_assignment/screens/stop_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Bus App',
      theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    secondary: Colors.orangeAccent,
  ),
  scaffoldBackgroundColor: Colors.grey.shade100,
  // cardTheme: CardTheme(
  //   elevation: 6,
  //   margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(16)),
  //   ),
  // ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
),
      home: const StopListScreen(),
    );
  }
}