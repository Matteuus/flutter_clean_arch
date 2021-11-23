import 'package:clean_arch/features/album/domain/entities/album.dart';
import 'package:equatable/equatable.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();
}

class EmptyState extends AlbumState {
  @override
  List<Object> get props => [];
}

class InitialState extends AlbumState {
  const InitialState();
  @override
  List<Object> get props => [];
}

class LoadingState extends AlbumState {
  const LoadingState();
  @override
  List<Object> get props => [];
}

class LoadedSucessState extends AlbumState {
  final List<Album> album;
  const LoadedSucessState(this.album);

  @override
  List<Object> get props => [album];
}

class ErrorState extends AlbumState {
  final String message;
  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
