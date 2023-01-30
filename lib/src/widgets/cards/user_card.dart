import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/core/resources/images.dart';
import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/core/theme/theme_cubit.dart';
import 'package:rhythm/src/models/rhythm_user.dart';
import 'package:rhythm/src/widgets/texts/sliding_text.dart';

class UserCard extends StatefulWidget {
  final RhythmUser user;
  final Widget action;

  const UserCard({
    Key? key,
    required this.user,
    required this.action,
  }) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  Color _getThemeColor(String mode) {
    return mode == ThemeMode.light.name ? kGrey : kBrokenWhite;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            color: _getThemeColor(state.themeMode.name),
          ),
          child: Row(
            children: [
              _buildUserProfile(context),
              _buildUserInformation(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: widget.user.imageUrl!.isNotEmpty
            ? Image.network(
                widget.user.imageUrl!,
                fit: BoxFit.cover,
              )
            : Image.asset(
                kDefaultImageProfile,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _buildUserInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 2.5,
                  ),
                  child: const SlidingText(
                    child: Text(
                      'Username',
                      style: kCardTitle,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.spotify,
                      size: 20.0,
                      color: kSpotifyGreen,
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 3,
                      ),
                      child: const SlidingText(
                        child: Text('Spotify ID'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            widget.action,
          ],
        ),
      ),
    );
  }
}
