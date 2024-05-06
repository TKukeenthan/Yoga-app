import 'package:flutter/material.dart';
import 'package:yogaapp/app_service/app_service.dart';
import 'package:yogaapp/model/session_model.dart';

class HomeProvider extends ChangeNotifier {
  List<Session> _sessionList = [];
  List<Session> get sessionList => _sessionList;
  List<String> categoryImages = [
    'assets/images/hip.jpeg',
    'assets/images/lower-body.png',
    'assets/images/upper-body.png',
    'assets/images/full-body.png'
  ];
  List<SessionCategory> _category = [];
  List<SessionCategory> get category => _category;
  bool isLoading = true;
  Future<void> fetchData() async {
    try {
      _sessionList = await fetchSession().then((value) {
        _category = Session.getSessionCategories(value);

        return value;
      });
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  HomeProvider() {
    fetchData();
  }
}
