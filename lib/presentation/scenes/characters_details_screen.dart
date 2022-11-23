import 'dart:math';

import 'package:breaking_bad_bloc/bussiness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_bloc/bussiness_logic/cubit/characters_state.dart';
import 'package:breaking_bad_bloc/consts/colors/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/character.dart';
import '../widgets/widgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.charName);

    return Scaffold(
      backgroundColor: MyColors.thirdColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  color: MyColors.thirdColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildCharacterInfo('Job: ', character.jobs.join(' / ')),
                      buildDivider(MediaQuery.of(context).size.width -
                          ('jobs:r'.length + 8 + 28 + 24)),
                      buildCharacterInfo(
                          'Appeared in: ', character.appearance.join(' / ')),
                      buildDivider(MediaQuery.of(context).size.width -
                          ('Appeared in:r'.length + 8 + 28 + 24)),
                      buildCharacterInfo(
                          'Seasons: ', character.appearance.join(' / ')),
                      buildDivider(MediaQuery.of(context).size.width -
                          ('Seasons:r'.length + 8 + 28 + 24)),
                      buildCharacterInfo('Status: ', character.liveOrDead),
                      buildDivider(MediaQuery.of(context).size.width -
                          ('Status:r'.length + 8 + 28 + 24)),
                      character.betterCallSoulAppearance.isNotEmpty
                          ? buildCharacterInfo('Better Call Saul Seasons: ',
                              character.betterCallSoulAppearance.join(' / '))
                          : const SizedBox(),
                      character.betterCallSoulAppearance.isNotEmpty
                          ? buildDivider(MediaQuery.of(context).size.width -
                              ('Better Call Saul Seasons:r'.length +
                                  8 +
                                  28 +
                                  24))
                          : const SizedBox(),
                      buildCharacterInfo('Actor: ', character.charActualName),
                      buildDivider(MediaQuery.of(context).size.width -
                          ('Actor:r'.length + 8 + 28 + 24)),
                      const SizedBox(height: 25),
                      buildBlockBuilder(),
                    ],
                  ),
                ),
                const SizedBox(height: 500),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500,
      stretch: true,
      pinned: true,
      backgroundColor: MyColors.thirdColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname,
          style: const TextStyle(color: MyColors.secondaryColor),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildCharacterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
              color: MyColors.secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(color: MyColors.secondaryColor, fontSize: 14),
        ),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      endIndent: endIndent,
      height: 30,
      color: MyColors.primaryColor,
    );
  }

  Widget buildBlockBuilder() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is QuotesLoaded) {
          return buildQuoteWidgetOrEmptyContainer(state);
        } else {
          return buildLoadingProgressWidget();
        }
      },
    );
  }

  Widget buildQuoteWidgetOrEmptyContainer(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      var randomIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: MyColors.primaryColor,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
