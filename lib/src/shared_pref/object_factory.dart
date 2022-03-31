




import 'package:hidayah/src/shared_pref/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/client/api_client.dart';
import '../data/repository/repository.dart';

/// it is a hub that connecting pref,repo,client
/// used to reduce imports in pages


class ObjectFactory{
  static final _objectFactory = ObjectFactory._internal();

  ObjectFactory._internal();
  factory ObjectFactory() => _objectFactory;


  /// initialisation of objects

  Prefs _prefs = Prefs();
  ApiClient _apiClient = ApiClient();
  Repository _repository = Repository();

///
/// Getters of Objects
///

Prefs get prefs => _prefs;
ApiClient get apiClient => _apiClient;
Repository get repository => _repository;

///
/// Setters of Objects
///

void setPrefs(SharedPreferences sharedPreferences){
  _prefs.sharedPreferences = sharedPreferences;
}



}