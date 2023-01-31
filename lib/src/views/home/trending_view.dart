import 'package:flutter/material.dart';

import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/widgets/cards/song_card.dart';
import 'package:rhythm/src/widgets/images/labeled_image_holder.dart';

class TrendingView extends StatefulWidget {
  const TrendingView({Key? key}) : super(key: key);

  @override
  State<TrendingView> createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          _buildTodayTopArtist(context),
          _buildTodayTopSongs(context),
        ],
      ),
    );
  }

  Widget _buildTodayTopSongs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Today Most Shared Songs',
            style: kSectionTitle,
          ),
        ),
        ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children:  [
            SongCard(imageUrl: 'https://i.scdn.co/image/ab6761610000e5eb87ff3d09a0fdb1fbdaed417b',
                songName: 'Songname', artistName: 'artistName', isPlaying: false,),
            const SizedBox(
              height: 12.0,
            ),
            SongCard(imageUrl: 'https://i.scdn.co/image/ab6761610000e5eb87ff3d09a0fdb1fbdaed417b',
              songName: 'Songname', artistName: 'artistName', isPlaying: false,),
            const SizedBox(
              height: 12.0,
            ),
            SongCard(imageUrl: 'https://i.scdn.co/image/ab6761610000e5eb87ff3d09a0fdb1fbdaed417b',
              songName: 'Songname', artistName: 'artistName', isPlaying: false,),
            const SizedBox(
              height: 12.0,
            ),
            SongCard(imageUrl: 'https://i.scdn.co/image/ab6761610000e5eb87ff3d09a0fdb1fbdaed417b',
              songName: 'Songname', artistName: 'artistName', isPlaying: false,),
            const SizedBox(
              height: 12.0,
            ),
            SongCard(imageUrl: 'https://i.scdn.co/image/ab6761610000e5eb87ff3d09a0fdb1fbdaed417b',
              songName: 'Songname', artistName: 'artistName', isPlaying: false,),
            const SizedBox(
              height: 12.0,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTodayTopArtist(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Today Most Shared Artist',
            style: kSectionTitle,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => SizedBox(
              width: MediaQuery.of(context).size.width / 3.5,
              child: LabeledImageHolder(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                url: 'https://i.scdn.co/image/ab6761610000e5eb87ff3d09a0fdb1fbdaed417b',
                description: 'Eladio Camion',
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 12,
            ),
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}
