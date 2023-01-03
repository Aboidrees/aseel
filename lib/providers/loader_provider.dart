import 'package:flutter/material.dart';

class LoaderProvider with ChangeNotifier {
  bool _isApiCallProcess = false;
  bool get isApiCallProcess => _isApiCallProcess;

  bool _isLoadingMore = false;
  bool get isLoadingMore =>_isLoadingMore;



  setStatus(bool status) {
    _isApiCallProcess = status;
    notifyListeners();
  }

  seIsLoadingMore(bool status){
    _isLoadingMore = status;
    notifyListeners();
  }
}
