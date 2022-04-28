import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:newsify_demo/core/error/exceptions/exceptions.dart';
import 'package:newsify_demo/core/error/exceptions/internal_exception.dart';
import 'package:newsify_demo/core/utils/api_urls.dart';

import '../../../../core/utils/constants.dart';
import '../models/news_model.dart';

/// @author Akshatha

abstract class NewsRemoteDataSources {
  Future<dynamic> getNews();
}

class NewsRemoteDatasourcesImpl implements NewsRemoteDataSources {
  RetryClient retryClient;

  NewsRemoteDatasourcesImpl(this.retryClient);

  @override
  Future<dynamic> getNews() async {
    try {
      var apiUrl = ApiUrl.BASE_URL;

      var response = await retryClient.get(Uri.parse(apiUrl)).timeout(
            const Duration(seconds: Constants.DEFAULT_HTTP_TIMEOUT),
            onTimeout: onTimeOut,
          );

      if (response.statusCode == Constants.HTTP_OK) {
        return NewsModel.fromJson(jsonDecode(response.body));
      } else {
        throw InternalException.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return ServerException(e);
    }
  }

  FutureOr<Response> onTimeOut() async {
    throw ServerException(Constants.HTTP_CLIENT_TIMEOUT);
  }
}
