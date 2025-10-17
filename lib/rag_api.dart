import 'package:http/http.dart' as http;
import 'dart:convert';


class RagApi{

  static Future<String> rag_response({required String question}) async{

  final Url = Uri.parse("https://mernakabass-tourism-chatbot-api.hf.space/query");
  final body = jsonEncode({"question": "${question}"});
  final headers = {'accept': 'application/json','Content-Type': 'application/json'};

    final result = await http.post(Url,headers:headers,body:body );

    if (result.statusCode == 200) {
      final data = jsonDecode(result.body);
      return data["answer"];
    }

    else {return "No response generated";}
  }


  
  static Future<bool> hasInternet() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com')).timeout(const Duration(seconds: 5));
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }




}