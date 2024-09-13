import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://thongtindaotao.sgu.edu.vn/api/";
  final String? accessToken;

  ApiService({this.accessToken});

  Future<T> post<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? body,
    String? urlEncodedBody,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    // Chọn cách gửi body dựa trên dữ liệu có
    final requestBody = urlEncodedBody ?? jsonEncode(body);

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

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
