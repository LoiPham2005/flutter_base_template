// lib/core/utils/validators.dart
class Validators {
  Validators._();

  // Username validator
  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tên người dùng không được để trống';
    }
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(value)) {
      return 'Tên người dùng chỉ được chứa chữ, số và dấu gạch dưới';
    }
    if (value.length < 3) {
      return 'Tên người dùng phải có ít nhất 3 ký tự';
    }
    return null;
  }

  // Email validator
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }

    return null;
  }

  // Name validator
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Họ tên không được để trống';
    }
    final nameRegex = RegExp(r'^[a-zA-ZÀ-ỹ\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Họ tên chỉ được chứa chữ cái và khoảng trắng';
    }
    if (value.trim().length < 2) {
      return 'Họ tên quá ngắn';
    }
    return null;
  }

  // Password validator
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }

    if (value.length < minLength) {
      return 'Mật khẩu phải có ít nhất $minLength ký tự';
    }

    return null;
  }

  // Strong password validator
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }

    if (value.length < 8) {
      return 'Mật khẩu phải có ít nhất 8 ký tự';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Mật khẩu phải có ít nhất 1 chữ hoa';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Mật khẩu phải có ít nhất 1 chữ thường';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Mật khẩu phải có ít nhất 1 số';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Mật khẩu phải có ít nhất 1 ký tự đặc biệt';
    }

    return null;
  }

  // Phone number validator (Vietnam)
  static String? phoneVN(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại không được để trống';
    }

    final phoneRegex = RegExp(r'^(0|\+84)[3|5|7|8|9][0-9]{8}$');

    if (!phoneRegex.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }

    return null;
  }

  // OTP validator
  static String? otp(String? value, {int length = 6}) {
    if (value == null || value.isEmpty) {
      return 'Mã OTP không được để trống';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mã OTP chỉ được chứa số';
    }
    if (value.length != length) {
      return 'Mã OTP phải gồm $length chữ số';
    }
    return null;
  }

  // Required validator
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? "Trường này"} không được để trống';
    }
    return null;
  }

  // Number range validator
  static String? numberRange(String? value, {int min = 0, int max = 120}) {
    if (value == null || value.isEmpty) {
      return 'Giá trị không được để trống';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'Giá trị phải là số';
    }
    if (number < min || number > max) {
      return 'Giá trị phải nằm trong khoảng $min–$max';
    }
    return null;
  }

  // Min length validator
  static String? minLength(String? value, int min, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? "Trường này"} không được để trống';
    }

    if (value.length < min) {
      return '${fieldName ?? "Trường này"} phải có ít nhất $min ký tự';
    }

    return null;
  }

  // Max length validator
  static String? maxLength(String? value, int max, {String? fieldName}) {
    if (value != null && value.length > max) {
      return '${fieldName ?? "Trường này"} không được vượt quá $max ký tự';
    }
    return null;
  }

  // Number validator
  static String? number(String? value) {
    if (value == null || value.isEmpty) {
      return 'Giá trị không được để trống';
    }

    if (double.tryParse(value) == null) {
      return 'Giá trị phải là số';
    }

    return null;
  }

  // URL validator
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL không được để trống';
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'URL không hợp lệ';
    }

    return null;
  }

  // Match validator (for confirm password)
  static String? match(String? value, String? matchValue, {String? fieldName}) {
    if (value != matchValue) {
      return '${fieldName ?? "Giá trị"} không khớp';
    }
    return null;
  }

  // Date validator
  static String? date(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ngày không được để trống';
    }

    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return 'Ngày không hợp lệ';
    }
  }

  // Combine multiple validators
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  // Image URL validator
  static String? imageUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ảnh không được để trống';
    }
    final imageRegex = RegExp(
      r'^(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png|jpeg)$',
    );
    if (!imageRegex.hasMatch(value)) {
      return 'Đường dẫn ảnh không hợp lệ';
    }
    return null;
  }

  // Regex validator
  static String? regex(String? value, RegExp pattern, String message) {
    if (value == null || value.isEmpty) return message;
    if (!pattern.hasMatch(value)) return message;
    return null;
  }
}
