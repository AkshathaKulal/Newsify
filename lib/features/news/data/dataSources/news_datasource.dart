import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:newsify_demo/core/utils/api_urls.dart';

import '../../../../core/model/common_response_model.dart';
import '../../../../core/utils/constants.dart';
import '../models/news_model.dart';

abstract class NewsDataSources {
  Future<dynamic> getNews();
}

class NewsDatasourcesImpl implements NewsDataSources {
  RetryClient retryClient;

  NewsDatasourcesImpl(this.retryClient);

  @override
  Future<dynamic> getNews() async {
    try {
      var apiUrl = ApiUrl.BASE_URL;

      var response = await retryClient.get(Uri.parse(apiUrl)).timeout(
            const Duration(seconds: Constants.DEFAULT_HTTP_TIMEOUT),
            onTimeout: onTimeOut,
          );

      if (response.statusCode == 200) {
        return NewsModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print(e);
    }
  }

  FutureOr<Response> onTimeOut() async {
    throw CommonResponse(
      code: Constants.HTTP_GATEWAY_TIMEOUT,
    );
  }
}
