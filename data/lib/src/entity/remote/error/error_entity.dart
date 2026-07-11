class ErrorEntity {
  ErrorEntity({this.type = '', this.code = 0, this.message = ''});

  int code;
  String type;
  String message;

  factory ErrorEntity.fromJson(Map<String, dynamic> json) {
    return ErrorEntity(
      code: json['code'] as int? ?? 0,
      type: json['type'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'type': type, 'message': message};
  }
}
