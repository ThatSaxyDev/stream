import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream/core/providers/storage_repository_provider.dart';
import 'package:stream/features/notifications/repositories/notifications_repository.dart';

part '../controllers/notifications_controller.provider.dart';

class NotificationsController extends StateNotifier<bool> {
  final NotificationsRepository _notificationsRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;
  NotificationsController({
    required NotificationsRepository notificationsRepository,
    required StorageRepository storageRepository,
    required Ref ref,
  })  : _notificationsRepository = notificationsRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);
}
