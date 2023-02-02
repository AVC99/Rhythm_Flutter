import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/src/core/resources/images.dart';
import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/models/rhythm_user.dart';
import 'package:rhythm/src/providers/post_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/widgets/cards/post_card.dart';
import 'package:rhythm/src/widgets/utils/svg_image.dart';

import '../../widgets/dialogs/widgets/loading_spinner.dart';

class PostView extends StatefulHookConsumerWidget {
  final RhythmUser user;

  const PostView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  ConsumerState<PostView> createState() => _PostViewState();
}

class _PostViewState extends ConsumerState<PostView> {
  late AudioPlayer _audioPlayer;
  late int indexPlaying = -1;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.release();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(postFeedProvider).when(
          data: (data) {
            if (data.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgImage(
                      svg: kAddFriendsIllustration,
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    const SizedBox(height: 32.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        AppLocalizations.of(context)!.noPostToDisplay,
                        style: kSectionTitle,
                      ),
                    ),
                  ],
                ),
              );
            }
            return PageView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  if (indexPlaying == index) {
                    _audioPlayer.stop();
                    setState(() {
                      indexPlaying = -1;
                    });
                  } else {
                    _audioPlayer.play(UrlSource(data[index].previewUrl));
                    setState(() {
                      indexPlaying = index;
                    });
                  }
                },
                child: PostCard(
                  post: data[index],
                  isPlaying: index == indexPlaying ? true : false,
                ),
              ),
              controller: PageController(),
              scrollDirection: Axis.vertical,
              itemCount: data.length,
            );
          },
          error: (error, stacktrace) => Text(error.toString()),
          loading: () => const LoadingSpinner(),
        );
  }
}
