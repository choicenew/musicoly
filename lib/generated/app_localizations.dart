import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @browse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get browse;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @lyrics.
  ///
  /// In en, this message translates to:
  /// **'Lyrics'**
  String get lyrics;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @genre_categories_filter.
  ///
  /// In en, this message translates to:
  /// **'Filter categories or genres...'**
  String get genre_categories_filter;

  /// No description provided for @genre.
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get genre;

  /// No description provided for @personalized.
  ///
  /// In en, this message translates to:
  /// **'Personalized'**
  String get personalized;

  /// No description provided for @featured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// No description provided for @new_releases.
  ///
  /// In en, this message translates to:
  /// **'New Releases'**
  String get new_releases;

  /// No description provided for @songs.
  ///
  /// In en, this message translates to:
  /// **'Songs'**
  String get songs;

  /// No description provided for @playing_track.
  ///
  /// In en, this message translates to:
  /// **'Playing {track}'**
  String playing_track(Object track);

  /// No description provided for @queue_clear_alert.
  ///
  /// In en, this message translates to:
  /// **'This will clear the current queue. {track_length} tracks will be removed\nDo you want to continue?'**
  String queue_clear_alert(Object track_length);

  /// No description provided for @load_more.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get load_more;

  /// No description provided for @playlists.
  ///
  /// In en, this message translates to:
  /// **'Playlists'**
  String get playlists;

  /// No description provided for @artists.
  ///
  /// In en, this message translates to:
  /// **'Artists'**
  String get artists;

  /// No description provided for @albums.
  ///
  /// In en, this message translates to:
  /// **'Albums'**
  String get albums;

  /// No description provided for @tracks.
  ///
  /// In en, this message translates to:
  /// **'Tracks'**
  String get tracks;

  /// No description provided for @downloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloads;

  /// No description provided for @filter_playlists.
  ///
  /// In en, this message translates to:
  /// **'Filter your playlists...'**
  String get filter_playlists;

  /// No description provided for @liked_tracks.
  ///
  /// In en, this message translates to:
  /// **'Liked Tracks'**
  String get liked_tracks;

  /// No description provided for @liked_tracks_description.
  ///
  /// In en, this message translates to:
  /// **'All your liked tracks'**
  String get liked_tracks_description;

  /// No description provided for @create_playlist.
  ///
  /// In en, this message translates to:
  /// **'Create Playlist'**
  String get create_playlist;

  /// No description provided for @create_a_playlist.
  ///
  /// In en, this message translates to:
  /// **'Create a playlist'**
  String get create_a_playlist;

  /// No description provided for @update_playlist.
  ///
  /// In en, this message translates to:
  /// **'Update playlist'**
  String get update_playlist;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @playlist_name.
  ///
  /// In en, this message translates to:
  /// **'Playlist Name'**
  String get playlist_name;

  /// No description provided for @name_of_playlist.
  ///
  /// In en, this message translates to:
  /// **'Name of the playlist'**
  String get name_of_playlist;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get public;

  /// No description provided for @collaborative.
  ///
  /// In en, this message translates to:
  /// **'Collaborative'**
  String get collaborative;

  /// No description provided for @search_local_tracks.
  ///
  /// In en, this message translates to:
  /// **'Search local tracks...'**
  String get search_local_tracks;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @sort_a_z.
  ///
  /// In en, this message translates to:
  /// **'Sort by A-Z'**
  String get sort_a_z;

  /// No description provided for @sort_z_a.
  ///
  /// In en, this message translates to:
  /// **'Sort by Z-A'**
  String get sort_z_a;

  /// No description provided for @sort_artist.
  ///
  /// In en, this message translates to:
  /// **'Sort by Artist'**
  String get sort_artist;

  /// No description provided for @sort_album.
  ///
  /// In en, this message translates to:
  /// **'Sort by Album'**
  String get sort_album;

  /// No description provided for @sort_duration.
  ///
  /// In en, this message translates to:
  /// **'Sort by Duration'**
  String get sort_duration;

  /// No description provided for @sort_tracks.
  ///
  /// In en, this message translates to:
  /// **'Sort Tracks'**
  String get sort_tracks;

  /// No description provided for @currently_downloading.
  ///
  /// In en, this message translates to:
  /// **'Currently Downloading ({tracks_length})'**
  String currently_downloading(Object tracks_length);

  /// No description provided for @cancel_all.
  ///
  /// In en, this message translates to:
  /// **'Cancel All'**
  String get cancel_all;

  /// No description provided for @filter_artist.
  ///
  /// In en, this message translates to:
  /// **'Filter artists...'**
  String get filter_artist;

  /// No description provided for @followers.
  ///
  /// In en, this message translates to:
  /// **'{followers} Followers'**
  String followers(Object followers);

  /// No description provided for @add_artist_to_blacklist.
  ///
  /// In en, this message translates to:
  /// **'Add artist to blacklist'**
  String get add_artist_to_blacklist;

  /// No description provided for @top_tracks.
  ///
  /// In en, this message translates to:
  /// **'Top Tracks'**
  String get top_tracks;

  /// No description provided for @fans_also_like.
  ///
  /// In en, this message translates to:
  /// **'Fans also like'**
  String get fans_also_like;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @loading_album.
  ///
  /// In en, this message translates to:
  /// **'Loading album...'**
  String get loading_album;

  /// No description provided for @loading_artist.
  ///
  /// In en, this message translates to:
  /// **'Loading artist...'**
  String get loading_artist;

  /// No description provided for @album_not_found.
  ///
  /// In en, this message translates to:
  /// **'Album not found'**
  String get album_not_found;

  /// No description provided for @album_not_found_hint.
  ///
  /// In en, this message translates to:
  /// **'The album you\'re looking for doesn\'t exist or has been removed.'**
  String get album_not_found_hint;

  /// No description provided for @artist_not_found.
  ///
  /// In en, this message translates to:
  /// **'Artist not found'**
  String get artist_not_found;

  /// No description provided for @artist_not_found_hint.
  ///
  /// In en, this message translates to:
  /// **'The artist you are looking for could not be found'**
  String get artist_not_found_hint;

  /// No description provided for @unknown_release_date.
  ///
  /// In en, this message translates to:
  /// **'Unknown release date'**
  String get unknown_release_date;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @album_details.
  ///
  /// In en, this message translates to:
  /// **'Album Details'**
  String get album_details;

  /// No description provided for @no_tracks_available.
  ///
  /// In en, this message translates to:
  /// **'No tracks available'**
  String get no_tracks_available;

  /// No description provided for @no_albums_available.
  ///
  /// In en, this message translates to:
  /// **'No albums available'**
  String get no_albums_available;

  /// No description provided for @no_related_artists_found.
  ///
  /// In en, this message translates to:
  /// **'No related artists found'**
  String get no_related_artists_found;

  /// No description provided for @popular_tracks.
  ///
  /// In en, this message translates to:
  /// **'Popular Tracks'**
  String get popular_tracks;

  /// No description provided for @see_all_tracks.
  ///
  /// In en, this message translates to:
  /// **'See All Tracks'**
  String get see_all_tracks;

  /// No description provided for @all_tracks.
  ///
  /// In en, this message translates to:
  /// **'All Tracks'**
  String get all_tracks;

  /// No description provided for @songs_count.
  ///
  /// In en, this message translates to:
  /// **'{count} songs'**
  String songs_count(Object count);

  /// No description provided for @artist.
  ///
  /// In en, this message translates to:
  /// **'Artist'**
  String get artist;

  /// No description provided for @blacklisted.
  ///
  /// In en, this message translates to:
  /// **'Blacklisted'**
  String get blacklisted;

  /// No description provided for @following.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @artist_url_copied.
  ///
  /// In en, this message translates to:
  /// **'Artist URL copied to clipboard'**
  String get artist_url_copied;

  /// No description provided for @added_to_queue.
  ///
  /// In en, this message translates to:
  /// **'Added {tracks} tracks to queue'**
  String added_to_queue(Object tracks);

  /// No description provided for @filter_albums.
  ///
  /// In en, this message translates to:
  /// **'Filter albums...'**
  String get filter_albums;

  /// No description provided for @synced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get synced;

  /// No description provided for @plain.
  ///
  /// In en, this message translates to:
  /// **'Plain'**
  String get plain;

  /// No description provided for @shuffle.
  ///
  /// In en, this message translates to:
  /// **'Shuffle'**
  String get shuffle;

  /// No description provided for @search_tracks.
  ///
  /// In en, this message translates to:
  /// **'Search tracks...'**
  String get search_tracks;

  /// No description provided for @released.
  ///
  /// In en, this message translates to:
  /// **'Released'**
  String get released;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error {error}'**
  String error(Object error);

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @more_actions.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get more_actions;

  /// No description provided for @download_count.
  ///
  /// In en, this message translates to:
  /// **'Download ({count})'**
  String download_count(Object count);

  /// No description provided for @add_count_to_playlist.
  ///
  /// In en, this message translates to:
  /// **'Add ({count}) to Playlist'**
  String add_count_to_playlist(Object count);

  /// No description provided for @add_count_to_queue.
  ///
  /// In en, this message translates to:
  /// **'Add ({count}) to Queue'**
  String add_count_to_queue(Object count);

  /// No description provided for @play_count_next.
  ///
  /// In en, this message translates to:
  /// **'Play ({count}) next'**
  String play_count_next(Object count);

  /// No description provided for @album.
  ///
  /// In en, this message translates to:
  /// **'Album'**
  String get album;

  /// No description provided for @copied_to_clipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied {data} to clipboard'**
  String copied_to_clipboard(Object data);

  /// No description provided for @add_to_following_playlists.
  ///
  /// In en, this message translates to:
  /// **'Add {track} to following Playlists'**
  String add_to_following_playlists(Object track);

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @added_track_to_queue.
  ///
  /// In en, this message translates to:
  /// **'Added {track} to queue'**
  String added_track_to_queue(Object track);

  /// No description provided for @add_to_queue.
  ///
  /// In en, this message translates to:
  /// **'Add to queue'**
  String get add_to_queue;

  /// No description provided for @track_will_play_next.
  ///
  /// In en, this message translates to:
  /// **'{track} will play next'**
  String track_will_play_next(Object track);

  /// No description provided for @play_next.
  ///
  /// In en, this message translates to:
  /// **'Play next'**
  String get play_next;

  /// No description provided for @removed_track_from_queue.
  ///
  /// In en, this message translates to:
  /// **'Removed {track} from queue'**
  String removed_track_from_queue(Object track);

  /// No description provided for @remove_from_queue.
  ///
  /// In en, this message translates to:
  /// **'Remove from queue'**
  String get remove_from_queue;

  /// No description provided for @remove_from_favorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get remove_from_favorites;

  /// No description provided for @save_as_favorite.
  ///
  /// In en, this message translates to:
  /// **'Save as favorite'**
  String get save_as_favorite;

  /// No description provided for @add_to_playlist.
  ///
  /// In en, this message translates to:
  /// **'Add to playlist'**
  String get add_to_playlist;

  /// No description provided for @remove_from_playlist.
  ///
  /// In en, this message translates to:
  /// **'Remove from playlist'**
  String get remove_from_playlist;

  /// No description provided for @add_to_blacklist.
  ///
  /// In en, this message translates to:
  /// **'Add to blacklist'**
  String get add_to_blacklist;

  /// No description provided for @remove_from_blacklist.
  ///
  /// In en, this message translates to:
  /// **'Remove from blacklist'**
  String get remove_from_blacklist;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @mini_player.
  ///
  /// In en, this message translates to:
  /// **'Mini Player'**
  String get mini_player;

  /// No description provided for @slide_to_seek.
  ///
  /// In en, this message translates to:
  /// **'Slide to seek forward or backward'**
  String get slide_to_seek;

  /// No description provided for @shuffle_playlist.
  ///
  /// In en, this message translates to:
  /// **'Shuffle playlist'**
  String get shuffle_playlist;

  /// No description provided for @unshuffle_playlist.
  ///
  /// In en, this message translates to:
  /// **'Unshuffle playlist'**
  String get unshuffle_playlist;

  /// No description provided for @previous_track.
  ///
  /// In en, this message translates to:
  /// **'Previous track'**
  String get previous_track;

  /// No description provided for @next_track.
  ///
  /// In en, this message translates to:
  /// **'Next track'**
  String get next_track;

  /// No description provided for @pause_playback.
  ///
  /// In en, this message translates to:
  /// **'Pause Playback'**
  String get pause_playback;

  /// No description provided for @resume_playback.
  ///
  /// In en, this message translates to:
  /// **'Resume Playback'**
  String get resume_playback;

  /// No description provided for @loop_track.
  ///
  /// In en, this message translates to:
  /// **'Loop track'**
  String get loop_track;

  /// No description provided for @repeat_playlist.
  ///
  /// In en, this message translates to:
  /// **'Repeat playlist'**
  String get repeat_playlist;

  /// No description provided for @queue.
  ///
  /// In en, this message translates to:
  /// **'Queue'**
  String get queue;

  /// No description provided for @alternative_track_sources.
  ///
  /// In en, this message translates to:
  /// **'Alternative track sources'**
  String get alternative_track_sources;

  /// No description provided for @download_track.
  ///
  /// In en, this message translates to:
  /// **'Download track'**
  String get download_track;

  /// No description provided for @tracks_in_queue.
  ///
  /// In en, this message translates to:
  /// **'{tracks} tracks in queue'**
  String tracks_in_queue(Object tracks);

  /// No description provided for @clear_all.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clear_all;

  /// No description provided for @show_hide_ui_on_hover.
  ///
  /// In en, this message translates to:
  /// **'Show/Hide UI on hover'**
  String get show_hide_ui_on_hover;

  /// No description provided for @always_on_top.
  ///
  /// In en, this message translates to:
  /// **'Always on top'**
  String get always_on_top;

  /// No description provided for @exit_mini_player.
  ///
  /// In en, this message translates to:
  /// **'Exit Mini player'**
  String get exit_mini_player;

  /// No description provided for @download_location.
  ///
  /// In en, this message translates to:
  /// **'Download location'**
  String get download_location;

  /// No description provided for @local_library.
  ///
  /// In en, this message translates to:
  /// **'Local library'**
  String get local_library;

  /// No description provided for @add_library_location.
  ///
  /// In en, this message translates to:
  /// **'Add to library'**
  String get add_library_location;

  /// No description provided for @remove_library_location.
  ///
  /// In en, this message translates to:
  /// **'Remove from library'**
  String get remove_library_location;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @login_with_spotify.
  ///
  /// In en, this message translates to:
  /// **'Login with your Spotify account'**
  String get login_with_spotify;

  /// No description provided for @connect_with_spotify.
  ///
  /// In en, this message translates to:
  /// **'Connect with Spotify'**
  String get connect_with_spotify;

  /// No description provided for @connect_with_youtube.
  ///
  /// In en, this message translates to:
  /// **'Connect with Youtube'**
  String get connect_with_youtube;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logout_of_this_account.
  ///
  /// In en, this message translates to:
  /// **'Logout of this account'**
  String get logout_of_this_account;

  /// No description provided for @language_region.
  ///
  /// In en, this message translates to:
  /// **'Language & Region'**
  String get language_region;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @language_settings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get language_settings;

  /// No description provided for @timeZone.
  ///
  /// In en, this message translates to:
  /// **'Time Zone'**
  String get timeZone;

  /// No description provided for @timeFormat.
  ///
  /// In en, this message translates to:
  /// **'Time Format'**
  String get timeFormat;

  /// No description provided for @use24HourFormat.
  ///
  /// In en, this message translates to:
  /// **'Use 24-hour Format'**
  String get use24HourFormat;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @current_language.
  ///
  /// In en, this message translates to:
  /// **'Current Language'**
  String get current_language;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @failed_to_load_language_settings.
  ///
  /// In en, this message translates to:
  /// **'Failed to load language settings'**
  String get failed_to_load_language_settings;

  /// No description provided for @system_default.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get system_default;

  /// No description provided for @market_place_region.
  ///
  /// In en, this message translates to:
  /// **'Marketplace Region'**
  String get market_place_region;

  /// No description provided for @recommendation_country.
  ///
  /// In en, this message translates to:
  /// **'Recommendation Country'**
  String get recommendation_country;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @layout_mode.
  ///
  /// In en, this message translates to:
  /// **'Layout Mode'**
  String get layout_mode;

  /// No description provided for @override_layout_settings.
  ///
  /// In en, this message translates to:
  /// **'Override responsive layout mode settings'**
  String get override_layout_settings;

  /// No description provided for @adaptive.
  ///
  /// In en, this message translates to:
  /// **'Adaptive'**
  String get adaptive;

  /// No description provided for @compact.
  ///
  /// In en, this message translates to:
  /// **'Compact'**
  String get compact;

  /// No description provided for @extended.
  ///
  /// In en, this message translates to:
  /// **'Extended'**
  String get extended;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @accent_color.
  ///
  /// In en, this message translates to:
  /// **'Accent Color'**
  String get accent_color;

  /// No description provided for @sync_album_color.
  ///
  /// In en, this message translates to:
  /// **'Sync album color'**
  String get sync_album_color;

  /// No description provided for @sync_album_color_description.
  ///
  /// In en, this message translates to:
  /// **'Uses the dominant color of the album art as the accent color'**
  String get sync_album_color_description;

  /// No description provided for @playback.
  ///
  /// In en, this message translates to:
  /// **'Playback'**
  String get playback;

  /// No description provided for @audio_quality.
  ///
  /// In en, this message translates to:
  /// **'Audio Quality'**
  String get audio_quality;

  /// No description provided for @select_audio_quality.
  ///
  /// In en, this message translates to:
  /// **'Select audio playback quality'**
  String get select_audio_quality;

  /// No description provided for @low_quality.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low_quality;

  /// No description provided for @medium_quality.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium_quality;

  /// No description provided for @high_quality.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high_quality;

  /// No description provided for @crossfade.
  ///
  /// In en, this message translates to:
  /// **'Crossfade'**
  String get crossfade;

  /// No description provided for @crossfade_description.
  ///
  /// In en, this message translates to:
  /// **'Set transition effect between songs'**
  String get crossfade_description;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'{count} Seconds'**
  String seconds(Object count);

  /// No description provided for @download_path.
  ///
  /// In en, this message translates to:
  /// **'Download Path'**
  String get download_path;

  /// No description provided for @download_format.
  ///
  /// In en, this message translates to:
  /// **'Download Format'**
  String get download_format;

  /// No description provided for @download_lyrics.
  ///
  /// In en, this message translates to:
  /// **'Download Lyrics'**
  String get download_lyrics;

  /// No description provided for @download_lyrics_description.
  ///
  /// In en, this message translates to:
  /// **'Download lyric files along with songs'**
  String get download_lyrics_description;

  /// No description provided for @download_cover.
  ///
  /// In en, this message translates to:
  /// **'Download Cover'**
  String get download_cover;

  /// No description provided for @download_cover_description.
  ///
  /// In en, this message translates to:
  /// **'Download cover images along with songs'**
  String get download_cover_description;

  /// No description provided for @file_naming_format.
  ///
  /// In en, this message translates to:
  /// **'File Naming Format'**
  String get file_naming_format;

  /// No description provided for @file_naming_format_description.
  ///
  /// In en, this message translates to:
  /// **'Set naming rules for downloaded files'**
  String get file_naming_format_description;

  /// No description provided for @song_title.
  ///
  /// In en, this message translates to:
  /// **'Song Title'**
  String get song_title;

  /// No description provided for @artist_song_title.
  ///
  /// In en, this message translates to:
  /// **'Artist - Song Title'**
  String get artist_song_title;

  /// No description provided for @song_title_artist.
  ///
  /// In en, this message translates to:
  /// **'Song Title - Artist'**
  String get song_title_artist;

  /// No description provided for @album_track_song_title.
  ///
  /// In en, this message translates to:
  /// **'Album - Track - Song Title'**
  String get album_track_song_title;

  /// No description provided for @desktop.
  ///
  /// In en, this message translates to:
  /// **'Desktop'**
  String get desktop;

  /// No description provided for @auto_start.
  ///
  /// In en, this message translates to:
  /// **'Auto-start on boot'**
  String get auto_start;

  /// No description provided for @auto_start_description.
  ///
  /// In en, this message translates to:
  /// **'Run app automatically when system starts'**
  String get auto_start_description;

  /// No description provided for @minimize_to_tray.
  ///
  /// In en, this message translates to:
  /// **'Minimize to Tray'**
  String get minimize_to_tray;

  /// No description provided for @minimize_to_tray_description.
  ///
  /// In en, this message translates to:
  /// **'Minimize to system tray instead of exiting when closing window'**
  String get minimize_to_tray_description;

  /// No description provided for @media_key_control.
  ///
  /// In en, this message translates to:
  /// **'Media Key Control'**
  String get media_key_control;

  /// No description provided for @media_key_control_description.
  ///
  /// In en, this message translates to:
  /// **'Control playback using keyboard media keys'**
  String get media_key_control_description;

  /// No description provided for @system_notifications.
  ///
  /// In en, this message translates to:
  /// **'System Notifications'**
  String get system_notifications;

  /// No description provided for @system_notifications_description.
  ///
  /// In en, this message translates to:
  /// **'Show system notifications for track changes etc.'**
  String get system_notifications_description;

  /// No description provided for @shortcut_settings.
  ///
  /// In en, this message translates to:
  /// **'Shortcut Settings'**
  String get shortcut_settings;

  /// No description provided for @shortcut_settings_description.
  ///
  /// In en, this message translates to:
  /// **'Customize global shortcuts'**
  String get shortcut_settings_description;

  /// No description provided for @set.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get set;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @pre_download_play.
  ///
  /// In en, this message translates to:
  /// **'Pre-download and play'**
  String get pre_download_play;

  /// No description provided for @pre_download_play_description.
  ///
  /// In en, this message translates to:
  /// **'Instead of streaming audio, download bytes and play instead (Recommended for higher bandwidth users)'**
  String get pre_download_play_description;

  /// No description provided for @skip_non_music.
  ///
  /// In en, this message translates to:
  /// **'Skip non-music segments (SponsorBlock)'**
  String get skip_non_music;

  /// No description provided for @blacklist_description.
  ///
  /// In en, this message translates to:
  /// **'Blacklisted tracks and artists'**
  String get blacklist_description;

  /// No description provided for @equalizer.
  ///
  /// In en, this message translates to:
  /// **'Equalizer'**
  String get equalizer;

  /// No description provided for @sleep_timer.
  ///
  /// In en, this message translates to:
  /// **'Sleep Timer'**
  String get sleep_timer;

  /// No description provided for @sleep_timer_description.
  ///
  /// In en, this message translates to:
  /// **'Stop playback after a set time'**
  String get sleep_timer_description;

  /// No description provided for @minutes_remaining.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes remaining'**
  String minutes_remaining(Object minutes);

  /// No description provided for @go_to_album.
  ///
  /// In en, this message translates to:
  /// **'Go to Album'**
  String get go_to_album;

  /// No description provided for @go_to_artist.
  ///
  /// In en, this message translates to:
  /// **'Go to Artist'**
  String get go_to_artist;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @not_connected.
  ///
  /// In en, this message translates to:
  /// **'Not Connected'**
  String get not_connected;

  /// No description provided for @scrobbler.
  ///
  /// In en, this message translates to:
  /// **'Scrobbler'**
  String get scrobbler;

  /// No description provided for @lastfm_scrobbler.
  ///
  /// In en, this message translates to:
  /// **'Last.fm Scrobbler'**
  String get lastfm_scrobbler;

  /// No description provided for @wait_for_download_to_finish.
  ///
  /// In en, this message translates to:
  /// **'Please wait for the current download to finish'**
  String get wait_for_download_to_finish;

  /// No description provided for @local_music.
  ///
  /// In en, this message translates to:
  /// **'Local Music'**
  String get local_music;

  /// No description provided for @recently_added.
  ///
  /// In en, this message translates to:
  /// **'Recently Added'**
  String get recently_added;

  /// No description provided for @most_played.
  ///
  /// In en, this message translates to:
  /// **'Most Played'**
  String get most_played;

  /// No description provided for @shuffle_all.
  ///
  /// In en, this message translates to:
  /// **'Shuffle All'**
  String get shuffle_all;

  /// No description provided for @play_all.
  ///
  /// In en, this message translates to:
  /// **'Play All'**
  String get play_all;

  /// No description provided for @scan_local_music.
  ///
  /// In en, this message translates to:
  /// **'Scan Local Music'**
  String get scan_local_music;

  /// No description provided for @scanning.
  ///
  /// In en, this message translates to:
  /// **'Scanning...'**
  String get scanning;

  /// No description provided for @no_playlists.
  ///
  /// In en, this message translates to:
  /// **'No playlists found'**
  String get no_playlists;

  /// No description provided for @track_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No tracks} =1{1 track} other{{count} tracks}}'**
  String track_count(num count);

  /// No description provided for @edit_tags.
  ///
  /// In en, this message translates to:
  /// **'Edit Tags'**
  String get edit_tags;

  /// No description provided for @added_to_playlist.
  ///
  /// In en, this message translates to:
  /// **'Added to playlist'**
  String get added_to_playlist;

  /// No description provided for @confirm_delete_tracks.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} tracks from your library?'**
  String confirm_delete_tracks(Object count);

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @close_behavior.
  ///
  /// In en, this message translates to:
  /// **'Close Behavior'**
  String get close_behavior;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @show_tray_icon.
  ///
  /// In en, this message translates to:
  /// **'Show System tray icon'**
  String get show_tray_icon;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @u_love_pyro_music.
  ///
  /// In en, this message translates to:
  /// **'We know you love Pyro Music'**
  String get u_love_pyro_music;

  /// No description provided for @version_info.
  ///
  /// In en, this message translates to:
  /// **'Version Info'**
  String get version_info;

  /// No description provided for @failed_to_check_for_updates.
  ///
  /// In en, this message translates to:
  /// **'Failed to check for updates'**
  String get failed_to_check_for_updates;

  /// No description provided for @import_cookie.
  ///
  /// In en, this message translates to:
  /// **'Import Cookie'**
  String get import_cookie;

  /// No description provided for @import_cookie_description.
  ///
  /// In en, this message translates to:
  /// **'Import authentication from file'**
  String get import_cookie_description;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @export_cookie.
  ///
  /// In en, this message translates to:
  /// **'Export Cookie'**
  String get export_cookie;

  /// No description provided for @export_cookie_description.
  ///
  /// In en, this message translates to:
  /// **'Export authentication to file'**
  String get export_cookie_description;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @clear_cookie.
  ///
  /// In en, this message translates to:
  /// **'Clear Cookie'**
  String get clear_cookie;

  /// No description provided for @clear_cookie_description.
  ///
  /// In en, this message translates to:
  /// **'Clear all authentication'**
  String get clear_cookie_description;

  /// No description provided for @show_plain_lyrics.
  ///
  /// In en, this message translates to:
  /// **'Show plain lyrics'**
  String get show_plain_lyrics;

  /// No description provided for @show_synced_lyrics.
  ///
  /// In en, this message translates to:
  /// **'Show synced lyrics'**
  String get show_synced_lyrics;

  /// No description provided for @exit_edit_mode.
  ///
  /// In en, this message translates to:
  /// **'Exit edit mode'**
  String get exit_edit_mode;

  /// No description provided for @enter_edit_mode.
  ///
  /// In en, this message translates to:
  /// **'Enter edit mode'**
  String get enter_edit_mode;

  /// No description provided for @export_lyrics.
  ///
  /// In en, this message translates to:
  /// **'Export lyrics'**
  String get export_lyrics;

  /// No description provided for @import_lyrics.
  ///
  /// In en, this message translates to:
  /// **'Import lyrics'**
  String get import_lyrics;

  /// No description provided for @search_lyrics.
  ///
  /// In en, this message translates to:
  /// **'Search lyrics'**
  String get search_lyrics;

  /// No description provided for @lyrics_settings.
  ///
  /// In en, this message translates to:
  /// **'Lyrics settings'**
  String get lyrics_settings;

  /// No description provided for @no_track_playing.
  ///
  /// In en, this message translates to:
  /// **'No track playing'**
  String get no_track_playing;

  /// No description provided for @login_error.
  ///
  /// In en, this message translates to:
  /// **'Login Error'**
  String get login_error;

  /// No description provided for @failed_to_get_auth_service.
  ///
  /// In en, this message translates to:
  /// **'Failed to get auth service for {platform}'**
  String failed_to_get_auth_service(Object platform);

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login failed: {error}'**
  String login_failed(Object error);

  /// No description provided for @welcome_to_pyro_music.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Pyro Music'**
  String get welcome_to_pyro_music;

  /// No description provided for @let_us_configure_first.
  ///
  /// In en, this message translates to:
  /// **'Before we start, let\'s configure some basic settings'**
  String get let_us_configure_first;

  /// No description provided for @check_for_updates.
  ///
  /// In en, this message translates to:
  /// **'Check for updates'**
  String get check_for_updates;

  /// No description provided for @about_pyro_music.
  ///
  /// In en, this message translates to:
  /// **'About Pyro Music'**
  String get about_pyro_music;

  /// No description provided for @repository.
  ///
  /// In en, this message translates to:
  /// **'Repository'**
  String get repository;

  /// No description provided for @bug_issues.
  ///
  /// In en, this message translates to:
  /// **'Bug Issues'**
  String get bug_issues;

  /// No description provided for @license.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get license;

  /// No description provided for @pyro_music_description.
  ///
  /// In en, this message translates to:
  /// **'An open source music player built with Flutter'**
  String get pyro_music_description;

  /// No description provided for @blacklist.
  ///
  /// In en, this message translates to:
  /// **'Blacklist'**
  String get blacklist;

  /// No description provided for @please_sponsor.
  ///
  /// In en, this message translates to:
  /// **'Please Sponsor/Donate'**
  String get please_sponsor;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @build_number.
  ///
  /// In en, this message translates to:
  /// **'Build Number'**
  String get build_number;

  /// No description provided for @founder.
  ///
  /// In en, this message translates to:
  /// **'Founder'**
  String get founder;

  /// No description provided for @made_with.
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ in Bangladesh🇧🇩'**
  String get made_with;

  /// No description provided for @kingkor_roy_tirtho.
  ///
  /// In en, this message translates to:
  /// **'Kingkor Roy Tirtho'**
  String get kingkor_roy_tirtho;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2021-{current_year} Kingkor Roy Tirtho'**
  String copyright(Object current_year);

  /// No description provided for @add_spotify_credentials.
  ///
  /// In en, this message translates to:
  /// **'Add your spotify credentials to get started'**
  String get add_spotify_credentials;

  /// No description provided for @credentials_will_not_be_shared_disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry, any of your credentials won\'t be collected or shared with anyone'**
  String get credentials_will_not_be_shared_disclaimer;

  /// No description provided for @know_how_to_login.
  ///
  /// In en, this message translates to:
  /// **'Don\'t know how to do this?'**
  String get know_how_to_login;

  /// No description provided for @follow_step_by_step_guide.
  ///
  /// In en, this message translates to:
  /// **'Follow along the Step by Step guide'**
  String get follow_step_by_step_guide;

  /// No description provided for @spotify_cookie.
  ///
  /// In en, this message translates to:
  /// **'Spotify {name} Cookie'**
  String spotify_cookie(Object name);

  /// No description provided for @cookie_name_cookie.
  ///
  /// In en, this message translates to:
  /// **'{name} Cookie'**
  String cookie_name_cookie(Object name);

  /// No description provided for @fill_in_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all the fields'**
  String get fill_in_all_fields;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @step_1.
  ///
  /// In en, this message translates to:
  /// **'Step 1'**
  String get step_1;

  /// No description provided for @first_go_to.
  ///
  /// In en, this message translates to:
  /// **'First, Go to'**
  String get first_go_to;

  /// No description provided for @login_if_not_logged_in.
  ///
  /// In en, this message translates to:
  /// **'and Login/Signup if you are not logged in'**
  String get login_if_not_logged_in;

  /// No description provided for @export_logs.
  ///
  /// In en, this message translates to:
  /// **'Export Logs'**
  String get export_logs;

  /// No description provided for @export_logs_description.
  ///
  /// In en, this message translates to:
  /// **'Export application logs for debugging'**
  String get export_logs_description;

  /// No description provided for @scan_completed.
  ///
  /// In en, this message translates to:
  /// **'Scan Completed'**
  String get scan_completed;

  /// No description provided for @enable_equalizer.
  ///
  /// In en, this message translates to:
  /// **'Enable Equalizer'**
  String get enable_equalizer;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes'**
  String minutes(Object count);

  /// No description provided for @cancel_timer.
  ///
  /// In en, this message translates to:
  /// **'Cancel Timer'**
  String get cancel_timer;

  /// No description provided for @track_details.
  ///
  /// In en, this message translates to:
  /// **'Track Details'**
  String get track_details;

  /// No description provided for @added_to_playlist_success.
  ///
  /// In en, this message translates to:
  /// **'Added to {playlist}'**
  String added_to_playlist_success(Object playlist);

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @go_back.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get go_back;

  /// No description provided for @release_date.
  ///
  /// In en, this message translates to:
  /// **'Release Date'**
  String get release_date;

  /// No description provided for @see_all.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get see_all;

  /// No description provided for @followers_count.
  ///
  /// In en, this message translates to:
  /// **'{count} Followers'**
  String followers_count(Object count);

  /// No description provided for @featured_playlists.
  ///
  /// In en, this message translates to:
  /// **'Featured Playlists'**
  String get featured_playlists;

  /// No description provided for @no_featured_playlists.
  ///
  /// In en, this message translates to:
  /// **'No featured playlists available'**
  String get no_featured_playlists;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {username}'**
  String welcome_back(Object username);

  /// No description provided for @good_morning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get good_morning;

  /// No description provided for @good_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get good_afternoon;

  /// No description provided for @good_evening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get good_evening;

  /// No description provided for @recent_tracks.
  ///
  /// In en, this message translates to:
  /// **'Recent Tracks'**
  String get recent_tracks;

  /// No description provided for @no_recent_tracks.
  ///
  /// In en, this message translates to:
  /// **'No recent tracks'**
  String get no_recent_tracks;

  /// No description provided for @start_listening_hint.
  ///
  /// In en, this message translates to:
  /// **'Start listening to some music to see them here'**
  String get start_listening_hint;

  /// No description provided for @recommended_artists.
  ///
  /// In en, this message translates to:
  /// **'Recommended Artists'**
  String get recommended_artists;

  /// No description provided for @no_recommended_artists.
  ///
  /// In en, this message translates to:
  /// **'No recommended artists'**
  String get no_recommended_artists;

  /// No description provided for @login_with_lastfm.
  ///
  /// In en, this message translates to:
  /// **'Login with Last.fm'**
  String get login_with_lastfm;

  /// No description provided for @backup_restore.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get backup_restore;

  /// No description provided for @export_backup.
  ///
  /// In en, this message translates to:
  /// **'Export Backup'**
  String get export_backup;

  /// No description provided for @backup_description.
  ///
  /// In en, this message translates to:
  /// **'Export user preferences and data'**
  String get backup_description;

  /// No description provided for @backup_success.
  ///
  /// In en, this message translates to:
  /// **'Backup exported successfully'**
  String get backup_success;

  /// No description provided for @backup_failed.
  ///
  /// In en, this message translates to:
  /// **'Backup failed: {error}'**
  String backup_failed(Object error);

  /// No description provided for @import_backup.
  ///
  /// In en, this message translates to:
  /// **'Import Backup'**
  String get import_backup;

  /// No description provided for @restore_description.
  ///
  /// In en, this message translates to:
  /// **'Restore user preferences and data from file'**
  String get restore_description;

  /// No description provided for @restore_success.
  ///
  /// In en, this message translates to:
  /// **'Data restored successfully'**
  String get restore_success;

  /// No description provided for @restore_failed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String restore_failed(Object error);

  /// No description provided for @cookie_import_success.
  ///
  /// In en, this message translates to:
  /// **'Cookies imported successfully'**
  String get cookie_import_success;

  /// No description provided for @import_failed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String import_failed(Object error);

  /// No description provided for @cookie_export_success.
  ///
  /// In en, this message translates to:
  /// **'Cookies exported successfully'**
  String get cookie_export_success;

  /// No description provided for @export_failed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String export_failed(Object error);

  /// No description provided for @cookie_cleared.
  ///
  /// In en, this message translates to:
  /// **'Cookies cleared successfully'**
  String get cookie_cleared;

  /// No description provided for @clear_failed.
  ///
  /// In en, this message translates to:
  /// **'Clear failed: {error}'**
  String clear_failed(Object error);

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @repeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeat;

  /// No description provided for @cache_cleared.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared successfully'**
  String get cache_cleared;

  /// No description provided for @clearing_failed.
  ///
  /// In en, this message translates to:
  /// **'Clearing cache failed: {error}'**
  String clearing_failed(Object error);

  /// No description provided for @api_endpoint_config.
  ///
  /// In en, this message translates to:
  /// **'API Endpoint Configuration'**
  String get api_endpoint_config;

  /// No description provided for @api_server_address.
  ///
  /// In en, this message translates to:
  /// **'API Server Address'**
  String get api_server_address;

  /// No description provided for @no_logs_to_export.
  ///
  /// In en, this message translates to:
  /// **'No logs to export'**
  String get no_logs_to_export;

  /// No description provided for @logs_exported.
  ///
  /// In en, this message translates to:
  /// **'Logs exported to {path}'**
  String logs_exported(Object path);

  /// No description provided for @debug_mode.
  ///
  /// In en, this message translates to:
  /// **'Debug Mode'**
  String get debug_mode;

  /// No description provided for @debug_mode_description.
  ///
  /// In en, this message translates to:
  /// **'Enable extra diagnostic logs and UI overlays'**
  String get debug_mode_description;

  /// No description provided for @verbose_logging.
  ///
  /// In en, this message translates to:
  /// **'Verbose Logging'**
  String get verbose_logging;

  /// No description provided for @verbose_logging_description.
  ///
  /// In en, this message translates to:
  /// **'Log network and playback events in detail'**
  String get verbose_logging_description;

  /// No description provided for @use_default_server.
  ///
  /// In en, this message translates to:
  /// **'Use Default Server'**
  String get use_default_server;

  /// No description provided for @configure.
  ///
  /// In en, this message translates to:
  /// **'Configure'**
  String get configure;

  /// No description provided for @cache_management.
  ///
  /// In en, this message translates to:
  /// **'Cache Management'**
  String get cache_management;

  /// No description provided for @cache_management_description.
  ///
  /// In en, this message translates to:
  /// **'Manage disk cache and temporary files'**
  String get cache_management_description;

  /// No description provided for @scrobbler_description.
  ///
  /// In en, this message translates to:
  /// **'Scrobble played music to external tracking services'**
  String get scrobbler_description;

  /// No description provided for @no_results_found.
  ///
  /// In en, this message translates to:
  /// **'No results found for \"{query}\"'**
  String no_results_found(Object query);

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @developers_options.
  ///
  /// In en, this message translates to:
  /// **'Developer Options'**
  String get developers_options;

  /// No description provided for @cookie_management.
  ///
  /// In en, this message translates to:
  /// **'Cookie Management'**
  String get cookie_management;

  /// No description provided for @by_author.
  ///
  /// In en, this message translates to:
  /// **'By {author}'**
  String by_author(Object author);

  /// No description provided for @selected_count.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selected_count(Object count);

  /// No description provided for @queue_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Queue is empty'**
  String get queue_is_empty;

  /// No description provided for @add_tracks_to_get_started.
  ///
  /// In en, this message translates to:
  /// **'Add tracks to get started'**
  String get add_tracks_to_get_started;

  /// No description provided for @queue_count.
  ///
  /// In en, this message translates to:
  /// **'{count} tracks in queue'**
  String queue_count(Object count);

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @recently_played.
  ///
  /// In en, this message translates to:
  /// **'Recently Played'**
  String get recently_played;

  /// No description provided for @paste_lrc_here.
  ///
  /// In en, this message translates to:
  /// **'Paste LRC lyrics here...'**
  String get paste_lrc_here;

  /// No description provided for @lyrics_content_cannot_be_empty.
  ///
  /// In en, this message translates to:
  /// **'Lyrics content cannot be empty'**
  String get lyrics_content_cannot_be_empty;

  /// No description provided for @lyrics_imported_successfully.
  ///
  /// In en, this message translates to:
  /// **'Lyrics imported successfully'**
  String get lyrics_imported_successfully;

  /// No description provided for @failed_to_import_lyrics.
  ///
  /// In en, this message translates to:
  /// **'Failed to import lyrics'**
  String get failed_to_import_lyrics;

  /// No description provided for @input_search_keywords.
  ///
  /// In en, this message translates to:
  /// **'Input search keywords...'**
  String get input_search_keywords;

  /// No description provided for @search_keywords_cannot_be_empty.
  ///
  /// In en, this message translates to:
  /// **'Search keywords cannot be empty'**
  String get search_keywords_cannot_be_empty;

  /// No description provided for @no_lyrics_found.
  ///
  /// In en, this message translates to:
  /// **'No lyrics found'**
  String get no_lyrics_found;

  /// No description provided for @search_results.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get search_results;

  /// No description provided for @lyrics_applied_successfully.
  ///
  /// In en, this message translates to:
  /// **'Lyrics applied successfully'**
  String get lyrics_applied_successfully;

  /// No description provided for @auto_scroll.
  ///
  /// In en, this message translates to:
  /// **'Auto Scroll'**
  String get auto_scroll;

  /// No description provided for @highlight_current_line.
  ///
  /// In en, this message translates to:
  /// **'Highlight Current Line'**
  String get highlight_current_line;

  /// No description provided for @show_translation.
  ///
  /// In en, this message translates to:
  /// **'Show Translation'**
  String get show_translation;

  /// No description provided for @font_size.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get font_size;

  /// No description provided for @line_spacing.
  ///
  /// In en, this message translates to:
  /// **'Line Spacing'**
  String get line_spacing;

  /// No description provided for @no_tracks.
  ///
  /// In en, this message translates to:
  /// **'No tracks'**
  String get no_tracks;

  /// No description provided for @playlist_not_found.
  ///
  /// In en, this message translates to:
  /// **'Playlist not found'**
  String get playlist_not_found;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong;

  /// No description provided for @edit_playlist.
  ///
  /// In en, this message translates to:
  /// **'Edit Playlist'**
  String get edit_playlist;

  /// No description provided for @delete_playlist.
  ///
  /// In en, this message translates to:
  /// **'Delete Playlist'**
  String get delete_playlist;

  /// No description provided for @delete_playlist_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String delete_playlist_confirm(Object name);

  /// No description provided for @removed_from_playlist.
  ///
  /// In en, this message translates to:
  /// **'Removed from playlist'**
  String get removed_from_playlist;

  /// No description provided for @search_for_music.
  ///
  /// In en, this message translates to:
  /// **'Search for music, artists, albums...'**
  String get search_for_music;

  /// No description provided for @search_hint.
  ///
  /// In en, this message translates to:
  /// **'Type something to search'**
  String get search_hint;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @logged_out.
  ///
  /// In en, this message translates to:
  /// **'Logged out from {platform}'**
  String logged_out(Object platform);

  /// No description provided for @logout_failed.
  ///
  /// In en, this message translates to:
  /// **'Logout failed: {error}'**
  String logout_failed(Object error);

  /// No description provided for @account_management.
  ///
  /// In en, this message translates to:
  /// **'Account Management'**
  String get account_management;

  /// No description provided for @logged_in.
  ///
  /// In en, this message translates to:
  /// **'Logged in as {name}'**
  String logged_in(Object name);

  /// No description provided for @not_logged_in.
  ///
  /// In en, this message translates to:
  /// **'Not logged in'**
  String get not_logged_in;

  /// No description provided for @choose_theme_mode.
  ///
  /// In en, this message translates to:
  /// **'Choose Theme Mode'**
  String get choose_theme_mode;

  /// No description provided for @follow_system.
  ///
  /// In en, this message translates to:
  /// **'Follow System'**
  String get follow_system;

  /// No description provided for @light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get light_mode;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @amoled_mode.
  ///
  /// In en, this message translates to:
  /// **'AMOLED Black'**
  String get amoled_mode;

  /// No description provided for @amoled_mode_description.
  ///
  /// In en, this message translates to:
  /// **'Use pure black for OLED/AMOLED screens'**
  String get amoled_mode_description;

  /// No description provided for @choose_accent_color.
  ///
  /// In en, this message translates to:
  /// **'Choose Accent Color'**
  String get choose_accent_color;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
