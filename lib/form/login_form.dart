import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sgu_uni/models/auth/user.dart';
import 'package:sgu_uni/screen/home.dart';
import 'package:sgu_uni/services/api_service.dart';
import 'package:sgu_uni/utils/message_util.dart';
import 'package:sgu_uni/utils/shared_preferences_utils.dart';
import 'package:sgu_uni/validation/login_validator.dart';

import '../widget/label_text_field.dart';

class Loginform extends StatefulWidget {
  const Loginform({super.key});

  @override
  State<Loginform> createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  String credentialUserName = '';
  String credentialPassword = '';

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LabelTextField(
              labelText: "Tài khoản",
              controller: userNameController,
              validator: LoginValidator.validateStudentId,
            ),
            LabelTextField(
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
                      handleLogin();
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

  Future<void> handleLogin() async {
    context.loaderOverlay.show();

    final username = userNameController.text.trim();
    final password = passwordController.text.trim();

    // Tạo body dưới dạng Map
    final body = {
      'username': username,
      'password': password,
      'grant_type': 'password',
    };

    User loginResponse = User();

    try {
      // Gọi phương thức post từ ApiService và parse JSON sang kiểu User
      loginResponse = await apiService.post<User>(
        'auth/login',
        User.fromJson,
        urlEncodedBody: body, // Gửi body dưới dạng chuỗi đã được encode url
        headers: {
          'ua': await SharedPreferencesUtils.getString('ua'),
          'idpc': '0',
          'Accept': 'application/json, text/plain, */*',
        },
      );

      await SharedPreferencesUtils.setObject('currentUser', loginResponse);

      if (mounted) {
        // lưu thông tin đăng nhập
        saveUser(username, password);

        context.loaderOverlay.hide();
        // Điều hướng đến màn hình chính hoặc xử lý thành công ở đây
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      }
    } catch (error) {
      print('Error during login: $error');
      if (mounted) {
        context.loaderOverlay.hide();
        MessageUtil.toast(loginResponse.message!);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadLoginCredential();
  }

  Future<void> loadLoginCredential() async {
    final credentials = await Future.wait([
      SharedPreferencesUtils.getString('username'),
      SharedPreferencesUtils.getString('password'),
    ]);

    setState(() {
      userNameController.text = credentials[0]; // username
      passwordController.text = credentials[1]; // password
    });
  }

  Future<void> saveUser(String userName, String password) async {
    await SharedPreferencesUtils.setString('username', userName);
    await SharedPreferencesUtils.setString('password', password);
  }
}
