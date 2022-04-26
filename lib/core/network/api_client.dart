import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../utils/constants.dart';

class ApiClient {
  Future<RetryClient> getApiClient() async {
    var client = RetryClient(http.Client(), retries: Constants.RETRY_COUNT,
        when: (response) {
      return (response.statusCode == Constants.HTTP_CLIENT_TIMEOUT ||
              response.statusCode == Constants.HTTP_INTERNAL_ERROR)
          ? true
          : false;
    }, onRetry: (req, res, retryCount) async {
      if ((res?.statusCode == Constants.HTTP_UNAUTHORIZED)) {
        //Display Error Banner
      }
    });

    return client;
  }
}
