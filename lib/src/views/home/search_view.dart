import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/src/controllers/firestore/users_controller.dart';

import 'package:rhythm/src/models/rhythm_user.dart';
import 'package:rhythm/src/widgets/buttons/squared_icon_button.dart';
import 'package:rhythm/src/widgets/cards/user_card.dart';
import 'package:rhythm/src/widgets/inputs/input_text_field.dart';

class SearchView extends StatefulHookConsumerWidget {
  final RhythmUser authenticatedUser;

  const SearchView({
    Key? key,
    required this.authenticatedUser,
  }) : super(key: key);

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  List<RhythmUser> _searchUsers = [];
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
                onChanged: (value) async {
                  _searchUsers.clear();
                  _searchController.text = value!;

                  if (value.isNotEmpty) {
                    _searchUsers = await ref
                        .read(usersControllerProvider.notifier)
                        .searchUsersByUsername(
                          widget.authenticatedUser.username!,
                          _searchController.text,
                        );
                  }

                  setState(() {});
                },
              ),
              SquaredIconButton(
                icon: const Icon(Icons.qr_code),
                width: MediaQuery.of(context).size.width / 15,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          Expanded(
            child: _searchUsers.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context)!.noResults),
                  )
                : ListView.separated(
                    itemCount: _searchUsers.length,
                    itemBuilder: (context, index) => UserCard(
                      user: _searchUsers[index],
                      action: IconButton(
                        icon: const Icon(Icons.person_add),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
