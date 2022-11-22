import 'package:breaking_bad_bloc/bussiness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_bloc/bussiness_logic/cubit/characters_state.dart';
import 'package:breaking_bad_bloc/consts/colors/my_colors.dart';
import 'package:breaking_bad_bloc/consts/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/character.dart';

class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedCharacters;
  var searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: isSearching ? buildSearchTextField() : buildNormalAppBar(),
        leading: isSearching
            ? IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_outlined,
              color: MyColors.secondaryColor),
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        )
            : Container(),
        actions: buildAppBarActions(),
      ),
      body: buildCubitBuilder(),
    );
  }

  Widget buildNormalAppBar() {
    return const Text('Characters',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: MyColors.secondaryColor,
        ));
  }

  Widget buildSearchTextField() {
    return TextFormField(
      controller: searchController,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        hintText: 'Find a character.....',
        hintStyle: TextStyle(
          color: MyColors.secondaryColor,
        ),
        border: InputBorder.none,
      ),
      style: const TextStyle(
        color: MyColors.secondaryColor,
      ),
      onChanged: (char) {
        searchWithChar(char);
      },
    );
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.secondaryColor,
          ),
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            startSearch();
          },
          icon: const Icon(
            Icons.search,
            color: MyColors.secondaryColor,
          ),
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ];
    }
  }

  void searchWithChar(String char) {
    searchedCharacters = allCharacters
        .where((character) => character.charName.toLowerCase().startsWith(char))
        .toList();
    setState(() {
      isSearching = true;
    });
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: () => stopSearch()));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  Widget buildCubitBuilder() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidget();
        } else {
          return buildLoadingProgressWidget();
        }
      },
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.secondaryColor,
        child: Column(
          children: [
            buildCharactersGridWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersGridWidget() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: 2 / 3,
      ),
      padding: EdgeInsets.zero,
      itemCount: searchController.text.isNotEmpty
          ? searchedCharacters.length
          : allCharacters.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return buildGridViewCharacterItem(searchController.text.isNotEmpty
            ? searchedCharacters[index]
            : allCharacters[index]);
      },
    );
  }

  Widget buildGridViewCharacterItem(Character character) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.thirdColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactersDetailsScene, arguments: character),
        child: GridTile(
          footer: Hero(
            tag: character.id,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.charName,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.secondaryColor,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: character.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/loadingImage.gif',
                    image: character.image)
                : Image.asset('assets/images/placeHolderImage.png'),
          ),
        ),
      ),
    );
  }

  Widget buildLoadingProgressWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.yellowAccent,
      ),
    );
  }
}
