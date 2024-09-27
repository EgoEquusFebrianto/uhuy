import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class BioProvider extends ChangeNotifier {
  String? _image;
  double _score = 0;
  DateTime? _selectedDate;
  double _scale = 1.0; // Added scale variable

  final String _keyScore = 'score';
  final String _keyImage = 'image';
  final String _keyDate = 'selected_date';

  BioProvider() {
    loadData();
  }

  String? get image => _image;
  double get score => _score;
  DateTime? get selectedDate => _selectedDate;
  double get scale => _scale;

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _score = prefs.getDouble(_keyScore) ?? 0;
    _image = prefs.getString(_keyImage);
    String? dateString = prefs.getString(_keyDate);
    if (dateString != null) {
      _selectedDate = DateTime.tryParse(dateString);
    }
    notifyListeners();
  }

  Future<void> setScore(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _score = value;
    prefs.setDouble(_keyScore, value);
    notifyListeners();
  }

  Future<void> setImage(String? value) async {
    if (value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _image = value;
      prefs.setString(_keyImage, value);
      notifyListeners();
    }
  }

  Future<void> setDate(DateTime? date) async {
    if (date != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _selectedDate = date;
      prefs.setString(_keyDate, date.toIso8601String());
      notifyListeners();
    }
  }

  void setScale(double scale) {
    _scale = scale;
    notifyListeners();
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMMM y').format(date);
  }
}
