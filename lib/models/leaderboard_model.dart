class LeaderBoardModel {
  bool? success;
  List<Data>? data;

  LeaderBoardModel({this.success, this.data});

  LeaderBoardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? playerName;
  int? score;
  int? survivalDuration;
  String? atTime;
  int? numberOfTries;

  Data(
      {this.playerName,
      this.score,
      this.survivalDuration,
      this.atTime,
      this.numberOfTries});

  Data.fromJson(Map<String, dynamic> json) {
    playerName = json['playerName'];
    score = json['score'];
    survivalDuration = json['survivalDuration'];
    atTime = json['atTime'];
    numberOfTries = json['numberOfTries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playerName'] = this.playerName;
    data['score'] = this.score;
    data['survivalDuration'] = this.survivalDuration;
    data['atTime'] = this.atTime;
    data['numberOfTries'] = this.numberOfTries;
    return data;
  }
}
