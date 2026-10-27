import 'package:filcnaplo_kreta_api/client/api.dart';
import 'package:filcnaplo_kreta_api/client/client.dart';
import 'package:filcnaplo_kreta_api/models/covid_closure.dart';
import 'package:flutter/foundation.dart';

class CovidProvider with ChangeNotifier {
  final KretaClient client;
  CovidClosure? closure;
  bool loading = false;
  String? error;

  CovidProvider({required this.client});

  Future<bool> bejelentes(String intezmenyId, {Map<String, dynamic>? valaszok}) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await client.postAPI(
        KretaAPI.covidBejelentes(intezmenyId),
        body: {
          "IntezmenyId": intezmenyId,
          if (valaszok != null) "Valaszok": valaszok,
        },
      );
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> lezarasStart(String intezmenyId) async {
    try {
      final res = await client.postAPI(KretaAPI.covidIntLezarasStart(intezmenyId));
      if (res is Map) {
        closure = CovidClosure.fromJson(Map<String, dynamic>.from(res));
      }
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> lezarasVege(String intezmenyId) async {
    try {
      final res = await client.postAPI(KretaAPI.covidIntLezarasVege(intezmenyId));
      if (res is Map) {
        closure = CovidClosure.fromJson(Map<String, dynamic>.from(res));
      }
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
