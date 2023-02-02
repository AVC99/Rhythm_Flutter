import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/core/resources/images.dart';
import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/controllers/authentication/authentication_controller.dart';
import 'package:rhythm/src/controllers/firestore/firestore_state.dart';
import 'package:rhythm/src/controllers/firestore/friendships_controller.dart';
import 'package:rhythm/src/models/rhythm_user.dart';
import 'package:rhythm/src/providers/post_provider.dart';
import 'package:rhythm/src/providers/spotify_provider.dart';
import 'package:rhythm/src/providers/users_provider.dart';
import 'package:rhythm/src/repositories/friendships/friendships_error.dart';
import 'package:rhythm/src/views/onboarding/start_view.dart';
import 'package:rhythm/src/widgets/buttons/circular_icon_button.dart';
import 'package:rhythm/src/widgets/cards/user_card.dart';
import 'package:rhythm/src/widgets/dialogs/dialog_helper.dart';
import 'package:rhythm/src/widgets/dialogs/widgets/loading_spinner.dart';
import 'package:rhythm/src/widgets/dialogs/widgets/popup_dialog.dart';
import 'package:rhythm/src/widgets/images/image_holder.dart';
import 'package:rhythm/src/widgets/images/labeled_image_holder.dart';
import 'package:rhythm/src/widgets/inputs/input_text_field.dart';
import 'package:rhythm/src/widgets/cards/song_card.dart';
import 'package:rhythm/src/widgets/texts/sliding_text.dart';

class ProfileView extends StatefulHookConsumerWidget {
  final RhythmUser authenticatedUser;

  const ProfileView({
    Key? key,
    required this.authenticatedUser,
  }) : super(key: key);

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late AudioPlayer _audioPlayer;
  final TextEditingController _searchController = TextEditingController();
  late int indexPlaying = -1;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
    _audioPlayer.release();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<FirestoreQueryState>(
      friendshipsControllerProvider,
      (previousState, nextState) {
        const DialogHelper loadingDialog = DialogHelper(
          child: LoadingSpinner(),
          canBeDismissed: false,
        );

        switch (nextState.runtimeType) {
          case FirestoreQueryLoadingState:
            loadingDialog.displayDialog(context);
            break;

          case FirestoreQuerySuccessState:
            loadingDialog.dismissDialog(context);
            break;

          case FirestoreFriendshipsDataErrorState:
            loadingDialog.dismissDialog(context);

            final DialogHelper messageDialog = DialogHelper(
              child: PopupDialog(
                title: AppLocalizations.of(context)!.friendRequest,
                description: FriendshipDataErrorHandler.determineError(
                  context,
                  (nextState as FirestoreFriendshipsDataErrorState).error,
                ),
                onAccept: () {
                  Navigator.of(context).pop();
                },
              ),
              canBeDismissed: true,
            );

            messageDialog.displayDialog(context);
            break;

          case FirestoreQueryErrorState:
            loadingDialog.dismissDialog(context);

            final DialogHelper failureDialog = DialogHelper(
              child: PopupDialog(
                title: AppLocalizations.of(context)!.friendRequest,
                description:
                    AppLocalizations.of(context)!.friendRequestErrorOnSend,
                onAccept: () {
                  Navigator.of(context).pop();
                },
              ),
              canBeDismissed: true,
            );

            failureDialog.displayDialog(context);
            break;
        }
      },
    );

    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: _buildUserProfileImage(context),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TabBar(
                indicatorColor: kSkyBlue,
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.posts),
                  Tab(text: AppLocalizations.of(context)!.stats),
                  Tab(text: AppLocalizations.of(context)!.social),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    _buildPostsTab(context),
                    _buildStatsTab(context),
                    _buildSocialTab(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileImage(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          child: widget.authenticatedUser.imageUrl!.isNotEmpty
              ? Image.network(
                  widget.authenticatedUser.imageUrl!,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  kDefaultImageProfile,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: false,
                      child: CircularIconButton(
                        icon: const Icon(Icons.edit),
                        tooltip: AppLocalizations.of(context)!.edit,
                        onPressed: () {},
                      ),
                    ),
                    CircularIconButton(
                      icon: const Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        color: kSkyBlue,
                      ),
                      tooltip: AppLocalizations.of(context)!.settings,
                      onPressed: () async {
                        await ref.read(spotifyRepositoryProvider).signOut();

                        await ref
                            .read(authenticationControllerProvider.notifier)
                            .signOut();

                        if (!mounted) return;

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          StartView.route,
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.2,
                ),
                child: SlidingText(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      widget.authenticatedUser.username!,
                      style: kUsernameProfile,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPostsTab(BuildContext context) {
    return ref.watch(userPostProvider(widget.authenticatedUser.username!)).when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GridView.count(
                physics: const ClampingScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                crossAxisCount: 3,
                children: List.generate(
                  data.length,
                  (index) => Center(
                    child: ImageHolder(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      imageUrl: data[index].postImageUrl,
                    ),
                  ),
                ),
              ),
            );
          },
          error: (error, stacktrace) => Text(error.toString()),
          loading: () => const LoadingSpinner(),
        );
  }

