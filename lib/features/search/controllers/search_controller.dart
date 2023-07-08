import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream/core/providers/storage_repository_provider.dart';
import 'package:stream/features/search/repositories/search_repository.dart';
import 'package:stream/models/user_model.dart';

part '../controllers/search_controller.providers.dart';

class SearchController extends StateNotifier<bool> {
  final SearchRepository _searchRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;
  SearchController({
    required SearchRepository searchRepository,
    required StorageRepository storageRepository,
    required Ref ref,
  })  : _searchRepository = searchRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  //! all users
  Stream<List<UserModel>> allUsers() {
    return _searchRepository.allUsers();
  }

  //! search users
  Stream<List<UserModel>> searchUsers({required String query}) {
    return _searchRepository.searchUsers(query: query);
  }
}
