import 'package:flutter/material.dart';
import 'package:yuppakids/simple_bloc_observer.dart';
import 'package:yuppakids/repositories/repositories.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}
