import 'package:flutter/material.dart';
import 'package:yogaapp/app_service/auth_service.dart';

class RegisterProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String _gender = 'Gender';
  String get gender => _gender;

  void updateGender(String selectedGender) {
    _gender = selectedGender;
    notifyListeners();
  }

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isErrorShow = false;
  bool get isErrorShow => _isErrorShow;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<bool> getErrorMessage() async {
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      _errorMessage = 'Passwords Not March';
      notifyListeners();
      return false;
    } else if (passwordController.text.isEmpty ||
        emailController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        userNameController.text.isEmpty ||
        gender == 'Gender') {
      _errorMessage = 'All fields are required';
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  void updateErrormessage(String error) {
    _errorMessage = error;
    _isErrorShow = true;
    notifyListeners();
  }

  void loading() {
    _isLoading = true;
    notifyListeners();
  }

  Future<void> singUp(BuildContext context) async {
    loading();
    notifyListeners();
    try {
      await getErrorMessage().then(
        (value) async {
          if (value) {
            await registerUser(
                    userNameController.text.trim(),
                    emailController.text.trim(),
                    gender,
                    passwordController.text.trim())
                .then((value) {
              if (value) {
                Navigator.pushNamed(context, '/login');
                _isErrorShow = false;
              } else {
                _errorMessage = 'Failed to create ';
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
