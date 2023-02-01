import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rhythm/src/controllers/storage/storage_controller.dart';
import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/models/display_info.dart';
import 'package:rhythm/src/models/post.dart';
import 'package:rhythm/src/models/rhythm_user.dart';
import 'package:rhythm/src/providers/spotify_provider.dart';
import 'package:rhythm/src/widgets/cards/song_card.dart';
import 'package:rhythm/src/widgets/dialogs/dialog_helper.dart';
import 'package:rhythm/src/widgets/dialogs/widgets/popup_dialog.dart';
import 'package:rhythm/src/widgets/inputs/input_text_field.dart';

import '../../providers/post_provider.dart';

class TrackSelectorView extends StatefulHookConsumerWidget {
  final File imageFile;
  final RhythmUser user;

  const TrackSelectorView({
    Key? key,
    required this.imageFile,
    required this.user,
  }) : super(key: key);

  @override
  ConsumerState<TrackSelectorView> createState() => _TrackSelectorViewState();
}

class _TrackSelectorViewState extends ConsumerState<TrackSelectorView> {
  final TextEditingController _searchController = TextEditingController();
  List<DisplayInfo> _searchTracks = [];
  late AudioPlayer _audioPlayer;
  late int indexPlaying = -1;
  late int selectedIndex = -1;
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
    _audioPlayer.release();
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
                      selectedIndex = -1;
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
                    return index == selectedIndex
                        ? _buildTrackCard(context, index, true)
                        : _buildTrackCard(context, index, false);
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

  Widget _buildTrackCard(BuildContext context, int index, bool isSelected) {
    return Container(
      //padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(17.0)),
        border: Border.all(
            color: isSelected ? kSkyBlue : Colors.transparent, width: 2.0),
      ),
      child: GestureDetector(
        onTap: () {
          if (indexPlaying == index) {
            _audioPlayer.stop();
            setState(() {
              indexPlaying = -1;
            });
          } else {
            _audioPlayer.play(UrlSource(_searchTracks[index].previewUrl!));
            setState(() {
              selectedIndex = index;
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
      ),
    );
  }

  Widget _buildUploadPostButton(BuildContext context) {
    return FloatingActionButton(
      tooltip: AppLocalizations.of(context)!.uploadPost,
      onPressed: () async {
        if (selectedIndex != -1) {
          final imageUrl = await ref
              .read(storageControllerProvider.notifier)
              .uploadPost(widget.imageFile, widget.user.username!);

          ref.read(postRepositoryProvider).createPost(
                Post(
                  username: widget.user.username!,
                 songName: _searchTracks[selectedIndex].text,
                  artist: _searchTracks[selectedIndex].artist!,
                  userImageUrl: widget.user.imageUrl!,
                  postImageUrl: imageUrl!,
                  previewUrl: _searchTracks[selectedIndex].previewUrl!,
                  coverUrl: _searchTracks[selectedIndex].url,
                  creationDate: DateTime.now(),
                ),
              );
          if(!mounted)return;
          Navigator.pop(context);
        } else {
          final messageDialog = DialogHelper(
            child: PopupDialog(
              title: AppLocalizations.of(context)!.uploadPost,
              description: AppLocalizations.of(context)!.missingSelectedSong,
              onAccept: () {
                Navigator.pop(context);
              },
            ),
            canBeDismissed: true,
          );
          messageDialog.displayDialog(context);
        }
      },
      child: const Icon(Icons.upload),
    );
  }
}
