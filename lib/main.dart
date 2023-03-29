import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_chatgpt/app.dart';
import 'package:simple_chatgpt/app_observer.dart';

void main() {
  Bloc.observer = const AppObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ChatGptApp());
}
