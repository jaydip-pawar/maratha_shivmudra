import 'package:dart_mappable/dart_mappable.dart';

part 'two_factor_model.mapper.dart';

@MappableClass()
class TwoFactorModel with TwoFactorModelMappable {
  const TwoFactorModel({this.status, this.details});

  @MappableField(key: 'Status')
  final String? status;

  @MappableField(key: 'Details')
  final String? details;

  bool get isSuccess => status?.toLowerCase() == 'success';

  static const fromJson = TwoFactorModelMapper.fromMap;
}
