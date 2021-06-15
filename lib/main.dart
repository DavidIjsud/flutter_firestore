import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_topico/pages/home_page.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 


  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
      title: 'Topico Avanzado de programacion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
   
        primarySwatch: Colors.green,
      ),
      home:HomePage() 
    );
  }
}
