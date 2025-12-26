class Hands {
  final String playHandTitle;
  final String imageAsset;
  final String playHand;

  Hands(
      {required this.playHandTitle,
      required this.imageAsset,
      required this.playHand});
}

class Users {
  String name;
  int wins;
  int totalMatch;
  double winRate;

  Users({
    required this.name,
    required this.wins,
    required this.totalMatch,
    required this.winRate,
  });

  Map<String, dynamic> toJsonTTT() {
    return {
      "name": name,
      "wins": wins,
      "totalMatch": totalMatch,
      "winRate": winRate,
    };
  }

  factory Users.fromJsonTTT(Map<String, dynamic> json) {
    return Users(
      name: json["name"],
      wins: json["wins"],
      totalMatch: json["totalMatch"],
      winRate: json["winRate"],
    );
  }
}
