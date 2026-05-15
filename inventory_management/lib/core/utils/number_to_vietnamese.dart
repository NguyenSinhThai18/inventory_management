class NumberToVietnamese {
  static const _digits = [
    'không',
    'một',
    'hai',
    'ba',
    'bốn',
    'năm',
    'sáu',
    'bảy',
    'tám',
    'chín',
  ];

  static String convert(int number) {
    if (number == 0) {
      return 'Không đồng';
    }

    final result = _read(number).trim();

    return '${_capitalize(result)} đồng';
  }

  static String _read(int number) {
    if (number < 10) {
      return _digits[number];
    }

    if (number < 100) {
      return _readTens(number);
    }

    if (number < 1000) {
      final hundred = number ~/ 100;

      final remain = number % 100;

      var result = '${_digits[hundred]} trăm';

      if (remain > 0) {
        if (remain < 10) {
          result += ' lẻ ${_read(remain)}';
        } else {
          result += ' ${_read(remain)}';
        }
      }

      return result;
    }

    if (number < 1000000) {
      final thousand = number ~/ 1000;

      final remain = number % 1000;

      var result = '${_read(thousand)} nghìn';

      if (remain > 0) {
        result += ' ${_read(remain)}';
      }

      return result;
    }

    if (number < 1000000000) {
      final million = number ~/ 1000000;

      final remain = number % 1000000;

      var result = '${_read(million)} triệu';

      if (remain > 0) {
        result += ' ${_read(remain)}';
      }

      return result;
    }

    final billion = number ~/ 1000000000;

    final remain = number % 1000000000;

    var result = '${_read(billion)} tỷ';

    if (remain > 0) {
      result += ' ${_read(remain)}';
    }

    return result;
  }

  static String _readTens(int number) {
    final tens = number ~/ 10;

    final unit = number % 10;

    if (tens == 1) {
      if (unit == 0) {
        return 'mười';
      }

      if (unit == 5) {
        return 'mười lăm';
      }

      return 'mười ${_digits[unit]}';
    }

    var result = '${_digits[tens]} mươi';

    if (unit == 0) {
      return result;
    }

    switch (unit) {
      case 1:
        result += ' mốt';
        break;

      case 4:
        result += ' tư';
        break;

      case 5:
        result += ' lăm';
        break;

      default:
        result += ' ${_digits[unit]}';
    }

    return result;
  }

  static String _capitalize(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }
}
