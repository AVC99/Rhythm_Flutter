import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/core/theme/theme_cubit.dart';
import 'package:rhythm/src/widgets/texts/sliding_text.dart';

class UserCard extends StatefulWidget {
  final Widget action;

  const UserCard({
    Key? key,
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
         child: Image.network(
           'https://i.scdn.co/image/ab67616d0000b27330326b23e30ae93d4d48165b',
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
                  constraints:
                      BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2.5),
                  child: const SlidingText(child: Text('Username'),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/3),
                      child: const  SlidingText(child: Text('City, Country'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return widget.action;
  }
}

