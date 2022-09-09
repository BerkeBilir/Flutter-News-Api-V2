import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../theme/color.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ColorTheme().backgroundColor,
        body: SafeArea(
          child: data[0]['image'] != null ? data[0]['title'] != null ? data[0]['description'] != null ? data[0]['date'] != null ? data[0]['author'] != null ? Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Center(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 20.0),
                        width: width,
                        color: ColorTheme().backgroundColor,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Positioned(
                                left: 0,
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
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0)),
                                        color: ColorTheme().cardColor,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 1,
                                              color: ColorTheme().shadowColor,
                                              spreadRadius: 0.1)
                                        ],
                                      ),
                                      child: IconButton(
                                          padding: const EdgeInsets.all(4.0),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(Icons.arrow_back,
                                              color: ColorTheme().iconColor))),
                                ),
                              )
                            ],
                          ),
                        )),
                    data[0]['image'] != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Container(
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        const Radius.circular(15.0))),
                                width: width,
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: FadeInImage(
                                    fit: BoxFit.fill,
                                    placeholder: const AssetImage(
                                        'assets/images/loadingTwo.gif'),
                                    image: NetworkImage(
                                        data[0]['image'].toString()),
                                  ),
                                )),
                          )
                        : const CircularProgressIndicator(),
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: ColorTheme().cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('${data[0]['title']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: ColorTheme().textColor)),
                              const SizedBox(height: 15),
                              Text('${data[0]['description']}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: ColorTheme()
                                          .textColor
                                          .withOpacity(0.8))),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${data[0]['date']}'.substring(0, 10),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: ColorTheme()
                                              .textColor
                                              .withOpacity(0.8))),
                                  Text('${data[0]['author']}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: ColorTheme()
                                              .textColor
                                              .withOpacity(0.8)),
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ) : Center(child: Lottie.asset('assets/images/404.json')) : Center(child: Lottie.asset('assets/images/404.json')) : Center(child: Lottie.asset('assets/images/404.json')) : Center(child: Lottie.asset('assets/images/404.json')) : Center(child: Lottie.asset('assets/images/404.json')),
        ));
  }
}