  Widget _buildStatsTab(BuildContext context) {
    return ListView(
      children: [
        _buildPlaylist(context),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        _buildTopArtists(context),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        _buildTopTracks(context),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        // _buildTopGenres(context),
      ],
    );
  }

  Widget _buildPlaylist(BuildContext context) {
    return ref.watch(spotifyPlaylistProvider).when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Playlist',
                    style: kSectionTitle,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: LabeledImageHolder(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        url: data[index].url,
                        description: data[index].text,
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 12,
                    ),
                    itemCount: data.length,
                  ),
                ),
              ],
            );
          },
          error: (error, stacktrace) => Text(error.toString()),
          loading: () => const LoadingSpinner(),
        );
  }

  Widget _buildTopTracks(BuildContext context) {
    return ref.watch(spotifyTopSongsProvider).when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Top Songs',
                    style: kSectionTitle,
                  ),
                ),
                SizedBox(
                  child: ListView.separated(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
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
                            _audioPlayer
                                .play(UrlSource(data[index].previewUrl!));
                            setState(() {
                              indexPlaying = index;
                            });
                          }
                        },
                        child: SongCard(
                          imageUrl: data[index].url,
                          songName: data[index].text,
                          artistName: data[index].artist!,
                          isPlaying: index == indexPlaying ? true : false,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemCount: data.length,
                  ),
                )
              ],
            );
          },
          error: (error, stacktrace) => Text(error.toString()),
          loading: () => const LoadingSpinner(),
        );
  }

  Widget _buildTopArtists(BuildContext context) {
    return ref.watch(spotifyTopArtistProvider).when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.topArtists,
                    style: kSectionTitle,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: LabeledImageHolder(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        url: data[index].url,
                        description: data[index].text,
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 12,
                    ),
                    itemCount: data.length,
                  ),
                ),
              ],
            );
          },
          error: (error, stacktrace) {
            return Text(
              error.toString(),
            );
          },
          loading: () => const LoadingSpinner(),
        );
  }

  Widget _buildSocialTab(BuildContext context) {
    return ref.watch(authenticatedUserFriendsProvider).when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  InputTextField(
                    controller: _searchController,
                    width: MediaQuery.of(context).size.width / 1.25,
                    hint: AppLocalizations.of(context)!.searchFriend,
                    icon: const Icon(Icons.search),
                    isPasswordField: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Expanded(
                    child: ListView.separated(
                      itemCount: data.length,
                      itemBuilder: (context, index) => UserCard(
                        user: data[index],
                        action: IconButton(
                          icon: const Icon(Icons.person_remove),
                          onPressed: () async {
                            await ref
                                .watch(
                                  friendshipsControllerProvider.notifier,
                                )
                                .deleteFriendship(
                                  ref
                                      .read(authenticatedUserProvider)
                                      .value!
                                      .username!,
                                  data[index].username!,
                                );

                            ref.invalidate(authenticatedUserProvider);
                            setState(() {});
                          },
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
          },
          error: (error, stacktrace) => Container(),
          loading: () => const LoadingSpinner(),
        );
  }
}
