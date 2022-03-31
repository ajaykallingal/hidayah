

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs{

  JsonCodec codec = const JsonCodec();
  SharedPreferences? _sharedPreferences;

  Prefs();
  set sharedPreferences(SharedPreferences value){
    _sharedPreferences = value;
  }

}