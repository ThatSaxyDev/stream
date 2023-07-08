part of 'search_controller.dart';

final searchControllerProvider =
    StateNotifierProvider<SearchController, bool>((ref) {
  final searchRepository = ref.watch(searchRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return SearchController(
    searchRepository: searchRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

//! search users provider
StreamProvider<List<UserModel>> allUsersProvider = StreamProvider((ref) {
  return ref.watch(searchControllerProvider.notifier).allUsers();
});

//! search users provider
final searchUsersProvider =
    StreamProvider.family((ref, String query) {
  return ref.watch(searchControllerProvider.notifier).searchUsers(query: query);
});
