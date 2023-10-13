import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthController extends ChangeNotifier {
  final account = get<Account>();
  AuthStatus _status = AuthStatus.loading;
  late User _currentUser;
  bool _isLoading = false;

  User get currentUser => _currentUser;
  AuthStatus get status => _status;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadUser() async {
    try {
      _status = AuthStatus.loading;
      final user = await account.get();
      _status = AuthStatus.authenticated;
      _currentUser = user;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      // get<Logger>().e('Error getting user in AuthContoller: $e');
      // showMySnackBar('Error getting user in AuthContoller: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<User> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    _status = AuthStatus.loading;
    notifyListeners();
    try {
      final user = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return user;
    } catch (e) {
      showMySnackBar('Error Creating user in AuthContoller: $e');
      print(e);
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await account.deleteSession(sessionId: 'current');
      _status = AuthStatus.unauthenticated;
    } catch (e) {
      print(e);
      showMySnackBar('Error signing out in AuthController: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> signinWithEmail(String email, String password) async {
    _status = AuthStatus.loading;
    notifyListeners();
    await Future.delayed(kdelayDuration2000);
    try {
      await account.createEmailSession(email: email, password: password);
      _status = AuthStatus.authenticated;
    } catch (e) {
      print(e);
      showMySnackBar('Error signing in with email in AuthController: $e');
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  Future<Preferences> getUserPreferences() async {
    try {
      return await account.getPrefs();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updatePreferences({required String bio}) async {
    _status = AuthStatus.loading;
    notifyListeners();
    try {
      final newUser = await account.updatePrefs(prefs: {'bio': bio});
      _currentUser = newUser;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
