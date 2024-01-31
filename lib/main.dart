import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midjourney/feature/prompt/bloc/prompt_bloc.dart';
import 'package:midjourney/feature/prompt/ui/createpromptscreen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => PromptBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MidJourney',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: const CreatePromptScreen(),
    );
  }
}
