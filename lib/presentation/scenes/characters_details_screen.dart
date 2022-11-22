import 'package:breaking_bad_bloc/consts/colors/my_colors.dart';
import 'package:flutter/material.dart';
import '../../data/model/character.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.thirdColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                color: MyColors.thirdColor,
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildCharacterInfo('Job: ', character.jobs.join(' / ')),
                    buildDivider(MediaQuery.of(context).size.width-('jobs:r'.length + 8 + 28 + 24)),
                  ]
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500,
      stretch: true,
      pinned: true,
      backgroundColor: MyColors.secondaryColor,
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
}
