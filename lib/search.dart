import 'package:flutter/material.dart';
import 'cubit/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pixaView.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:transparent_image/transparent_image.dart';

class SearchPage extends StatelessWidget {
  final String searchedText;

  const SearchPage({Key key, this.searchedText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchCubit>(context).getImages(searchedText);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: Text(
          'Search Result',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state.status == SearchStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == SearchStatus.success) {
            return StaggeredGridView.countBuilder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              crossAxisCount: 4,
              itemCount: state.pixaList.length,
              itemBuilder: (BuildContext context, int i) {
                if (state.pixaList.isEmpty) {
                  return Center(
                    child: Text(
                      "No Images Found of searched text",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      images: state.pixaList,
                                      currImgIdx: i,
                                    )));
                      },
                      child: Card(
                        child: ClipRRect(
                          child: FadeInImage.memoryNetwork(
                            image: state.pixaList[i].previewURL,
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                          ),
                        ),
                      ));
                }
              },
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 1.2 : 1.8),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            );
          } else if (state.status == SearchStatus.error) {
            return Center(
              child: Text('Error can\'t fetch data from api '),
            );
          }
        },
      ),
    );
  }
}
