import '../entities/track_entity.dart';
import '../entities/album_entity.dart';
import '../entities/artist_entity.dart';
import '../entities/playlist_entity.dart';

abstract class SearchSourceDriver {
  String get platformId;
  Future<List<TrackEntity>> searchTracks(String query, {int limit = 20});
  Future<List<AlbumEntity>> searchAlbums(String query, {int limit = 20});
  Future<List<ArtistEntity>> searchArtists(String query, {int limit = 20});
  Future<List<PlaylistEntity>> searchPlaylists(String query, {int limit = 20});
}
