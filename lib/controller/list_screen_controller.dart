import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pagination_sample/models/contact_api_response_model.dart';

class ListScreenController extends GetxController {
  int _currentPage = 1;
  RxList<Data> _data = <Data>[].obs;
  RxBool isLoading = false.obs;
  bool _canInvokeApi = true;

  RxList<Data> get data => RxList.unmodifiable(_data);

  invokeAPi() async {
    if (_canInvokeApi) {
      isLoading.value = true;
      final String url = "https://612c49f2ab461c00178b5c4c.mockapi.io/api/jm/intv/contacts-$_currentPage";
      ContactApiResponse? apiModel;
      //Invoking the API
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        apiModel = ContactApiResponse.fromJson(jsonResponse);
        _data.addAll(apiModel.data);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      if (apiModel != null && apiModel.next) {
        _canInvokeApi = apiModel.next;
        _currentPage++;
      }
      isLoading.value = false;
    }
  }
}
