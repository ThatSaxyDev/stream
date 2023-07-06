part of 'post_controller.dart';

StateNotifierProvider<PostController, bool> postControllerProvider =
    StateNotifierProvider<PostController, bool>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return PostController(
    postRepository: postRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

final userPostProvider = StreamProvider.autoDispose((ref) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.fetchUserPosts();
});

final getPostByIdProvider = StreamProvider.family((ref, String postID) {
  final postController = ref.watch(postControllerProvider.notifier);

  return postController.getPostById(postID: postID);
});
