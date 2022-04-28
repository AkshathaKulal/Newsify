import 'package:newsify_demo/core/network/api_client.dart';

import '../../injection_container.dart';

/// @author Akshatha

class ApiClientController {
  ApiClient? apiClient;

  ApiClientController({ApiClient? apiClient}) {
    this.apiClient = apiClient ?? locator.get<ApiClient>();
  }

  Future<dynamic> getClient() async {
    return apiClient?.getApiClient();
  }
}
