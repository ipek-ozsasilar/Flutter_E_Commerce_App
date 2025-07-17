import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_model.g.dart';

@JsonSerializable()
class VersionModel extends Equatable {
  final String number;
  
  const VersionModel({
    required this.number,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) =>
      _$VersionModelFromJson(json);

  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
  
  @override
  List<Object?> get props => [number];

  VersionModel copyWith({
    String? number,
  }) {
    return VersionModel(
      number: number ?? this.number,
    );
  }


 
}