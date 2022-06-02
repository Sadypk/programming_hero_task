class AnswerModel {
  AnswerModel({
    this.a,
    this.b,
    this.c,
    this.d,
  });

  String? a;
  String? b;
  String? c;
  String? d;

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        a: json["A"],
        b: json["B"],
        c: json["C"],
        d: json["D"],
      );

  Map<String, dynamic> toJson() => {
        "A": a,
        "B": b,
        "C": c,
        "D": d,
      };
}
