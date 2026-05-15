import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/database/supabase_service.dart';
import '../../domain/models/receipt_list_item_model.dart';
import '../../domain/models/receipt_detail_model.dart';
import '../helpers/receipt_create_helpers.dart';

typedef FindOrCreateWarehouseFn =
    Future<String> Function({
      required String name,
      required String location,
    });

typedef FindOrCreateProductFn =
    Future<String> Function({
      required String sku,
      required String name,
      required String unit,
    });

typedef PersistCreatedReceiptFn =
    Future<String> Function({
      required Map<String, dynamic> receiptPayload,
      required List<Map<String, dynamic>> itemRows,
    });

class ReceiptSupabaseDatasource {
  ReceiptSupabaseDatasource({
    SupabaseClient Function()? clientProvider,
    FindOrCreateWarehouseFn? findOrCreateWarehouse,
    FindOrCreateProductFn? findOrCreateProduct,
    PersistCreatedReceiptFn? persistCreatedReceipt,
  }) : _clientProvider = clientProvider ?? (() => SupabaseService.client),
       _findOrCreateWarehouseOverride = findOrCreateWarehouse,
       _findOrCreateProductOverride = findOrCreateProduct,
       _persistCreatedReceiptOverride = persistCreatedReceipt;

  final SupabaseClient Function() _clientProvider;
  final FindOrCreateWarehouseFn? _findOrCreateWarehouseOverride;
  final FindOrCreateProductFn? _findOrCreateProductOverride;
  final PersistCreatedReceiptFn? _persistCreatedReceiptOverride;

  SupabaseClient get _client => _clientProvider();

  Future<List<ReceiptListItemModel>> getReceipts() async {
    final response = await _client
        .from('inventory_receipts')
        .select('''
              id,
              receipt_number,
              receipt_date,
              delivered_by,
              total_amount,
              warehouse:warehouses(
                name
              )
            ''')
        .order('receipt_date', ascending: false);

    return response
        .map<ReceiptListItemModel>(
          (json) => ReceiptListItemModel.fromJson(json),
        )
        .toList();
  }

  Future<ReceiptDetailModel> getReceiptDetail(String receiptId) async {
    final response = await _client
        .from('inventory_receipts')
        .select('''
            *,
            warehouse:warehouses(
              name,
              location
            ),
            items:inventory_receipt_items(
              *,
              product:products(
                sku,
                name,
                unit
              )
            )
          ''')
        .eq('id', receiptId)
        .single();

    return ReceiptDetailModel.fromJson(response);
  }

  Future<String> createReceipt(CreateReceiptInput input) async {
    final warehouseId = await _resolveWarehouse(
      name: input.warehouseName,
      location: input.location,
    );

    final receiptPayload = buildReceiptInsertPayload(
      input: input,
      warehouseId: warehouseId,
    );
    final itemRows = <Map<String, dynamic>>[];

    for (final item in input.items) {
      final productId = await _resolveProduct(
        sku: item.productSku,
        name: item.productName,
        unit: item.unit,
      );

      itemRows.add(
        buildReceiptItemInsertPayload(
          receiptId: 'pending',
          productId: productId,
          item: item,
        ),
      );
    }

    final persistOverride = _persistCreatedReceiptOverride;
    if (persistOverride != null) {
      return persistOverride(
        receiptPayload: receiptPayload,
        itemRows: itemRows,
      );
    }

    final receipt = await _client
        .from('inventory_receipts')
        .insert(receiptPayload)
        .select('id')
        .single();

    final receiptId = receipt['id'] as String;

    if (itemRows.isNotEmpty) {
      final persistedRows = itemRows
          .map((row) => {...row, 'receipt_id': receiptId})
          .toList();
      await _client.from('inventory_receipt_items').insert(persistedRows);
    }

    return receiptId;
  }

  Future<String> _resolveWarehouse({
    required String name,
    required String location,
  }) {
    final override = _findOrCreateWarehouseOverride;
    if (override != null) {
      return override(name: name, location: location);
    }
    return _findOrCreateWarehouse(name: name, location: location);
  }

  Future<String> _resolveProduct({
    required String sku,
    required String name,
    required String unit,
  }) {
    final override = _findOrCreateProductOverride;
    if (override != null) {
      return override(sku: sku, name: name, unit: unit);
    }
    return _findOrCreateProduct(sku: sku, name: name, unit: unit);
  }

  Future<String> _findOrCreateWarehouse({
    required String name,
    required String location,
  }) async {
    final existing = await _client
        .from('warehouses')
        .select('id')
        .eq('name', name)
        .limit(1)
        .maybeSingle();

    if (existing != null) {
      return existing['id'] as String;
    }

    final created = await _client
        .from('warehouses')
        .insert({
          'code': buildReceiptEntityCode('WH', name),
          'name': name,
          'location': location,
        })
        .select('id')
        .single();

    return created['id'] as String;
  }

  Future<String> _findOrCreateProduct({
    required String sku,
    required String name,
    required String unit,
  }) async {
    final existing = sku.isNotEmpty
        ? await _client
              .from('products')
              .select('id')
              .eq('sku', sku)
              .limit(1)
              .maybeSingle()
        : null;

    if (existing != null) {
      return existing['id'] as String;
    }

    final created = await _client
        .from('products')
        .insert({
          'sku': sku.isNotEmpty ? sku : buildReceiptEntityCode('SP', name),
          'name': name,
          'unit': unit,
        })
        .select('id')
        .single();

    return created['id'] as String;
  }
}

class CreateReceiptInput {
  final String receiptNumber;
  final DateTime receiptDate;
  final String? debitAccount;
  final String? creditAccount;
  final String deliveredBy;
  final String? referenceType;
  final String? referenceNumber;
  final DateTime? referenceDate;
  final String? supplierName;
  final String warehouseName;
  final String location;
  final String companyName;
  final String departmentName;
  final double totalAmount;
  final int attachedDocumentsCount;
  final DateTime? signedAt;
  final String? createdByName;
  final String? warehouseKeeperName;
  final String? chiefAccountantName;
  final List<CreateReceiptItemInput> items;

  const CreateReceiptInput({
    required this.receiptNumber,
    required this.receiptDate,
    required this.debitAccount,
    required this.creditAccount,
    required this.deliveredBy,
    required this.referenceType,
    required this.referenceNumber,
    required this.referenceDate,
    required this.supplierName,
    required this.warehouseName,
    required this.location,
    required this.companyName,
    required this.departmentName,
    required this.totalAmount,
    required this.attachedDocumentsCount,
    required this.signedAt,
    required this.createdByName,
    required this.warehouseKeeperName,
    required this.chiefAccountantName,
    required this.items,
  });
}

class CreateReceiptItemInput {
  final int orderIndex;
  final String productName;
  final String productSku;
  final String unit;
  final double quantityDocument;
  final double quantityReceived;
  final double unitPrice;
  final double totalPrice;

  const CreateReceiptItemInput({
    required this.orderIndex,
    required this.productName,
    required this.productSku,
    required this.unit,
    required this.quantityDocument,
    required this.quantityReceived,
    required this.unitPrice,
    required this.totalPrice,
  });
}
