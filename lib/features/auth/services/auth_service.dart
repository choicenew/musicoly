import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/core/models/user_model.dart';

/// Base class for authentication services
abstract class AuthService extends BaseService {
  UserModel? get currentUser;
  bool get isLoggedIn;

  Future<UserModel> login(String username, String password);
  Future<UserModel> loginWithToken(String token);
  Future<UserModel> loginWithOAuth();
  Future<void> logout();
  Future<UserModel> getUserProfile();
  Future<UserModel> updateUserProfile(Map<String, dynamic> data);
  Future<String?> getToken();
  Future<UserModel?> getCurrentUser();
  Future<bool> isAuthenticated();
  Future<bool> authenticate();
  Future<bool> refreshToken();
  Future<void> signOut();
  Future<DateTime?> getTokenExpiration();
  Future<bool> isTokenExpired();
  String get platformName;
  Stream<bool> get authStateStream;
  Stream<UserModel?> get userStream;
}
