part of 'profile_repository.dart';

final userProfileRepositoryProvider = Provider((ref) {
  return UserProfileRepository(firestore: ref.watch(firestoreProvider));
});
