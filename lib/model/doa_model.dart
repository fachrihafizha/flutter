class DoaModel {
  int? id;
  String? doa;
  int? ayat;
  String? latin;
  String? artinya;

  DoaModel({
    this.id,
    this.doa,
    this.ayat,
    this.latin,
    this.artinya,
  });

  factory DoaModel.fromJson(Map<String, dynamic> json) {
    return DoaModel(
      id: json['id'],
      doa: json['asma'],
      ayat: json['ayat'],
      latin: json['latin'],
      artinya: json['artinya'],
    );
  }
}
