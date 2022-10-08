import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/brand.dart';

class BrandService {
  static const geBrandsUrl = 'https://localhost:8080/api/v1/brand';

  static Future<List<Brand>> getBrands() async {
    final response = await http.get(Uri.parse(geBrandsUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      List<Brand> brands =
          List<Brand>.from(jsonResponse.map((model) => Brand.fromJson(model)));
      return brands;
    } else {
      throw Exception('Failed to fetch brands');
    }
  }
}
