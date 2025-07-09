part of 'notifications_controller.dart';

//! the provider for the post controller
StateNotifierProvider<NotificationsController, bool>
    notificationsControllerProvider =
    StateNotifierProvider<NotificationsController, bool>((ref) {
  final notificationsRepository = ref.watch(notificationsRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return NotificationsController(
    notificationsRepository: notificationsRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

//! provider for user notifications
final getNotificationsProvider = StreamProvider((ref) {
  final notificationsController =
      ref.watch(notificationsControllerProvider.notifier);

  return notificationsController.getUserNotifications();
});
