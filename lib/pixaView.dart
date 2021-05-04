import 'dart:html';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import './getdatas/pixa_list.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/cupertino.dart';
import 'package:ext_storage/ext_storage.dart';
import 'dart:math';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;

import 'package:flutter/rendering.dart';

class Details extends StatefulWidget {
  Details({Key key, this.images, this.currImgIdx}) : super(key: key);

  final List<PixaList> images;
  final int currImgIdx;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          physics: PageScrollPhysics(),
          itemCount: widget.images.length,
          controller:
              PageController(initialPage: widget.currImgIdx, keepPage: false),
          itemBuilder: (ctx, position) {
            final currImg = widget.images[position];
            return Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButton: SpeedDial(
                marginEnd: 18,
                marginBottom: 20,
                icon: Icons.more_horiz,
                activeIcon: Icons.remove,
                buttonSize: 56.0,
                visible: true,
                closeManually: false,
                renderOverlay: false,
                curve: Curves.bounceIn,
                overlayColor: Colors.black,
                overlayOpacity: 0.5,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 8.0,
                shape: CircleBorder(),
                children: [
                  SpeedDialChild(
                    child: Icon(Icons.download_rounded),
                    backgroundColor: Colors.red,
                    label: 'Downlaod',
                    labelStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      final phid = widget.images[position].id;

                      final anchor = AnchorElement(
                        href: "https://www.pexels.com/photo/$phid/download",
                      )
                        ..setAttribute("download",
                            "${widget.images[position].id}_1920.jpg")
                        ..click();
                    },
                    onLongPress: () => print('FIRST CHILD LONG PRESS'),
                  ),
                  SpeedDialChild(
                    child: Icon(Icons.open_in_browser),
                    backgroundColor: Colors.blue,
                    label: 'open in browser',
                    labelStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      js.context.callMethod(
                          'open', ['${widget.images[position].pageURL}']);
                    },
                    onLongPress: () => print('SECOND CHILD LONG PRESS'),
                  ),
                  SpeedDialChild(
                    child: Icon(Icons.supervised_user_circle),
                    backgroundColor: Colors.green,
                    label: 'Go to User',
                    labelStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    onTap: () {
                      js.context.callMethod('open',
                          ['${widget.images[position].photographerurl}']);
                    },
                  ),
                ],
              ),
              body: Stack(
                children: [
                  Hero(
                      tag: 'IMG_${currImg.id}',
                      child: Center(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.basic,
                          child: PhotoView(
                            imageProvider: CachedNetworkImageProvider(
                                currImg.largeImageURL),
                            minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered * 2,
                            // ignore: deprecated_member_use
                            loadingChild: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),
                      )),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          widget.images[position].webformatURL),
                    ),
                    title: Text(
                      "By ${widget.images[position].user}",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Text(
                      widget.images[position].userImageURL,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  )
                ],
              ),
            );
          }),
    ));
  }
}
