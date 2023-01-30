import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rhythm/src/models/rhythm_user.dart';

import 'package:rhythm/src/widgets/buttons/squared_icon_button.dart';
import '../../widgets/cards/user_card.dart';
import '../../widgets/inputs/input_text_field.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InputTextField(
                controller: _searchController,
                width: MediaQuery.of(context).size.width / 1.35,
                hint: AppLocalizations.of(context)!.searchFriend,
                icon: const Icon(Icons.search),
                isPasswordField: false,
              ),
              SquaredIconButton(
                icon: const Icon(Icons.search),
                width: MediaQuery.of(context).size.width / 15,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => UserCard(
                user: RhythmUser.empty(),
                action: IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: () {},
                ),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
