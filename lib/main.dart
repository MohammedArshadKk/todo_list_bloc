import 'package:flutter/material.dart';
import 'package:todo_list_bloc/home/ui/home.dart';

void main() {
  runApp(const MyApp());
}  

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override   
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bloc todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:  HomeScreen(),   
    );
  }
}
