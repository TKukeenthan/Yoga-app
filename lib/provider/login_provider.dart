import 'package:flutter/material.dart';
import 'package:yogaapp/app_service/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isErrorShow = false;
  bool get isErrorShow => _isErrorShow;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<bool> getErrorMessage() async {
    if (passwordController.text.isEmpty || emailController.text.isEmpty) {
      _errorMessage = 'All fields are required';
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  void loading() {
    _isLoading = true;
    notifyListeners();
  }

  Future<void> singin(BuildContext context) async {
    loading();
    notifyListeners();
    try {
      await getErrorMessage().then(
        (value) async {
          if (value) {
            await loginUser(
                    emailController.text.trim(), passwordController.text.trim())
                .then((value) {
              if (value) {
                Navigator.pushNamed(context, '/home');
                _isErrorShow = false;
              } else {
                _errorMessage = 'Failed to Login ';
                _isErrorShow = true;
              }
            });
          } else {
            _isErrorShow = true;
          }
        },
      );
    } catch (e) {
      _errorMessage = e.toString();
      _isErrorShow = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }
}
