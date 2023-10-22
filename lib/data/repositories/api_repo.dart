import 'package:ask_chatgpt/data/models/custom_error.dart';
import 'package:ask_chatgpt/presentation/constants/api_urls.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class APIRepository {
  Future<void> getModel() async {
    try {
      http.get(Uri.parse(APIUrls.modelUrl), headers: {
        'Authorization': '${dotenv.env['API_KEY']}',
      }).whenComplete(() => null);
    } on CustomError catch (e) {
      throw CustomError(
          errorMessage: e.errorMessage, code: e.code, plugin: e.plugin);
    }
  }
}
