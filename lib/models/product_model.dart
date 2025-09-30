import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  String? name;
  String? description;
  int? price;
  int? rating;
  int? reviewsCount;
  String? imageUrl;
  String? id;

  ProductModel(
      {this.name,
      this.description,
      this.price,
      this.rating,
      this.reviewsCount,
      this.imageUrl,
      this.id});

 // JSON → Model
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  // Model → JSON
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
  

  ProductModel copyWith({
    String? name,
    String? description,
    int? price,
    int? rating,
    int? reviewsCount,
    String? imageUrl,
    String? id,
  }) {
    return ProductModel(name: name ?? this.name, description: description ?? this.description, price: price ?? this.price, rating: rating ?? this.rating, reviewsCount: reviewsCount ?? this.reviewsCount, imageUrl: imageUrl ?? this.imageUrl);
  }


  @override
  // TODO: implement props
  List<Object?> get props => [name, description, price, rating, reviewsCount, imageUrl, id];
}