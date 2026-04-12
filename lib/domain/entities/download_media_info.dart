import 'package:equatable/equatable.dart';
import 'package:vidmate_clone_app/domain/entities/stream_info.dart';

class DownloadMediaInfo extends Equatable {
  final String id;
  final String title;
  final String? author;
  final String? thumbnailUrl;
  final Duration? duration;
  final List<StreamInfo> streams;
  final String sourceUrl;

  const DownloadMediaInfo({
    required this.id,
    required this.title,
    this.author,
    this.thumbnailUrl,
    this.duration,
    required this.streams,
    required this.sourceUrl,
  });

  @override
  List<Object?> get props => [id, title, author, thumbnailUrl, duration, streams, sourceUrl];
}
