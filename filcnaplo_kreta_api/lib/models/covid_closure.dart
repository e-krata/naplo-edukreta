class CovidClosure {
  final String intezmenyId;
  final String start;
  final String vege;
  final bool aktiv;

  CovidClosure({
    required this.intezmenyId,
    this.start = "",
    this.vege = "",
    this.aktiv = false,
  });

  factory CovidClosure.fromJson(Map<String, dynamic> json) {
    return CovidClosure(
      intezmenyId: json["IntezmenyId"]?.toString() ?? "",
      start: json["Start"]?.toString() ?? "",
      vege: json["Vege"]?.toString() ?? "",
      aktiv: json["Aktiv"] == true,
    );
  }
}
