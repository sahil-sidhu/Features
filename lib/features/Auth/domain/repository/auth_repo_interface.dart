import 'package:chambas/features/Auth/domain/models/user_model.dart';

// this outlines which functions the User object from firebase will have.
// write down the possible actions which will be available to the fron end?
abstract class AuthRepoInterface {
  // authentication, register, and signout methods from interface
  Future<UserModel?> login(String email, String password);
  Future<UserModel?> register(String email, String password);
  Future<void> logout();

  // retrieve model from interface
  Future<UserModel?> getCurrentUser();
}
