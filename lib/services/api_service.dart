import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sgu_uni/utils/message_util.dart';

class ApiService {
  final String baseUrl = "https://thongtindaotao.sgu.edu.vn/api/";
  final String? accessToken;

  ApiService({this.accessToken});

  Future<T> post<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? urlEncodedBody,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    // Chọn cách gửi body dựa trên dữ liệu có
    final requestBody = urlEncodedBody != null
        ? encodeToUrlEncoded(urlEncodedBody)
        : jsonEncode(body);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': urlEncodedBody != null
            ? 'application/x-www-form-urlencoded'
            : 'application/json',
        ...?headers,
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      },
      body: requestBody,
    );

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return fromJson(jsonResponse);
    } else {
      // Kiểm tra nếu response body có chứa message và hiển thị thông báo
      try {
        final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
        if (errorResponse.containsKey('message')) {
          MessageUtil.toast(errorResponse['message']);
        } else {
          MessageUtil.toast('Unknown error occurred');
        }
      } catch (e) {
        // Trong trường hợp response không phải JSON hoặc lỗi không xác định
        MessageUtil.toast('Failed to parse error response');
      }

      throw Exception(
          'Failed to load data with status code: ${response.statusCode}');
    }
  }

  String encodeToUrlEncoded(Map<String, dynamic> body) {
    return body.entries
        .map((entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');
  }
}
