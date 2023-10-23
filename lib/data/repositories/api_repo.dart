import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:ask_chatgpt/data/models/chatgpt_model.dart';
import 'package:ask_chatgpt/data/models/custom_error.dart';
import 'package:ask_chatgpt/presentation/constants/api_urls.dart';
import 'package:logger/logger.dart';

class APIRepository {
  static Future<List<ChatGPTModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse(APIUrls.modelUrl), headers: {
        'Authorization': 'Bearer ${dotenv.env['API_KEY']}',
      });

      Map jsonResponse = json.decode(response.body);
      if (jsonResponse['error'] != null) {
        throw http.ClientException(jsonResponse['error']['message']);
      }
      List models = [];
      for (var value in jsonResponse['data']) {
        models.add(value);
      }

      final logger = Logger();
      logger.i(jsonResponse['id']);
      logger.i(models);

      return ChatGPTModel.toModelList(models);
    } on CustomError catch (e) {
      throw CustomError(
          errorMessage: e.errorMessage, code: e.code, plugin: e.plugin);
    }
  }
}
