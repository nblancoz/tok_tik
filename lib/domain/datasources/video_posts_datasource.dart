import 'package:tok_tik/domain/entities/video_post.dart';

abstract class VideoPostsDatasource {
  Future<List<VideoPost>> getFavoriteVideosByUser(String userId);

  Future<List<VideoPost>> getTrendingVideosByPage(int page);
}
