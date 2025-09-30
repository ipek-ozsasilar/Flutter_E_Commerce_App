// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCardModel _$AddCardModelFromJson(Map<String, dynamic> json) => AddCardModel(
  name: json['name'] as String?,
  number: (json['number'] as num?)?.toInt(),
  expiry: json['expiry'] as String?,
  cvv: (json['cvv'] as num?)?.toInt(),
  id: json['id'] as String?,
);

Map<String, dynamic> _$AddCardModelToJson(AddCardModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'expiry': instance.expiry,
      'cvv': instance.cvv,
    };
