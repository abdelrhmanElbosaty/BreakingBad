import 'package:breaking_bad_bloc/bussiness_logic/cubit/characters_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/character.dart';
import '../../data/repository/characters_repository.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getCharacters() {
    charactersRepository.getAllCharacters().then(
      (characters) {
        emit(CharactersLoaded(characters));
        this.characters = characters;
      },
    );
    return characters;
  }

  void getQuotes(String name) {
    charactersRepository.getQuotes(name).then(
      (quotes) {
        emit(QuotesLoaded(quotes));
      },
    );
  }
}
