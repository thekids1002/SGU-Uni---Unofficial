import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screen/login.dart';
import 'utils/shared_preferences_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Gọi API khi hiển thị SplashScreen
    _fetchDataAndNavigate();
  }

  Future<void> _fetchDataAndNavigate() async {
    try {
      // Gọi API giả định, thay thế bằng URL API thật của bạn
      final response = await http
          .get(Uri.parse('https://tkb.huukhuongit.com/login-credential.php'));

      if (response.statusCode == 200) {
        // Parse dữ liệu JSON trả về
        var data = jsonDecode(response.body);
        print('Data from API: $data');

        // Lưu trường 'ua' vào SharedPreferences nếu tồn tại
        String? ua = data['ua'];
        if (ua != null) {
          await SharedPreferencesUtils.setString('ua', ua);
          print('UA saved: $ua');
        }

        // Chờ 3 giây và điều hướng đến màn hình Login
        Timer(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        });
      } else {
        print('Failed to load data');
        navigateToLogin();
      }
    } catch (e) {
      print('Error: $e');
      navigateToLogin();
    }
  }

  void navigateToLogin() {
    // Điều hướng đến màn hình Login ngay nếu có lỗi
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset('assets/splash.png'),
        ), // Splash screen image
      ),
    );
  }
}
