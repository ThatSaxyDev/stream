import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream/utils/app_extensions.dart';

Provider<DealsRepository> dealsRepositoryProvider = Provider((ref) {
  return DealsRepository();
});

class DealsRepository {
  //! get deals list
  Future<List<DealModel>> getDealsList() async {
    //! get deals from source
    List<DealModel> dealsFromSource = deals;
    Timer(const Duration(seconds: 5), () {
      'deals gotten'.log();
    });
    return dealsFromSource;
  }
}

//!

class DealModel {
  final String deal;

  DealModel(this.deal);
}

List<DealModel> deals = [
  DealModel('deal1'),
  DealModel('deal2'),
  DealModel('deal3'),
  DealModel('deal4'),
  DealModel('deal5'),
  DealModel('deal6'),
  DealModel('deal7'),
  DealModel('deal8'),
  DealModel('deal9'),
  DealModel('deal10'),
];
