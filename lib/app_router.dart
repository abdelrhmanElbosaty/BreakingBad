
import 'package:breaking_bad_bloc/bussiness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_bloc/data/repository/characters_repository.dart';
import 'package:breaking_bad_bloc/data/web_services/characters_web_services.dart';
import 'package:breaking_bad_bloc/presentation/scenes/characters_screen.dart';
import 'package:breaking_bad_bloc/presentation/scenes/characters_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'consts/strings.dart';
import 'data/model/character.dart';

class AppRouter {

  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
   switch (settings.name) {
     case charactersScene:
       return MaterialPageRoute(
           builder: (context) => BlocProvider(
             create: (context) => charactersCubit,
             child: CharactersScreen(),
           ),
       );

     case charactersDetailsScene:
       final character = settings.arguments as Character;
       return MaterialPageRoute(builder: (context) => CharactersDetailsScreen(character: character));
   }
  }
}