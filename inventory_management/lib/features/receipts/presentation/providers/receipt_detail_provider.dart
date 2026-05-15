import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/receipt_detail_model.dart';
import 'receipt_provider.dart';

final receiptDetailProvider = FutureProvider.family<ReceiptDetailModel, String>(
  (ref, receiptId) async {
    return ref.read(receiptDatasourceProvider).getReceiptDetail(receiptId);
  },
);
