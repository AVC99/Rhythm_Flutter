import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/core/theme/theme_cubit.dart';
import 'package:rhythm/src/widgets/texts/sliding_text.dart';

class SongCard extends StatefulWidget {
  final String imageUrl;
  final String songName;
  final String artistName;
  bool? isPlaying;

  SongCard({
    Key? key,
    required this.imageUrl,
    required this.songName,
    required this.artistName,
    this.isPlaying = false,
  }) : super(key: key);

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  Color _getThemeColor(String mode) {
    return mode == ThemeMode.light.name ? Colors.black12 : kBrokenWhite;
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
              _buildAlbumCover(context),
              _buildTrackInformation(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrackInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.music_note,
                      color: kViolet,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 2.5,
                      ),
                      child: SlidingText(
                        child: Text(
                          widget.songName,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.mic_rounded,
                      color: kViolet,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 2.5,
                      ),
                      child: SlidingText(
                        child: Text(
                          widget.artistName,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          //_buildLikeButton(context),
        ],
      ),
    );
  }

  Widget _buildAlbumCover(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Image.network(
              widget.imageUrl,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: widget.isPlaying! ? 0.75 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.pause,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: widget.isPlaying! ? 0.0 : 0.75,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
