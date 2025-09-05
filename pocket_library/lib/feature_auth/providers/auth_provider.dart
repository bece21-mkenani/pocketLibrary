import 'package:flutter/foundation.dart';
import 'package:pocket_library/feature_auth/data/auth_repository.dart';


class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  bool _isLoading = false;
  String? _errorMessage;
  String? _registrationPhone; 

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get registrationPhone => _registrationPhone;


  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }


  void _setError(String? message) {
    _errorMessage = message;
  }


  Future<bool> registerUser({
    required String fullName,
    required String phone,
    required String password,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authRepository.register(
        fullName: fullName,
        phone: phone,
        password: password,
      );
  
      _registrationPhone = response['phone'];
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }


  Future<bool> verifyOtpUser({
    required String phone,
    required String otp,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      await _authRepository.verifyOtp(phone: phone, otp: otp);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<bool> loginUser({
    required String phone,
    required String password,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      await _authRepository.login(phone: phone, password: password);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
}