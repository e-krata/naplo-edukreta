import 'package:filcnaplo_kreta_api/client/api.dart';
import 'package:filcnaplo_kreta_api/client/client.dart';
import 'package:filcnaplo_kreta_api/models/lep_event.dart';
import 'package:flutter/foundation.dart';

class LepProvider with ChangeNotifier {
  final KretaClient client;
  List<LepEvent> events = [];
  bool loading = false;
  String? error;

  LepProvider({required this.client});

  Future<void> fetch() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      final res = await client.getAPI(KretaAPI.lepEvents);
      if (res is List) {
        events = res
            .whereType<Map>()
            .map((e) => LepEvent.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        events = [];
      }
    } catch (e) {
      error = e.toString();
      events = [];
    }
    loading = false;
    notifyListeners();
  }

  Future<bool> join(String uid) async {
    try {
      await client.postAPI(KretaAPI.lepEventJoin, body: {"Uid": uid});
      await fetch();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> setPermission(String uid, bool ok) async {
    try {
      await client.postAPI(KretaAPI.lepPermission, body: {
        "Uid": uid,
        "PermissionOk": ok,
      });
      await fetch();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> finish(String uid) async {
    try {
      await client.postAPI(KretaAPI.lepEventFinished, body: {"Uid": uid});
      await fetch();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> delete(String uid) async {
    try {
      await client.postAPI(KretaAPI.lepEventDelete, body: {"Uid": uid});
      await fetch();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> add({
    required String cim,
    String leiras = "",
    String kezdet = "",
    String vege = "",
    String hely = "",
    int maxLetszam = 0,
    String intezmenyKod = "",
  }) async {
    try {
      await client.postAPI(KretaAPI.lepEventAdd, body: {
        "Cim": cim,
        "Leiras": leiras,
        "Kezdet": kezdet,
        "Vege": vege,
        "Hely": hely,
        "MaxLetszam": maxLetszam,
        "IntezmenyKod": intezmenyKod,
      });
      await fetch();
      return true;
    } catch (_) {
      return false;
    }
  }
}
