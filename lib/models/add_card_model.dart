import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_card_model.g.dart';

@JsonSerializable()
class AddCardModel extends Equatable {
  int? number;
  String? name;
  String? id;
  String? expiry;
  int? cvv;

  AddCardModel({
    this.name,
    this.number,
    this.expiry,
    this.cvv,
    this.id,
  });

  // JSON → Model
  factory AddCardModel.fromJson(Map<String, dynamic> json) =>
      _$AddCardModelFromJson(json);

  // Model → JSON
  Map<String, dynamic> toJon() => _$AddCardModelToJson(this);

  AddCardModel copyWith({
    String? name,
    String? expiry,
    int? cvv,
    int? number,
    String? id,

  }) {
    return AddCardModel(
      name: name ?? this.name,
      expiry: expiry ?? this.expiry,
      number: number ?? this.number,
      cvv: cvv ?? this.cvv,
      id: id ?? this.id,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    name,
    expiry,
    number,
    cvv,
    id,
  ];
}
