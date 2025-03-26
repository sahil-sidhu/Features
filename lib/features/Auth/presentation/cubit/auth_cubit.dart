// State managment for Authentication

import 'package:chambas/features/Auth/data/repository/auth_repo_impl.dart';
import 'package:chambas/features/Auth/domain/models/user_model.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepoImpl authRepoImpl;
  UserModel? _currentUser;

  AuthCubit({required this.authRepoImpl}) : super(AuthInitial());

  void checkAuth() async {
    final UserModel? user = await authRepoImpl.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  // get current user
  UserModel? get currentUser => _currentUser;

  // Log in with emal and password
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepoImpl.login(email, password);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(AuthFailure("User not found"));
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepoImpl.register(email, password);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(AuthFailure("Registration failed"));
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    await authRepoImpl.logout();
    _currentUser = null;
    emit(Unauthenticated());
  }
}
