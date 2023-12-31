import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/exports/models_exports.dart';
import 'package:ask_chatgpt/presentation/constants/api_urls.dart';
import 'package:logger/logger.dart';

class APIRepository {
  // fetch OpenAIModels
  Future<List<OpenAIModel>> getModels() async {
    const storage = FlutterSecureStorage();
    String? apiKey = await storage.read(key: 'API_KEY');

    try {
      var response = await http.get(Uri.parse(APIUrls.modelUrl), headers: {
        'Authorization': 'Bearer $apiKey',
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
      logger.i(models);

      return OpenAIModel.toModelList(models);
    } on CustomError catch (e) {
      throw CustomError(
          errorMessage: e.errorMessage, code: e.code, plugin: e.plugin);
    }
  }

  // fetch OpenAICompletion
  static Future<List<OpenAICompletion>> getCompletion({
    required String text,
    required String model,
  }) async {
    final logger = Logger();
    logger.i('text:$text, model: $model');

    const storage = FlutterSecureStorage();
    String? apiKey = await storage.read(key: 'API_KEY');

    try {
      var response = await http.post(
        Uri.parse(APIUrls.completionUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": model,
          "prompt": text,
          "max_tokens": 1000,
          "temperature": 0
        }),
      );
      Map jsonResponse = json.decode(response.body);

      if (jsonResponse['error'] != null) {
        throw http.ClientException(jsonResponse['error']['message']);
      }

      List<OpenAICompletion> completions = [];

      if (jsonResponse['choices'].length > 0) {
        completions = List.generate(
          jsonResponse['choices'].length,
          (index) => OpenAICompletion(
            id: jsonResponse['id'],
            text: jsonResponse['choices'][index]['text'],
          ),
        ).toList();

        logger.i('RESPONSE: ${jsonResponse['choices'][0]['text']}');
      }
      return completions;
    } on CustomError catch (e) {
      logger.e(e.errorMessage);
      throw CustomError(
          errorMessage: e.errorMessage, code: e.code, plugin: e.plugin);
    }
  }

  // fetch OpenAIChat
  static Future<List<OpenAICompletion>> getChat({
    required String text,
    required String model,
  }) async {
    final logger = Logger();
    logger.i('text:$text, model: $model');

    const storage = FlutterSecureStorage();
    String? apiKey = await storage.read(key: 'API_KEY');

    try {
      var response = await http.post(
        Uri.parse(APIUrls.chatUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": model,
          "messages": [
            {"role": "user", "content": text}
          ],
          "max_tokens": 1000,
        }),
      );

      Map jsonResponse = json.decode(response.body);
      if (jsonResponse['error'] != null) {
        throw http.ClientException(jsonResponse['error']['message']);
      }

      List<OpenAICompletion> completions = [];

      if (jsonResponse['choices'].length > 0) {
        completions = List.generate(
          jsonResponse['choices'].length,
          (index) => OpenAICompletion(
            id: jsonResponse['id'],
            text: jsonResponse['choices'][index]['message']['content'],
          ),
        ).toList();

        logger
            .i('RESPONSE: ${jsonResponse['choices'][0]['message']['content']}');
      }
      return completions;
    } on CustomError catch (e) {
      logger.e(e.errorMessage);

      throw CustomError(
          errorMessage: e.errorMessage, code: e.code, plugin: e.plugin);
    }
  }
}
