import 'package:breaking_bad_bloc/data/model/Quote.dart';
import 'package:breaking_bad_bloc/data/web_services/characters_web_services.dart';
import '../model/character.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getQuotes(String name) async {
    final quotes = await charactersWebServices.getQuotes(name);
    return quotes.map((quotes) => Quote.fromJson(quotes)).toList();
  }
}
