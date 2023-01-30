import 'package:flutter/material.dart';

import 'package:rhythm/src/widgets/cards/post_card.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) => const PostCard(),
      controller: PageController(),
      scrollDirection: Axis.vertical,
      itemCount: 5,
    );
  }
}
