import 'dart:convert';
import 'package:flutter/services.dart';

class DatabaseService {
  static Future<Map<String, dynamic>> loadDatabase() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/database.json');
    return json.decode(jsonString);
  }
}
