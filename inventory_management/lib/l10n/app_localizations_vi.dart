// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Quản lý nhập kho';

  @override
  String get hello => 'Xin chào';

  @override
  String get save => 'Lưu';

  @override
  String get cancel => 'Huỷ';

  @override
  String get welcomeBack => 'Chào mừng';

  @override
  String get loginDescription => 'Tiếp tục với Google để truy cập hệ thống quản lý kho.';

  @override
  String get continueWithGoogle => 'Tiếp tục với Google';

  @override
  String get loginSuccess => 'Đăng nhập thành công';

  @override
  String get loginFailed => 'Đăng nhập thất bại';

  @override
  String get inventoryDescription => 'Hệ thống quản lý kho hiện đại sử dụng Firebase';

  @override
  String get dashboardDescription => 'Bảng điều khiển quản lý kho';

  @override
  String get receipts => 'Phiếu';

  @override
  String get dashboard => 'Bảng điều khiển';

  @override
  String get products => 'Sản phẩm';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get inventoryManager => 'Quản lý kho';

  @override
  String get create => 'Tạo';

  @override
  String get chooseReceiptType => 'Chọn loại phiếu';

  @override
  String get chooseReceiptTypeDescription => 'Chọn loại phiếu bạn muốn tạo.';

  @override
  String get inventoryReceipt => 'Phiếu nhập kho';

  @override
  String get inventoryReceiptDescription => 'Tạo phiếu nhập hàng vào kho.';

  @override
  String get productsPage => 'Trang sản phẩm';

  @override
  String get profilePage => 'Trang hồ sơ';
  @override
  String get searchReceiptHint => 'Tìm kiếm số phiếu...';

  @override
  String get filter => 'Lọc';

  @override
  String get upload => 'Tải lên';

  @override
  String get scan => 'Quét';

  @override
  String get receiptTableComingSoon => 'Bảng phiếu sẽ sớm có';

  @override
  String get receiptTableReceiptNo => 'Số phiếu';

  @override
  String get receiptTableDate => 'Ngày';

  @override
  String get receiptTableWarehouse => 'Kho';

  @override
  String get receiptTableDeliveredBy => 'Người giao';

  @override
  String get receiptTableTotal => 'Tổng tiền';

  @override
  String get receiptTableAction => 'Thao tác';

  @override
  String get receiptTableView => 'Xem';

  @override
  String receiptTableShowingRange(Object start, Object end, Object total) {
    return 'Hiển thị $start - $end trên $total';
  }
}
