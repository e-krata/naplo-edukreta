class LepEvent {
  final String uid;
  final String cim;
  final String leiras;
  final String kezdet;
  final String vege;
  final String hely;
  final int maxLetszam;
  final int jelentkezokSzama;
  final String statusz;
  final String intezmenyKod;
  final bool permissionOk;
  final String letrehozva;

  LepEvent({
    required this.uid,
    required this.cim,
    this.leiras = "",
    this.kezdet = "",
    this.vege = "",
    this.hely = "",
    this.maxLetszam = 0,
    this.jelentkezokSzama = 0,
    this.statusz = "",
    this.intezmenyKod = "",
    this.permissionOk = true,
    this.letrehozva = "",
  });

  factory LepEvent.fromJson(Map<String, dynamic> json) {
    return LepEvent(
      uid: json["Uid"]?.toString() ?? "",
      cim: json["Cim"]?.toString() ?? "",
      leiras: json["Leiras"]?.toString() ?? "",
      kezdet: json["Kezdet"]?.toString() ?? "",
      vege: json["Vege"]?.toString() ?? "",
      hely: json["Hely"]?.toString() ?? "",
      maxLetszam: (json["MaxLetszam"] as num?)?.toInt() ?? 0,
      jelentkezokSzama: (json["JelentkezokSzama"] as num?)?.toInt() ?? 0,
      statusz: json["Statusz"]?.toString() ?? "",
      intezmenyKod: json["IntezmenyKod"]?.toString() ?? "",
      permissionOk: json["PermissionOk"] == true,
      letrehozva: json["Letrehozva"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Uid": uid,
        "Cim": cim,
        "Leiras": leiras,
        "Kezdet": kezdet,
        "Vege": vege,
        "Hely": hely,
        "MaxLetszam": maxLetszam,
        "JelentkezokSzama": jelentkezokSzama,
        "Statusz": statusz,
        "IntezmenyKod": intezmenyKod,
        "PermissionOk": permissionOk,
        "Letrehozva": letrehozva,
      };

  bool get isFull => maxLetszam > 0 && jelentkezokSzama >= maxLetszam;
  bool get isFinished => statusz.toLowerCase() == "befejezett";
}
