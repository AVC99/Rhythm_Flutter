import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/core/resources/images.dart';
import 'package:rhythm/src/core/theme/theme_cubit.dart';
import 'package:rhythm/src/models/display_info.dart';
import 'package:rhythm/src/models/post.dart';
import 'package:rhythm/src/widgets/texts/sliding_text.dart';

class PostCard extends StatefulWidget {
  final Post post;
  late bool? isPlaying = false;

  PostCard({
    Key? key,
    required this.post,
    this.isPlaying,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool? isPlayVisible = widget.isPlaying;
  late bool? isPauseVisible = widget.isPlaying;

  Color _getThemeColor(String mode) {
    return mode == ThemeMode.light.name ? kGrey : kBrokenWhite;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
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
      },
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: widget.post.userImageUrl.isEmpty
                ? const AssetImage(kDefaultImageProfile)
                : NetworkImage(widget.post.userImageUrl) as ImageProvider,
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
                    widget.post.username,
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
                    child: SlidingText(
                        child: Text(
                            '${widget.post.songName} · ${widget.post.artist}')),
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
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.zero,
                bottom: Radius.circular(32.0),
              ),
              image: DecorationImage(
                image: NetworkImage(widget.post.postImageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: Image.network(
                    widget.post.coverUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedOpacity(
                      opacity: widget.isPlaying! ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: const Icon(
                        Icons.pause,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedOpacity(
                      opacity: widget.isPlaying! ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: const Icon(
                        Icons.play_arrow,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*   Positioned(
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
          ),*/
        ],
      ),
    );
  }
}
