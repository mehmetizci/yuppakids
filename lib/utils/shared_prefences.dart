import 'package:uuid/uuid.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuppakids/utils/prefs_singleton.dart';

class PreferenceNames {
  static const userId = "userId";
  static const profileId = "profileId";
  static const profileName = "profileName";
}

class SharedUserPreferences with ChangeNotifier {
  SharedUserPreferences() {
    loadState();
  }
  final SharedPreferences _prefs = PrefsSingleton.prefs;
  String _userId;
  String _profileId;
  String _profileName;

  String get userId => _userId;
  String get profileId => _profileId;
  String get profileName => _profileName;

  set userId(String value) {
    _userId = value;
    notifyListeners();
  }

  set profileId(String value) {
    _profileId = value;
    notifyListeners();
  }

  set profileName(String value) {
    _profileName = value;
    notifyListeners();
  }

  Future saveState() async {
    await _prefs.setString(PreferenceNames.userId, this.userId);
    await _prefs.setString(PreferenceNames.profileId, this.profileId);
    await _prefs.setString(PreferenceNames.profileName, this.profileName);
  }

  void loadState() async {
    userId = _prefs.getString(PreferenceNames.userId);
    profileId = _prefs.getString(PreferenceNames.profileId);
    profileName = _prefs.getString(PreferenceNames.profileName);
    print("buraya geldi");
  }

  Future setUserId() async {
    var uuid = Uuid();

    final String uuidUserId = uuid.v4();
    if (this.userId == null) {
      userId = uuidUserId;
      profileId = '1';
      profileName = 'Oyuncu';
    }
    saveState();
  }

  Future setProfileId(String prfId) async {
    profileId = prfId;
    saveState();
  }

  /* static setProfileName(String profileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileName', profileName);
  }*/

}
