
class Sector {
  //final int iSectorCode;
  final String sSectorName;

  Sector({required this.sSectorName});

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      sSectorName: json['sSectorName'],
    );
  }
}