import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/color.dart';
import '../models/model.dart';
import '../service/service.dart';
import 'dart:async';

import 'detail.dart';
import 'discover_detail.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late Future<List<Article>?> futureAlbum;
  late Future<List<Article>?> futureAlbumOne;
  final List<String> category = <String>[
    'Business',
    'Entertainment',
    'General',
    'Science',
    'Sports',
    'Technology'
  ];

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  CarouselController buttonCarouselController = CarouselController();

  bool isListView = false;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: ColorTheme().backgroundColor,
        key: _globalKey,
        body: SafeArea(
          child: Stack(
            children: [
              isListView
                  ? Center(
                      child: SizedBox(
                        width: width,
                        height: height / 2,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: category.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(DiscoverDetailPage(), arguments: [
                                          category[index]
                                        ]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text('${category[index]}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: ColorTheme().textColor)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child:
                                        Divider(color: ColorTheme().textColor),
                                  )
                                ],
                              );
                            }),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: FutureBuilder<List<Article>?>(
                            future: futureAlbum,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: height/6),
                        child: Shimmer.fromColors(
                                baseColor: ColorTheme().cardColor,
                                highlightColor: const Color(0xFF757575),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  width: width,
                                  height: height,
                                  child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: height / (width * 1.4),
                                ),
                                itemCount: category.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 4.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: width,
                                          height: 140,
                                          decoration: new BoxDecoration(
                                            color: ColorTheme().cardColor,
                                                        borderRadius:
                                                            new BorderRadius
                                                                .all(const Radius
                                                                    .circular(
                                                                8.0))),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                ),
                              ),
                      ),
                    );
                  } if (snapshot.hasData) {
                    return GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: height / (width * 1.4),
                                  ),
                                  itemCount: category.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var data = snapshot.data![index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(DiscoverDetailPage(), arguments: [
                                          category[index]
                                        ]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0, vertical: 2.0),
                                        child: Stack(
                                          children: [
                                            data.urlToImage != null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Center(
                                                    child: Container(
                                                        height: 140,
                                                        decoration: new BoxDecoration(
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .all(const Radius
                                                                        .circular(
                                                                    8.0))),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: FadeInImage(
                                                            fit: BoxFit.fitHeight,
                                                            placeholder:
                                                                const AssetImage(
                                                                    'assets/images/loading.gif'),
                                                            image: NetworkImage(
                                                                data.urlToImage
                                                                    .toString()),
                                                          ),
                                                        )),
                                                  ),
                                                )
                                              : const CircularProgressIndicator(),
                                            Align(
                                                      alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding:
                                                      const EdgeInsets.all(3.0),
                                                child: Container(
                                                  height: 40,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Align(
                                                        alignment: Alignment.bottomLeft,
                                                        child: Text(
                                                          '${category[index]}',
                                                          style: TextStyle(fontSize: 17, color: ColorTheme().textColor,)
                                                        )),
                                                  ),
                                                  decoration: new BoxDecoration(
                                                    color: ColorTheme().cardColor.withOpacity(0.8),
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .only(
                                                                    bottomLeft: Radius.circular(8.0),
                                                                    bottomRight: Radius.circular(8.0),
                                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                  }
                  else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                            }
                          ),
                        ),
                      ),
                    ),
              Container(
                  padding: EdgeInsets.only(top: 0.0),
                  width: width,
                  color: ColorTheme().backgroundColor,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Center(
                            child: Text('Keşfet',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: ColorTheme().textColor))),
                        Positioned(
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorTheme().buttonColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    color: ColorTheme().shadowColor,
                                    spreadRadius: 0.1)
                              ],
                            ),
                            child: isListView
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isListView = false;
                                      });
                                    },
                                    icon: Icon(Icons.grid_view_outlined,
                                        color: ColorTheme().iconColor))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isListView = true;
                                      });
                                    },
                                    icon: Icon(Icons.filter_list,
                                        color: ColorTheme().iconColor)),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
