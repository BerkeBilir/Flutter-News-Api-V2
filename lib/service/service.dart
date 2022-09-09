import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../models/model.dart';

var datas = Get.arguments;

Future<List<Article>?> fetchAlbum() async {
  var dio = Dio();
  var url =
      'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=03cd77e9250c4599beb56603c339d105&language=en';
  try {
    Response response = await dio.get(url);
    NewsResponse newsResponse = NewsResponse.fromJson(response.data);
    return newsResponse.articles;
    // ignore: empty_catches

  } on DioError {}
  return null;
}

Future<List<Article>?> fetchCarousel() async {
  var dio = Dio();
  var url = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=03cd77e9250c4599beb56603c339d105';
    try {
      Response response = await dio.get(url);
      NewsResponse newsResponse = NewsResponse.fromJson(response.data);
      List tempList = [];
      for (int i = 0; i < response.data.length; i++) {
      tempList.add(response.data[i]);
      print(tempList.length);
    }
      return newsResponse.articles;
    // ignore: empty_catches
    
    } on DioError {}
    return null;
  }

Future<List<Article>?> fetchCategory() async {
  var dio = Dio();
  var datas = Get.arguments;
  var url = 'https://newsapi.org/v2/top-headlines?country=us&category=${datas[0]}&apiKey=03cd77e9250c4599beb56603c339d105&language=en';
    try {
      Response response = await dio.get(url);
      NewsResponse newsResponse = NewsResponse.fromJson(response.data);
      return newsResponse.articles;
    // ignore: empty_catches
    
    } on DioError {}
    return null;
  }