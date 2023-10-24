import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/exports/models_exports.dart';
import 'package:ask_chatgpt/presentation/constants/api_urls.dart';
import 'package:logger/logger.dart';

class APIRepository {
  // fetch OpenAIModels
  Future<List<OpenAIModel>> getModels() async {
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

      return OpenAIModel.toModelList(models);
    } on CustomError catch (e) {
      throw CustomError(
          errorMessage: e.errorMessage, code: e.code, plugin: e.plugin);
    }
  }

  // fetch OpenAICompletion
  Future<OpenAICompletion> getCompletion({
    required String text,
    required OpenAIModel model,
  }) async {
    try {
      var response =
          await http.post(Uri.parse(APIUrls.completionUrl), headers: {
        'Authorization': 'Bearer ${dotenv.env['API_KEY']}',
        'Content-Type': "application/json",
      }, body: {
        "model": model.id,
        "prompt": text,
        "max_tokens": 100,
        "temperature": 0
      });
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['error'] != null) {
        throw http.ClientException(jsonResponse['error']['message']);
      }

      final logger = Logger();
      logger.i(jsonResponse);

      return OpenAICompletion.fromJson(jsonResponse);
    } on CustomError catch (e) {
      throw CustomError(
          errorMessage: e.errorMessage, code: e.code, plugin: e.plugin);
    }
  }
}
