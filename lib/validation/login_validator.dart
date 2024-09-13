class LoginValidator {
  // Custom validator for studentId
  static String? validateStudentId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mã số sinh viên';
    }
    final studentIdRegex = RegExp(r'^\d+$');
    if (!studentIdRegex.hasMatch(value)) {
      return 'Mã số sinh viên không hợp lệ';
    }
    return null;
  }

  // Custom validator for password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    return null;
  }
}
