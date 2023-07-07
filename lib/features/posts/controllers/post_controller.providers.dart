part of 'post_controller.dart';

//! the provider for the post controller
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

//! provider for users posts and following
final userPostProvider = StreamProvider((ref) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.fetchUserPosts();
});

//! provider to get a post by ID
final getPostByIdProvider = StreamProvider.family((ref, String postID) {
  final postController = ref.watch(postControllerProvider.notifier);

  return postController.getPostById(postID: postID);
});

// //! provider to get all reposts by user
// final fetchRepostsPostsFromUserProvider = StreamProvider((ref) {
//   final postController = ref.watch(postControllerProvider.notifier);
//   return postController.fetchRepostsPostsFromUser();
// });

//! provider to get all reposts by user and following
final fetchRepostsFromFollowingAndUserProvider = StreamProvider((ref) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.fetchRepostsPostsFromFollowingAndUser();
});
