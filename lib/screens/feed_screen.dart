import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ratemy/screens/presentation/feed_presentation.dart';

import 'components/bottom_bar.dart';

class FeedScreen extends StatefulWidget {
  final FeedPresentation presentation;

  const FeedScreen({super.key, required this.presentation});

  static String id = 'feed_screen';

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  String imageUrl = 'https://picsum.photos/id/${Random().nextInt(1000)}/800/800';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.presentation.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          widget.presentation.gapAboveScreenTitle,



          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                _buildTopSearchBar(),

                _buildLineSeparator(),

                const SizedBox(height: 40,),

                _buildImage(imageUrl),

                const SizedBox(height: 40,),

                _buildToolsRow(),

              ],
            ),
          ),

          _buildLineSeparator(),

          const BottomBar(),

          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget _buildImage(String src) {
    return GestureDetector(
      onTap: () {
         setState(() {
           imageUrl = 'https://picsum.photos/id/${Random().nextInt(1000)}/800/800';
         });
      },
      child: Image.network(
        src,
        gaplessPlayback: true,
        errorBuilder: onError,
        loadingBuilder: onLoading,
      ),
    );
  }

  Widget _buildLineSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 1,
        decoration: const BoxDecoration(
            color: Colors.white,
        ),
      ),
    );
  }

  Widget onError(BuildContext context, Object error, StackTrace? stackTrace) {
    double w = MediaQuery.sizeOf(context).width;
    return Container(
      color: widget.presentation.secondary,
      height: w,
      width: w,
      child: Center(
        child: Icon(
          Icons.broken_image,
          color: widget.presentation.primary,
          size: 50,
        ),
      ),
    );
  }

  Widget onLoading(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    double w = MediaQuery.sizeOf(context).width;

    if (loadingProgress == null) {
      return child;
    }
    return Container(
      color: widget.presentation.secondary,
      height: w,
      width: w,
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
              : null,
        ),
      ),
    );
  }

  _buildTopSearchBar() {
    return Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 20.0),
        child: Row(
          children: [
            Expanded(child: const Text('RATE MY', style: TextStyle(color: Colors.white))),

            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(Icons.search), color: widget.presentation.primary,),

            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(Icons.send), color: widget.presentation.secondary,)
          ],
        ),
      );
  }

  _buildToolsRow() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            iconSize: 40,
            icon: const Icon(Icons.insert_comment), color: widget.presentation.primary,),

          const SizedBox(width: 10,),

          IconButton(
            onPressed: () {},
            iconSize: 40,
            icon: const Icon(Icons.keyboard_return), color: widget.presentation.primary,),

          const SizedBox(width: 10,),

          IconButton(
            onPressed: () {},
            iconSize: 40,
            icon: const Icon(Icons.bookmark), color: widget.presentation.primary,),

          const Spacer(),

          SvgPicture.asset(
              height: 70,
              'assets/rate_btn.svg'
          ),

        ],
      ),
    );
  }
}
