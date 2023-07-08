part of 'notifications_repository.dart';

//! the provider for the notification repository
Provider<NotificationsRepository> notificationsRepositoryProvider = Provider((ref) {
  return NotificationsRepository(firestore: ref.watch(firestoreProvider));
});
