import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stream/core/constants/firebase_constants.dart';
import 'package:stream/core/providers/firebase_provider.dart';
import 'package:stream/core/type_defs.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/utils/failure.dart';

part '../repositories/post_repository.providers.dart';

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //! getters
  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);

  //! add a new post
  FutureVoid createPost({
    required PostModel post,
  }) async {
    try {
      return right(_posts.doc(post.id).set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! delete post
  FutureVoid deletePost({
    required PostModel post,
  }) async {
    try {
      return right(_posts.doc(post.id).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! get posts that a user can see
  Stream<List<PostModel>> fetchPostsForUser({
    required UserModel user,
  }) {
    return _posts
        .orderBy('createdAt', descending: true)
        .where('userUid', isEqualTo: user.uid)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => PostModel.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList());
  }

  //! ====>>>>
  Stream<List<PostModel>> fetchPostsFromFollowingAndUser({
    required UserModel user,
  }) {
    return _posts
        .orderBy('createdAt', descending: true)
        .where('userUid', whereIn: [...user.following!, user.uid])
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => PostModel.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList());
  }

  // like a post
  void likePost({
    required PostModel post,
    required UserModel user,
  }) async {
    if (post.likedBy!.contains(user.uid)) {
      _posts.doc(post.id).update({
        'likedBy': FieldValue.arrayRemove([user.uid]),
      });
    } else {
      _posts.doc(post.id).update({
        'likedBy': FieldValue.arrayUnion([user.uid]),
      });
    }
  }
}
