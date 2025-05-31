class SuccessModel {
  final bool success;
  final int code;
  final String message;

  SuccessModel({
    required this.success,
    required this.code,
    required this.message,
  });

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
    success: json["success"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
  };
}
