// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'article_model.dart';

class ArticleModelMapper extends ClassMapperBase<ArticleModel> {
  ArticleModelMapper._();

  static ArticleModelMapper? _instance;
  static ArticleModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArticleModelMapper._());
      RatingMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ArticleModel';

  static int _$id(ArticleModel v) => v.id;
  static const Field<ArticleModel, int> _f$id = Field('id', _$id);
  static String _$title(ArticleModel v) => v.title;
  static const Field<ArticleModel, String> _f$title = Field('title', _$title);
  static double _$price(ArticleModel v) => v.price;
  static const Field<ArticleModel, double> _f$price = Field('price', _$price);
  static String _$description(ArticleModel v) => v.description;
  static const Field<ArticleModel, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$category(ArticleModel v) => v.category;
  static const Field<ArticleModel, String> _f$category = Field(
    'category',
    _$category,
  );
  static String _$image(ArticleModel v) => v.image;
  static const Field<ArticleModel, String> _f$image = Field('image', _$image);
  static Rating _$rating(ArticleModel v) => v.rating;
  static const Field<ArticleModel, Rating> _f$rating = Field(
    'rating',
    _$rating,
  );

  @override
  final MappableFields<ArticleModel> fields = const {
    #id: _f$id,
    #title: _f$title,
    #price: _f$price,
    #description: _f$description,
    #category: _f$category,
    #image: _f$image,
    #rating: _f$rating,
  };

  static ArticleModel _instantiate(DecodingData data) {
    return ArticleModel(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      price: data.dec(_f$price),
      description: data.dec(_f$description),
      category: data.dec(_f$category),
      image: data.dec(_f$image),
      rating: data.dec(_f$rating),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ArticleModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ArticleModel>(map);
  }

  static ArticleModel fromJson(String json) {
    return ensureInitialized().decodeJson<ArticleModel>(json);
  }
}

mixin ArticleModelMappable {
  String toJson() {
    return ArticleModelMapper.ensureInitialized().encodeJson<ArticleModel>(
      this as ArticleModel,
    );
  }

  Map<String, dynamic> toMap() {
    return ArticleModelMapper.ensureInitialized().encodeMap<ArticleModel>(
      this as ArticleModel,
    );
  }

  ArticleModelCopyWith<ArticleModel, ArticleModel, ArticleModel> get copyWith =>
      _ArticleModelCopyWithImpl<ArticleModel, ArticleModel>(
        this as ArticleModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ArticleModelMapper.ensureInitialized().stringifyValue(
      this as ArticleModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ArticleModelMapper.ensureInitialized().equalsValue(
      this as ArticleModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ArticleModelMapper.ensureInitialized().hashValue(
      this as ArticleModel,
    );
  }
}

extension ArticleModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ArticleModel, $Out> {
  ArticleModelCopyWith<$R, ArticleModel, $Out> get $asArticleModel =>
      $base.as((v, t, t2) => _ArticleModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ArticleModelCopyWith<$R, $In extends ArticleModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  RatingCopyWith<$R, Rating, Rating> get rating;
  $R call({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  });
  ArticleModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ArticleModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ArticleModel, $Out>
    implements ArticleModelCopyWith<$R, ArticleModel, $Out> {
  _ArticleModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ArticleModel> $mapper =
      ArticleModelMapper.ensureInitialized();
  @override
  RatingCopyWith<$R, Rating, Rating> get rating =>
      $value.rating.copyWith.$chain((v) => call(rating: v));
  @override
  $R call({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (price != null) #price: price,
      if (description != null) #description: description,
      if (category != null) #category: category,
      if (image != null) #image: image,
      if (rating != null) #rating: rating,
    }),
  );
  @override
  ArticleModel $make(CopyWithData data) => ArticleModel(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    price: data.get(#price, or: $value.price),
    description: data.get(#description, or: $value.description),
    category: data.get(#category, or: $value.category),
    image: data.get(#image, or: $value.image),
    rating: data.get(#rating, or: $value.rating),
  );

  @override
  ArticleModelCopyWith<$R2, ArticleModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ArticleModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RatingMapper extends ClassMapperBase<Rating> {
  RatingMapper._();

  static RatingMapper? _instance;
  static RatingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RatingMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Rating';

  static double _$rate(Rating v) => v.rate;
  static const Field<Rating, double> _f$rate = Field('rate', _$rate);
  static int _$count(Rating v) => v.count;
  static const Field<Rating, int> _f$count = Field('count', _$count);

  @override
  final MappableFields<Rating> fields = const {
    #rate: _f$rate,
    #count: _f$count,
  };

  static Rating _instantiate(DecodingData data) {
    return Rating(rate: data.dec(_f$rate), count: data.dec(_f$count));
  }

  @override
  final Function instantiate = _instantiate;

  static Rating fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Rating>(map);
  }

  static Rating fromJson(String json) {
    return ensureInitialized().decodeJson<Rating>(json);
  }
}

mixin RatingMappable {
  String toJson() {
    return RatingMapper.ensureInitialized().encodeJson<Rating>(this as Rating);
  }

  Map<String, dynamic> toMap() {
    return RatingMapper.ensureInitialized().encodeMap<Rating>(this as Rating);
  }

  RatingCopyWith<Rating, Rating, Rating> get copyWith =>
      _RatingCopyWithImpl<Rating, Rating>(this as Rating, $identity, $identity);
  @override
  String toString() {
    return RatingMapper.ensureInitialized().stringifyValue(this as Rating);
  }

  @override
  bool operator ==(Object other) {
    return RatingMapper.ensureInitialized().equalsValue(this as Rating, other);
  }

  @override
  int get hashCode {
    return RatingMapper.ensureInitialized().hashValue(this as Rating);
  }
}

extension RatingValueCopy<$R, $Out> on ObjectCopyWith<$R, Rating, $Out> {
  RatingCopyWith<$R, Rating, $Out> get $asRating =>
      $base.as((v, t, t2) => _RatingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RatingCopyWith<$R, $In extends Rating, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? rate, int? count});
  RatingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RatingCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Rating, $Out>
    implements RatingCopyWith<$R, Rating, $Out> {
  _RatingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Rating> $mapper = RatingMapper.ensureInitialized();
  @override
  $R call({double? rate, int? count}) => $apply(
    FieldCopyWithData({
      if (rate != null) #rate: rate,
      if (count != null) #count: count,
    }),
  );
  @override
  Rating $make(CopyWithData data) => Rating(
    rate: data.get(#rate, or: $value.rate),
    count: data.get(#count, or: $value.count),
  );

  @override
  RatingCopyWith<$R2, Rating, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RatingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

