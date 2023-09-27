import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream/features/dummy/repositories/dummy_repository.dart';
import 'package:stream/utils/app_extensions.dart';
import 'package:stream/utils/specific_size_text_exrension.dart';

//! deals controller state notifier class
/* the state notifer stores a bool state so that I can also use this
  to manipulate the loading states of actions and side effects that pass
  through the controller
*/
class DealsController extends StateNotifier<bool> {
  final DealsRepository _dealsRepository;
  DealsController({
    required DealsRepository dealsRepository,
  })  : _dealsRepository = dealsRepository,
        super(false);

  //! get deals list from the deals repository class
  Future<List<DealModel>> getDealsList() async =>
      _dealsRepository.getDealsList();
}

///! PROVIDERS IN A SEPARATE DEAL PROVIDERS FILE
//! the provider for the deals controller
StateNotifierProvider<DealsController, bool> dealsControllerProvider =
    StateNotifierProvider((ref) {
  DealsRepository dealsRepository = ref.watch(dealsRepositoryProvider);
  return DealsController(
    dealsRepository: dealsRepository,
  );
});

//! future provider for getting deals
FutureProvider<List<DealModel>> getDealsListProvider =
    FutureProvider<List<DealModel>>((ref) {
  DealsController dealsController = ref.watch(dealsControllerProvider.notifier);
  return dealsController.getDealsList();
});

//! UI
class DealsListView extends ConsumerWidget {
  const DealsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<DealModel>> ayncListOfDeals =
        ref.watch(getDealsListProvider);
    return ayncListOfDeals.when(
      data: (List<DealModel> deals) => deals.isEmpty
          ? 'No deals found'.txt()
          : Column(
              children: List.generate(
                deals.length,
                (index) => deals[index].deal.txt14(),
              ),
            ),
      error: (error, stackTrace) => const Icon(Icons.error),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
