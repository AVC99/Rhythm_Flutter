import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rhythm/src/models/display_info.dart';
import 'package:rhythm/src/providers/spotify_provider.dart';
import 'package:rhythm/src/widgets/cards/song_card.dart';
import 'package:rhythm/src/widgets/inputs/input_text_field.dart';

class TrackSelectorView extends StatefulHookConsumerWidget {
  final File imageFile;

  const TrackSelectorView({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  @override
  ConsumerState<TrackSelectorView> createState() => _TrackSelectorViewState();
}

class _TrackSelectorViewState extends ConsumerState<TrackSelectorView> {
  final TextEditingController _searchController = TextEditingController();
  List<DisplayInfo> _searchTracks = [];
  late AudioPlayer _audioPlayer;
  late int indexPlaying = -1;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputTextField(
                    controller: _searchController,
                    width: MediaQuery.of(context).size.width / 1.25,
                    hint: AppLocalizations.of(context)!.searchSongs,
                    icon: const Icon(Icons.search),
                    isPasswordField: false,
                    onChanged: (value) async {
                      _searchTracks.clear();
                      _searchController.text = value!;

                      if (value.isNotEmpty) {
                        _searchTracks = await ref
                            .read(spotifyRepositoryProvider)
                            .searchTracks(_searchController.text);
                      }

                      setState(() {});
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (indexPlaying == index) {
                          _audioPlayer.stop();
                          setState(() {
                            indexPlaying = -1;
                          });
                        } else {
                          _audioPlayer.play(UrlSource(_searchTracks[index].previewUrl!));
                          setState(() {
                            indexPlaying = index;
                          });
                        }
                      },
                      child: SongCard(
                        imageUrl: _searchTracks[index].url,
                        songName: _searchTracks[index].text,
                        artistName: _searchTracks[index].artist!,
                        isPlaying: index == indexPlaying ? true : false,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 12,
                  ),
                  itemCount: _searchTracks.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildUploadPostButton(context),
    );
  }

  Widget _buildUploadPostButton(BuildContext context) {
    return FloatingActionButton(
      tooltip: AppLocalizations.of(context)!.uploadPost,
      onPressed: () {},
      child: const Icon(Icons.upload),
    );
  }
}
