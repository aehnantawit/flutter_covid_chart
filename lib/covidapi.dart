import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_covid_chart/model/newinfect.dart';

class CovidAPI {

  static Future<List<NewInfect>> getAll() async {
    
    final response = await http.get('https://covid19.th-stat.com/api/open/timeline');

    if (response.statusCode == 200) {
      
      final _data = json.decode(response.body)['Data'].cast<Map<String, dynamic>>();
      List<NewInfect> _list = _data.map<NewInfect>((json) => NewInfect.fromJson(json)).toList();
      _list = _list.reversed.toList();
      _list = _list.getRange(0, 10).toList();
      return _list.reversed.toList();

    } else {
      throw Exception('Failed to load album');
    }   
  }
}
