import 'package:dart_mappable/dart_mappable.dart';

part 'article_model.mapper.dart';

@MappableClass()
class ArticleModel with ArticleModelMappable {
  const ArticleModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  static const fromJson = ArticleModelMapper.fromMap;

}

@MappableClass()
class Rating with RatingMappable {
  const Rating({required this.rate, required this.count});

  final double rate;
  final int count;
}
