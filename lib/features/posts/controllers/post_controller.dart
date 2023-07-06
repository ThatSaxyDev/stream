import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stream/core/providers/storage_repository_provider.dart';
import 'package:stream/features/auth/controller/auth_controller.dart';
import 'package:stream/features/posts/repositories/post_repository.dart';
import 'package:stream/models/post_model.dart';
import 'package:stream/models/user_model.dart';
import 'package:stream/utils/failure.dart';
import 'package:stream/utils/nav.dart';
import 'package:stream/utils/snack_bar.dart';
import 'package:uuid/uuid.dart';

part '../controllers/post_controller.providers.dart';

class PostController extends StateNotifier<bool> {
  final PostRepository _postRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;
  PostController({
    required PostRepository postRepository,
    required StorageRepository storageRepository,
    required Ref ref,
  })  : _postRepository = postRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  // create post
  void createPost({
    required BuildContext context,
    required String textContent,
    required File? image,
    Uint8List? file,
  }) async {
    state = true;
    String postId = const Uuid().v1();
    UserModel user = _ref.read(userProvider)!;
    String photo = '';
    if (image != null) {
      Either<Failure, String> res = await _storageRepository.storeFile(
        path: 'posts/ids',
        id: user.uid!,
        file: image,
        webFile: file,
      );
      res.fold(
        (l) => showSnackBar(context: context, text: l.message),
        (r) => photo = r,
      );
    }

    final PostModel post = PostModel(
      id: postId,
      textContent: textContent,
      commentCount: 0,
      bookmarkedBy: [],
      repliedTo: [],
      repostedBy: [],
      userUid: user.uid,
      imageUrl: photo,
      createdAt: DateTime.now(),
    );

    Either<Failure, void> res = await _postRepository.createPost(post: post);

    state = false;
    res.fold(
      (l) => showSnackBar(context: context, text: l.message),
      (r) {
        // showSnackBar(context: context, text: 'Posted Successfully!');
        Routemaster.of(context).pop();
      },
    );
  }

  //! get post by id
  Stream<PostModel> getPostById({required String postID}) {
    return _postRepository.getPostById(postID: postID);
  }

  // reply post
  void replyPost({
    required BuildContext context,
    required String textContent,
    required File? image,
    required PostModel repliedPost,
    Uint8List? file,
  }) async {
    state = true;
    String postId = const Uuid().v1();
    UserModel user = _ref.read(userProvider)!;
    String photo = '';
    if (image != null) {
      Either<Failure, String> res = await _storageRepository.storeFile(
        path: 'posts/ids',
        id: user.uid!,
        file: image,
        webFile: file,
      );
      res.fold(
        (l) => showSnackBar(context: context, text: l.message),
        (r) => photo = r,
      );
    }

    final PostModel post = PostModel(
      id: postId,
      textContent: textContent,
      commentCount: 0,
      bookmarkedBy: [],
      repliedTo: [],
      likedBy: [],
      replyingPostId: repliedPost.id,
      repostedBy: [],
      userUid: user.uid,
      imageUrl: photo,
      createdAt: DateTime.now(),
    );

    Either<Failure, void> res = await _postRepository.replyPost(
      post: post,
      repliedPost: repliedPost,
    );

    state = false;
    res.fold(
      (l) => showSnackBar(context: context, text: l.message),
      (r) {
        showSnackBar(context: context, text: 'Posted Successfully!');
        Routemaster.of(context).pop();
      },
    );
  }

  //! delete post
  void deletePost({
    required PostModel post,
    required BuildContext context,
  }) async {
    final res = await _postRepository.deletePost(post: post);

    res.fold(
      (l) => null,
      (r) => goBack(context),
    );
  }

  //! fetch posts
  Stream<List<PostModel>> fetchUserPosts() {
    UserModel user = _ref.read(userProvider)!;
    // if (communities.isNotEmpty) {
    return _postRepository.fetchPostsFromFollowingAndUser(user: user);
    // }
    // return Stream.value([]);
  }

  //! like a post
  void likePost({required PostModel post}) async {
    UserModel user = _ref.read(userProvider)!;
    _postRepository.likePost(post: post, user: user);
  }
}
