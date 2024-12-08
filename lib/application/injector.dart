import 'package:ratemy/screens/presentation/login_presentation.dart';

import '../framework/api_service.dart';

class Injector {
  static final Injector _instance = Injector._internal();

  factory Injector() {
    return _instance;
  }

  Injector._internal();


  // SERVICES
  APIService getAPIService() {
    return APIService();
  }

  // MAPPERS

  // USE CASES

  // PRESENTATION
  LoginPresentation getLoginPresentation() {
    return LoginPresentation();
  }
}