import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stream/core/constants/firebase_constants.dart';
import 'package:stream/core/providers/firebase_provider.dart';
import 'package:stream/core/type_defs.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/quote_nodel.dart';
import 'package:stream/models/repost_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/utils/failure.dart';
import 'package:uuid/uuid.dart';

part '../repositories/post_repository.providers.dart';

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //! getters
  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);

  CollectionReference get _reposts =>
      _firestore.collection(FirebaseConstants.repostsCollection);

  CollectionReference get _quotes =>
      _firestore.collection(FirebaseConstants.quotesCollection);

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

  //! reply a post
  FutureVoid replyPost({
    required PostModel repliedPost,
    required PostModel post,
  }) async {
    try {
      _posts.doc(repliedPost.id).update({
        'repliedTo': FieldValue.arrayUnion([post.id]),
      });
      return right(_posts.doc(post.id).set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! repost
  FutureVoid rePost({
    required PostModel post,
    required UserModel user,
  }) async {
    String repostId = const Uuid().v1();
    final repostModel = RepostModel(
      id: repostId,
      repostedByUser: user.uid,
      postId: post.id,
      createdAt: DateTime.now(),
    );
    try {
      if (post.repostedBy!.contains(user.uid)) {
        final querySnapshot =
            await _reposts.where('postId', isEqualTo: post.id).get();
        final documents = querySnapshot.docs;
        if (documents.isNotEmpty) {
          final repostId = documents[0].id;
          await _reposts.doc(repostId).delete();
        }
        return right(_posts.doc(post.id).update({
          'repostedBy': FieldValue.arrayRemove([user.uid]),
        }));
      } else {
        await _reposts.doc(repostId).set(repostModel.toMap());
        return right(_posts.doc(post.id).update({
          'repostedBy': FieldValue.arrayUnion([user.uid]),
        }));
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! quote a post 2
  FutureVoid quoteAPost2({
    required PostModel quotedPost,
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

  //! quote a  post
  FutureVoid quoteAPost({
    required QuoteModel quotePost,
  }) async {
    try {
      return right(_quotes.doc(quotePost.id).set(quotePost.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! get quotes for user
  Stream<List<PostModel>> fetchQuotesFromFollowingAndUser({
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

  //! get a post by ID
  Stream<PostModel> getPostById({required String postID}) {
    return _posts.doc(postID).snapshots().map(
        (event) => PostModel.fromMap(event.data() as Map<String, dynamic>));
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

  //! get a users liked posts
  Stream<List<PostModel>> getUsersLikedPosts({
    required UserModel user,
  }) {
    return _posts
        .orderBy('createdAt', descending: true)
        .where('likedBy', arrayContains: user.uid)
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
    user.following!.length.toString();
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

  //! get reposts from following and user
  Stream<List<RepostModel>> fetchRepostsPostsFromFollowingAndUser({
    required UserModel user,
  }) {
    return _reposts
        .orderBy('createdAt', descending: true)
        .where('repostedByUser', whereIn: [...user.following!, user.uid])
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => RepostModel.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList());
  }

  //! get reposts from user
  Stream<List<RepostModel>> fetchRepostsPostsFromUser({
    required UserModel user,
  }) {
    return _reposts
        .orderBy('createdAt', descending: true)
        .where('repostedByUser', isEqualTo: user.uid)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => RepostModel.fromMap(e.data() as Map<String, dynamic>),
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
