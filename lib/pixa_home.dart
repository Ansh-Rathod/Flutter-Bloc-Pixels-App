import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pixabay/getdatas/pixa_list.dart';
import 'bloc/pixa_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/search_cubit.dart';
import 'pixaView.dart';
import 'search.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';

class PixaHome extends StatefulWidget {
  @override
  _PixaHomeState createState() => _PixaHomeState();
}

class _PixaHomeState extends State<PixaHome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PixaBloc, PixaState>(
        // ignore: missing_return
        builder: (context, state) {
      if (state is PixaLoading) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (state is PixaLoadSuccess) {
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0.0,
          // ),
          body: Container(
            child: SafeArea(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "Pixels",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(
                      state.pixalist,
                      expandedHeight:
                          MediaQuery.of(context).size.width > 900 ? 400 : 300,
                    ),
                    // pinned: true,
                    // floating: true,
                  ),
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    title: Text(
                      "Popular images",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate((_, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                        images: state.pixalist,
                                        currImgIdx: i,
                                      )));
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: GridTile(
                            child: CachedNetworkImage(
                              imageUrl: state.pixalist[i].previewURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }, childCount: state.pixalist.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 900 ? 4 : 3),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (state is PixaLoadError) {
        return Scaffold(body: Center(child: Text(state.error.toString())));
      }
    });
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final List<PixaList> images;

  MySliverAppBar(this.images, {@required this.expandedHeight});
  var int = Random().nextInt(200);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(images[int].largeImageURL),
                  fit: BoxFit.cover)),
        ),
        Container(),
        Positioned(
          top: expandedHeight / 2.5 - shrinkOffset,
          left: MediaQuery.of(context).size.width * .02,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    autofocus: false,
                    autofillHints: [
                      'Wallpapers',
                      'Nature'
                          'People',
                      'Architecture',
                      'Current Events',
                      'Business & Work',
                      'Experimental',
                      'Fashion',
                      'Film',
                      'Health & Wellness',
                      'Interiors',
                      'Street Photography',
                      'Technology',
                      'Travel',
                      'Textures & Patterns',
                      'Animals',
                      'Food & Drink',
                      'Athletics',
                      'Spirituality',
                      'Arts & Culture',
                      'History'
                    ],
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(
                        hintText: 'e.g yellow,beautiful,children',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(color: Colors.grey[600]),
                        suffixIcon: Icon(Icons.search),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    onFieldSubmitted: (_) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => SearchCubit(),
                                child: SearchPage(
                                  searchedText: _,
                                ),
                              )));
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
