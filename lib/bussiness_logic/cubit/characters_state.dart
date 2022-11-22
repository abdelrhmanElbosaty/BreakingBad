
import 'package:breaking_bad_bloc/data/model/character.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {

  final List<Character> characters;

  CharactersLoaded(this.characters);
}
