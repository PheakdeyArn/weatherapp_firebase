import 'package:flutter/material.dart';
import '../screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  const app = MaterialApp(
    title: 'MAD-Weather',
    home: Splash(),
    debugShowCheckedModeBanner: false,
  );

  runApp(app);
}
