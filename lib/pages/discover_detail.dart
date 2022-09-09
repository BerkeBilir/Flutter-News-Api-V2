import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/color.dart';
import '../models/model.dart';
import '../service/service.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'detail.dart';

var test = [];

class DiscoverDetailPage extends StatefulWidget {
  const DiscoverDetailPage({super.key});

  @override
  State<DiscoverDetailPage> createState() => _DiscoverDetailPageState();
}

class _DiscoverDetailPageState extends State<DiscoverDetailPage> {
  late Future<List<Article>?> futureCategory;

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  CarouselController buttonCarouselController = CarouselController();
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    futureCategory = fetchCategory();
  }

  bool isListView = true;
  var datas = Get.arguments;

  DateTime _selectedDate = DateTime.now();
  // DateTime _selectedDate = DateTime.now().subtract(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorTheme().backgroundColor,
      key: _globalKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              color: ColorTheme().cardColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    color: ColorTheme().shadowColor,
                                    spreadRadius: 0.1)
                              ],
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(Icons.arrow_back,
                                    color: ColorTheme().iconColor))),
                                    Text(datas[0],
                                style: TextStyle(
                                    fontSize: 25,
                                    color: ColorTheme().textColor)),
                        Container(
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
                                  icon: Icon(Icons.toc,
                                      color: ColorTheme().iconColor)),
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(
              width: width,
              height: height / 3.5,
              child: FutureBuilder<List<Article>?>(
                future: futureCategory,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return Center(
                      child: CarouselSlider.builder(
                          carouselController: buttonCarouselController,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            var data = snapshot.data![itemIndex];
                            return data.urlToImage != null
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(const DetailPage(), arguments: [
                                        {
                                          'title': data.title,
                                          'image': data.urlToImage,
                                          'date': data.publishedAt,
                                          'author': data.author,
                                          'description': data.description,
                                        }
                                      ]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        children: [
                                          Container(
                                              decoration: new BoxDecoration(
                                                  borderRadius:
                                                      new BorderRadius.all(
                                                          const Radius.circular(
                                                              15.0))),
                                              width: width,
                                              height: 200,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: FadeInImage(
                                                  fit: BoxFit.fill,
                                                  placeholder: const AssetImage(
                                                      'assets/images/loadingTwo.gif'),
                                                  image: NetworkImage(data
                                                      .urlToImage
                                                      .toString()),
                                                ),
                                              )),
                                          Container(
                                            decoration: new BoxDecoration(
                                                color: ColorTheme()
                                                    .cardColor
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    new BorderRadius.only(
                                                  bottomLeft:
                                                      const Radius.circular(
                                                          15.0),
                                                  bottomRight:
                                                      const Radius.circular(
                                                          15.0),
                                                )),
                                            width: width,
                                            height: 50,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4),
                                                child: Text('${data.title}',
                                                    style: TextStyle(
                                                        color: ColorTheme()
                                                            .textColor,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Center(
                                    child:
                                        Lottie.asset('assets/images/404.json'));
                          },
                          options: CarouselOptions(
                            initialPage: 0,
                            viewportFraction: 0.83,
                            disableCenter: true,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                          )),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FutureBuilder<List<Article>?>(
                future: futureCategory,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return isListView
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 40,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                child: SizedBox(
                                  width: width,
                                  height: 100.0,
                                  child: Shimmer.fromColors(
                                    baseColor: ColorTheme().cardColor,
                                    highlightColor: const Color(0xFF757575),
                                    child: const Card(),
                                  ),
                                ),
                              );
                            })
                        : Shimmer.fromColors(
                            baseColor: ColorTheme().cardColor,
                            highlightColor: const Color(0xFF757575),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: width,
                                height: height,
                                child: GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: height / (width * 2.7),
                                    ),
                                    itemCount: 40,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return const Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          );
                  }
                  if (snapshot.hasData) {
                    return isListView
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data![index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                child: SizedBox(
                                  height: 100,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(const DetailPage(),
                                          arguments: [
                                            {
                                              'title': data.title,
                                              'image': data.urlToImage,
                                              'date': data.publishedAt,
                                              'author': data.author,
                                              'description':
                                                  data.description,
                                            }
                                          ]);
                                      String a = '${data.publishedAt}'
                                          .substring(0, 10);
                                      String b =
                                          "${DateFormat('yyyy-MM-dd').format(_selectedDate)}"
                                              .toString();
                                      print(a == b ? 'eşit' : 'değil');
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shadowColor: ColorTheme().shadowColor,
                                      color: ColorTheme().cardColor,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              title: Text('${data.title}',
                                                  style: TextStyle(
                                                      color: ColorTheme()
                                                          .textColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                    '${data.publishedAt}'
                                                        .substring(0, 10),
                                                    style: TextStyle(
                                                      color: ColorTheme()
                                                          .textColor,
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                          data.urlToImage != null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: new BoxDecoration(
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .all(const Radius
                                                                      .circular(
                                                                  4.0))),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
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
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: Lottie.asset('assets/images/404.json'),
                                                ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: (height + 30) / (width * 2.8),
                                ),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = snapshot.data![index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(const DetailPage(), arguments: [
                                        {
                                          'title': data.title,
                                          'image': data.urlToImage,
                                          'date': data.publishedAt,
                                          'author': data.author,
                                          'description': data.description,
                                        }
                                      ]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0, vertical: 4.0),
                                      child: Card(
                                        color: ColorTheme().cardColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              data.urlToImage != null
                                                  ? Container(
                                                      width: width,
                                                      height: 130,
                                                      decoration: new BoxDecoration(
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .all(const Radius
                                                                      .circular(
                                                                  4.0))),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: FadeInImage(
                                                          fit: BoxFit.fitHeight,
                                                          placeholder:
                                                              const AssetImage(
                                                                  'assets/images/loading.gif'),
                                                          image: NetworkImage(
                                                              data.urlToImage
                                                                  .toString()),
                                                        ),
                                                      ))
                                                  : const CircularProgressIndicator(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Text('${data.title}',
                                                    style: TextStyle(
                                                        color: ColorTheme()
                                                            .textColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ]),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: ColorTheme().cardColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: ColorTheme().backgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 25,
                            backgroundColor: ColorTheme().buttonColor,
                            child: Text('B',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: ColorTheme().textColor))),
                        SizedBox(width: 10),
                        Text('Berke B',
                            style: TextStyle(
                                fontSize: 18, color: ColorTheme().textColor))
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon:
                            Icon(Icons.settings, color: ColorTheme().iconColor))
                  ],
                ),
              ),
              ListTile(
                title: Text('Item 1',
                    style: TextStyle(color: ColorTheme().textColor)),
              ),
              ListTile(
                title: Text('Item 2',
                    style: TextStyle(color: ColorTheme().textColor)),
              ),
              ListTile(
                title: Text('Item 3',
                    style: TextStyle(color: ColorTheme().textColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
