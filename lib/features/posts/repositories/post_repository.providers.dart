part of 'post_repository.dart';

//! the provider for the post repository
Provider<PostRepository> postRepositoryProvider = Provider((ref) {
  return PostRepository(firestore: ref.watch(firestoreProvider));
});
