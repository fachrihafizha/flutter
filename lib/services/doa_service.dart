import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/doa_model.dart';

class DoaService {
  static const String _baseUrl = 'https://doa-doa-api-ahmadramadhan.fly.dev/api';

  static Future<List<DoaModel>> fetchDoa() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => DoaModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data doa');
    }
  }
}
