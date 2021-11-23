import 'package:clean_arch/features/album/domain/entities/album.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable(explicitToJson: true)
class AlbumModel extends Album {
  final int? userId;
  final int? id;
  final String? title;

  const AlbumModel({
    this.userId,
    this.id,
    this.title,
  }) : super(userId: userId, id: id, title: title);

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);

  @override
  String toString() => 'Album { userId: $userId, id: $id, title: $title }';

  @override
  List<Object?> get props => [userId, id, title];
}
