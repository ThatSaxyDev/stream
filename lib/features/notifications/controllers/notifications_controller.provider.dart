part of 'notifications_controller.dart';

//! the provider for the post controller
StateNotifierProvider<NotificationsController, bool> postControllerProvider =
    StateNotifierProvider<NotificationsController, bool>((ref) {
  final notificationsRepository = ref.watch(notificationsRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return NotificationsController(
    notificationsRepository: notificationsRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});
