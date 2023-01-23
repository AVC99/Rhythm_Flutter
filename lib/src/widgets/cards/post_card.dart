import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/widgets/texts/sliding_text.dart';

import '../../core/theme/theme_cubit.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final String songDetails = 'SongName - Artist';
  final String locationDetails = 'City, Country';
  final String userName = 'Username';
  final String userProfileImage =
      'https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  final String albumCover =
      'https://images.genius.com/0c3da2db33dfeb1f3a397ac17254728a.1000x1000x1.png';
  final String postImage = 'https://i.pinimg.com/originals/8f/76/5e/8f765eabe440a33eaa035bbba8ad9341.png';
  final String reactionImage =
      'https://i.pinimg.com/originals/8e/44/7c/8e447c70c2f1019d981e7871434d7a5f.jpg';
  bool _isPlaying = true;

  Color _getThemeColor(String mode) {
    return mode == ThemeMode.light.name ? kGrey : kBrokenWhite;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          color: _getThemeColor(state.themeMode.name),
          borderRadius: const BorderRadius.all(Radius.circular(32)),
        ),
        child: Column(
          children: [
            _buildUserInfo(context),
            _buildPostContent(context),
          ],
        ),
      );
    });
  }

  Widget _buildUserInfo(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(userProfileImage),
            radius: 32,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: SlidingText(
                  child: Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.music_note),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 2,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: SlidingText(child: Text(songDetails)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _pauseButton() {
    return const Icon(
      Icons.pause,
      size: 80,
    );
  }

  Widget _buildPostContent(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isPlaying = !_isPlaying;
          });
        },
        child: Stack(
          children: [
            Container(
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.zero,
                  bottom: Radius.circular(32.0),
                ),
                image: DecorationImage(image:  NetworkImage(postImage),
                fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height / 8,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                ),
                child: Image.network(albumCover,
                fit: BoxFit.fill,),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 15,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                  border: Border.all(width: 1.5),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(reactionImage),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 45,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                  border: Border.all(width: 1.5),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(reactionImage),
                ),
              ),
            ),
            Positioned(
              bottom: 1,
              right: 65,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.add_circle_rounded),
                  onPressed: () {},
                  iconSize: 50,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: _isPlaying ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: _pauseButton(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
