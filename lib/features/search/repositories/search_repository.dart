import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream/core/constants/firebase_constants.dart';
import 'package:stream/core/providers/firebase_provider.dart';
import 'package:stream/models/user_model.dart';

final searchRepositoryProvider = Provider((ref) {
  return SearchRepository(firestore: ref.watch(firestoreProvider));
});

class SearchRepository {
  final FirebaseFirestore _firestore;
  SearchRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  //! list of all users
  Stream<List<UserModel>> allUsers() {
    return _users.snapshots().map((event) {
      List<UserModel> users = [];
      for (var user in event.docs) {
        users.add(UserModel.fromMap(user.data() as Map<String, dynamic>));
      }
      return users;
    });
  }

  //! search users
  Stream<List<UserModel>> searchUsers({required String query}) {
    return _users
        .where(
          'username',
          isGreaterThanOrEqualTo: query.isEmpty ? '' : query.toLowerCase(),
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        // .where(
        //   'name',
        //   isGreaterThanOrEqualTo: query.isEmpty ? '' : query.toLowerCase(),
        //   isLessThan: query.isEmpty
        //       ? null
        //       : query.substring(0, query.length - 1) +
        //           String.fromCharCode(
        //             query.codeUnitAt(query.length - 1) + 1,
        //           ),
        // )
        .snapshots()
        .map((event) {
      List<UserModel> users = [];
      for (var user in event.docs) {
        users.add(UserModel.fromMap(user.data() as Map<String, dynamic>));
      }
      return users;
    });
  }
}
