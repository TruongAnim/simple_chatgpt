import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_chatgpt/app.dart';
import 'package:simple_chatgpt/app_observer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  Bloc.observer = const AppObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatGptApp());
}
