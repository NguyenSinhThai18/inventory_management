import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/receipt_supabase_datasource.dart';
import '../../domain/models/receipt_list_item_model.dart';

final receiptDatasourceProvider = Provider<ReceiptSupabaseDatasource>((ref) {
  return ReceiptSupabaseDatasource();
});

final receiptsProvider = FutureProvider<List<ReceiptListItemModel>>((
  ref,
) async {
  return ref.read(receiptDatasourceProvider).getReceipts();
});
