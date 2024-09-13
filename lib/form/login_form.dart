import 'package:flutter/material.dart';
import 'package:sgu_uni/models/auth/user.dart';
import 'package:sgu_uni/screen/home.dart';
import 'package:sgu_uni/services/api_service.dart';
import 'package:sgu_uni/utils/shared_preferences_utils.dart';
import 'package:sgu_uni/validation/login_validator.dart';
import '../widget/lablet_ext_field.dart';

class Loginform extends StatefulWidget {
  const Loginform({super.key});

  @override
  State<Loginform> createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LabeledTextField(
              labelText: "Tài khoản",
              controller: userNameController,
              validator: LoginValidator.validateStudentId,
            ),
            LabeledTextField(
              labelText: "Mật khẩu",
              controller: passwordController,
              obscureText: true,
              validator: LoginValidator.validatePassword,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: const Text('Đăng Nhập'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final ApiService apiService = ApiService();
  Future<void> _login() async {
    final username = userNameController.text.trim();
    final password = passwordController.text.trim();

    // Tạo body dưới dạng Map
    final body = {
      'username': username,
      'password': password,
      'grant_type': 'password',
    };

    // Chuyển body thành x-www-form-urlencoded
    final encodedBody = body.entries
        .map((entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}')
        .join('&');

    try {
      // Gọi phương thức post từ ApiService và parse JSON sang kiểu User
      final loginResponse = await apiService.post<User>(
        'auth/login',
        User.fromJson,
        urlEncodedBody: encodedBody, // Gửi body dưới dạng chuỗi đã được encode
        headers: {
          'ua': await SharedPreferencesUtils.getString('ua'),
          'idpc': '0',
          'Accept': 'application/json, text/plain, */*',
        },
      );
      await SharedPreferencesUtils.setObject('currentUser', loginResponse);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
      // Điều hướng đến màn hình chính hoặc xử lý thành công ở đây
    } catch (error) {
      print('Error during login: $error');
    }
  }
}
