import 'package:breaking_bad_bloc/consts/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      print(response.data.toString());
      return response.data;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Future<List<dynamic>> getQuotes(String name) async {
    try {
      Response response =
          await dio.get('quote', queryParameters: {'author': name});
      print(response.data.toString());
      return response.data;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}
