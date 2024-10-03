import 'package:saltarin/game/Saltarin.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = Saltarin();
  runApp(GameWidget(game: game));
}
