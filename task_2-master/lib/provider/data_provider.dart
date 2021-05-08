import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:task_1/model/api_model.dart';
import 'package:task_1/repositories/api_repo.dart';

class DataProvider extends ChangeNotifier {
  Future<List<Tag>> getApiDataFromRepo() async {
    List<Tag> data = await ApiRepo().getTags();
    notifyListeners();
    return data;
  }
}
