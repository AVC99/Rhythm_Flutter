import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/models/rhythm_user.dart';
import 'package:rhythm/src/controllers/authentication/authentication_controller.dart';
import 'package:rhythm/src/providers/spotify_provider.dart';
import 'package:rhythm/src/views/onboarding/start_view.dart';
import 'package:rhythm/src/widgets/buttons/circular_icon_button.dart';
import 'package:rhythm/src/widgets/cards/user_card.dart';
import 'package:rhythm/src/widgets/images/image_holder.dart';
import 'package:rhythm/src/widgets/images/labeled_image_holder.dart';
import 'package:rhythm/src/widgets/inputs/input_text_field.dart';
import 'package:rhythm/src/widgets/cards/song_card.dart';
import 'package:rhythm/src/widgets/texts/sliding_text.dart';

class ProfileView extends StatefulHookConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        Image.network(
          'https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
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
                    CircularIconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: AppLocalizations.of(context)!.edit,
                      onPressed: () {},
                    ),
                    CircularIconButton(
                      icon: const Icon(CupertinoIcons.ellipsis_vertical),
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
                child: const SlidingText(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'danimr99',
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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GridView.count(
        physics: const ClampingScrollPhysics(),
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        crossAxisCount: 3,
        children: List.generate(
          33,
          (index) => Center(
            child: ImageHolder(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
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
        _buildTopGenres(context),
      ],
    );
  }

  Widget _buildPlaylist(BuildContext context) {
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
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 12,
            ),
            itemCount: 5,
          ),
        ),
      ],
    );
  }

  Widget _buildTopGenres(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.mostListenedGenres,
            style: kSectionTitle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Wrap(
              spacing: 10,
              children: const [
                Chip(label: Text('Trap Urbano')),
                Chip(label: Text('Trap Urbano')),
                Chip(label: Text('Trap Urbano')),
                Chip(label: Text('Trap Urbano')),
                Chip(label: Text('Trap Urbano')),
                Chip(label: Text('Trap Urbano')),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopTracks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Top Songs',
            style: kSectionTitle,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        SongCard(),
        SizedBox(
          height: 10,
        ),
        SongCard(),
        SizedBox(
          height: 10,
        ),
        SongCard(),
        SizedBox(
          height: 10,
        ),
        SongCard(),
        SizedBox(
          height: 10,
        ),
        SongCard(),
        SizedBox(
          height: 10,
        ),
        SongCard(),
        SizedBox(
          height: 10,
        ),
        SongCard(),
        SizedBox(
          height: 10,
        ),
        SongCard(),
        SizedBox(
          height: 10,
        ),
        SongCard(),
        SizedBox(
          height: 10,
        ),
        SongCard(),
      ],
    );
  }

  Widget _buildTopArtists(BuildContext context) {
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
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 12,
            ),
            itemCount: 5,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialTab(BuildContext context) {
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
              itemBuilder: (context, index) => UserCard(
                user: RhythmUser.empty(),
                action: IconButton(
                  icon: const Icon(Icons.person_remove),
                  onPressed: () {},
                ),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
