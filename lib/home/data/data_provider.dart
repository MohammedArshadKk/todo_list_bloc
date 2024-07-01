import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiServices {
  Future<void> postData(String? title, String? subtitle) async {
    const postUrl = 'https://api.nstack.in/v1/todos';
    try {
      if (title != null && subtitle != null) {
        final res = await http.post(
          Uri.parse(postUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
              {'title': title, 'description': subtitle, 'is_completed': false}),
        );
        if (res.statusCode >= 200 && res.statusCode < 300) {
          log('added');
          log(res.body);
        }
      }
    } catch (e) {
      log('error');
    }
  }

  Future getData() async {
    const getUrl = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    try {
      final res = await http.get(Uri.parse(getUrl));
      if (res.statusCode == 200) {
        final decodedData = jsonDecode(res.body)['items'] as List;
        // log(decodedData.toString());
        return decodedData;
      }
    } catch (e) {
      log('error geting data$e');
    }
  }
  Future<void> delete(String id ) async{
    final uri='https://api.nstack.in/v1/todos/$id';
    final response=await http.delete(Uri.parse(uri));
    log(response.statusCode.toString());
    if (response.statusCode==200) {
      log('deleted');
    }else{
      log('error');
    }
  }


editData(String title ,String description ,String id)async{
  final editUrl='https://api.nstack.in/v1/todos/$id';
    final body={
      'title':title,
      'description':description,
      'is_completed':false
    };
    try {
      final response=await http.put(Uri.parse(editUrl) ,
      
      headers: {
        'Content-Type': 'application/json',
      },
       body: jsonEncode(body));
      log(response.statusCode.toString()); 
      if (response.statusCode==200) {
        log('Edited');
      }else{
        throw Exception('Failed to put todo');
      }
    } catch (e) {  
      throw Exception('Failed to put todo');
    }
  }
}
