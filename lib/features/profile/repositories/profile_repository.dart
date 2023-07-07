import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stream/core/constants/firebase_constants.dart';
import 'package:stream/core/providers/firebase_provider.dart';
import 'package:stream/core/type_defs.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/utils/failure.dart';

part '../repositories/profile_repository.providers.dart';

class UserProfileRepository {
  final FirebaseFirestore _firestore;
  UserProfileRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //! getters
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);

  //! edit profile
  FutureVoid editProfile(UserModel user) async {
    try {
      return right(_users.doc(user.uid).update(user.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
