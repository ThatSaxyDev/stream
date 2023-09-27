import 'dart:developer';

import 'package:stream/features/auth/repository/auth_repository.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/utils/failure.dart';
import 'package:stream/utils/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider),
      // communityRepository: ref.watch(communityRepositoryProvider),
      ref: ref),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid: uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  // final CommunityRepository _communityRepository;
  final Ref _ref;
  AuthController({
    required AuthRepository authRepository,
    // required CommunityRepository communityRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        // _communityRepository = communityRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  //! sign in with google
  void signInWithGoogle({required BuildContext context}) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (Failure l) {
        log(l.message);
        showSnackBar(context: context, text: l.message);
      },
      (UserModel userModel) {
        _ref.read(userProvider.notifier).update((state) => userModel);
      },
    );
  }

  //! get user data
  Stream<UserModel> getUserData({required String uid}) {
    return _authRepository.getUserData(uid);
  }

  //! log out
  void logOut() async {
    _ref.read(userProvider.notifier).update((state) => null);
    _authRepository.logOut();
  }
}
