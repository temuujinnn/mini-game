class LeaderBoardModel {
  final String id;
  final String name;
  final int score;
  final int numberOfTry;
  final double reward;
  // taken time

  LeaderBoardModel({
    required this.name,
    required this.score,
    required this.id,
    required this.numberOfTry,
    required this.reward,
  });

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) {
    return LeaderBoardModel(
      id: json['id'],
      name: json['name'],
      score: json['score'],
      numberOfTry: json['numberOfTry'],
      reward: json['reward'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'score': score,
      'numberOfTry': numberOfTry,
      'reward': reward,
    };
  }

  @override
  String toString() {
    return 'LeaderBoardModel(name: $name, score: $score, id: $id, numberOfTry: $numberOfTry, reward: $reward)';
  }
}
