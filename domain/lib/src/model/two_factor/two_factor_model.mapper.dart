// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'two_factor_model.dart';

class TwoFactorModelMapper extends ClassMapperBase<TwoFactorModel> {
  TwoFactorModelMapper._();

  static TwoFactorModelMapper? _instance;
  static TwoFactorModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TwoFactorModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TwoFactorModel';

  static String? _$status(TwoFactorModel v) => v.status;
  static const Field<TwoFactorModel, String> _f$status = Field(
    'status',
    _$status,
    key: r'Status',
    opt: true,
  );
  static String? _$details(TwoFactorModel v) => v.details;
  static const Field<TwoFactorModel, String> _f$details = Field(
    'details',
    _$details,
    key: r'Details',
    opt: true,
  );

  @override
  final MappableFields<TwoFactorModel> fields = const {
    #status: _f$status,
    #details: _f$details,
  };

  static TwoFactorModel _instantiate(DecodingData data) {
    return TwoFactorModel(
      status: data.dec(_f$status),
      details: data.dec(_f$details),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TwoFactorModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TwoFactorModel>(map);
  }

  static TwoFactorModel fromJson(String json) {
    return ensureInitialized().decodeJson<TwoFactorModel>(json);
  }
}

mixin TwoFactorModelMappable {
  String toJson() {
    return TwoFactorModelMapper.ensureInitialized().encodeJson<TwoFactorModel>(
      this as TwoFactorModel,
    );
  }

  Map<String, dynamic> toMap() {
    return TwoFactorModelMapper.ensureInitialized().encodeMap<TwoFactorModel>(
      this as TwoFactorModel,
    );
  }

  TwoFactorModelCopyWith<TwoFactorModel, TwoFactorModel, TwoFactorModel>
  get copyWith => _TwoFactorModelCopyWithImpl<TwoFactorModel, TwoFactorModel>(
    this as TwoFactorModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return TwoFactorModelMapper.ensureInitialized().stringifyValue(
      this as TwoFactorModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return TwoFactorModelMapper.ensureInitialized().equalsValue(
      this as TwoFactorModel,
      other,
    );
  }

  @override
  int get hashCode {
    return TwoFactorModelMapper.ensureInitialized().hashValue(
      this as TwoFactorModel,
    );
  }
}

extension TwoFactorModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TwoFactorModel, $Out> {
  TwoFactorModelCopyWith<$R, TwoFactorModel, $Out> get $asTwoFactorModel =>
      $base.as((v, t, t2) => _TwoFactorModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TwoFactorModelCopyWith<$R, $In extends TwoFactorModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? status, String? details});
  TwoFactorModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TwoFactorModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TwoFactorModel, $Out>
    implements TwoFactorModelCopyWith<$R, TwoFactorModel, $Out> {
  _TwoFactorModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TwoFactorModel> $mapper =
      TwoFactorModelMapper.ensureInitialized();
  @override
  $R call({Object? status = $none, Object? details = $none}) => $apply(
    FieldCopyWithData({
      if (status != $none) #status: status,
      if (details != $none) #details: details,
    }),
  );
  @override
  TwoFactorModel $make(CopyWithData data) => TwoFactorModel(
    status: data.get(#status, or: $value.status),
    details: data.get(#details, or: $value.details),
  );

  @override
  TwoFactorModelCopyWith<$R2, TwoFactorModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TwoFactorModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

