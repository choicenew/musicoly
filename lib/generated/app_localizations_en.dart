// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get guest => 'Guest';

  @override
  String get browse => 'Browse';

  @override
  String get search => 'Search';

  @override
  String get library => 'Library';

  @override
  String get lyrics => 'Lyrics';

  @override
  String get settings => 'Settings';

  @override
  String get genre_categories_filter => 'Filter categories or genres...';

  @override
  String get genre => 'Genre';

  @override
  String get personalized => 'Personalized';

  @override
  String get featured => 'Featured';

  @override
  String get new_releases => 'New Releases';

  @override
  String get songs => 'Songs';

  @override
  String playing_track(Object track) {
    return 'Playing $track';
  }

  @override
  String queue_clear_alert(Object track_length) {
    return 'This will clear the current queue. $track_length tracks will be removed\nDo you want to continue?';
  }

  @override
  String get load_more => 'Load more';

  @override
  String get playlists => 'Playlists';

  @override
  String get artists => 'Artists';

  @override
  String get albums => 'Albums';

  @override
  String get tracks => 'Tracks';

  @override
  String get downloads => 'Downloads';

  @override
  String get filter_playlists => 'Filter your playlists...';

  @override
  String get liked_tracks => 'Liked Tracks';

  @override
  String get liked_tracks_description => 'All your liked tracks';

  @override
  String get create_playlist => 'Create Playlist';

  @override
  String get create_a_playlist => 'Create a playlist';

  @override
  String get update_playlist => 'Update playlist';

  @override
  String get create => 'Create';

  @override
  String get cancel => 'Cancel';

  @override
  String get update => 'Update';

  @override
  String get playlist_name => 'Playlist Name';

  @override
  String get name_of_playlist => 'Name of the playlist';

  @override
  String get description => 'Description';

  @override
  String get public => 'Public';

  @override
  String get collaborative => 'Collaborative';

  @override
  String get search_local_tracks => 'Search local tracks...';

  @override
  String get play => 'Play';

  @override
  String get delete => 'Delete';

  @override
  String get none => 'None';

  @override
  String get sort_a_z => 'Sort by A-Z';

  @override
  String get sort_z_a => 'Sort by Z-A';

  @override
  String get sort_artist => 'Sort by Artist';

  @override
  String get sort_album => 'Sort by Album';

  @override
  String get sort_duration => 'Sort by Duration';

  @override
  String get sort_tracks => 'Sort Tracks';

  @override
  String currently_downloading(Object tracks_length) {
    return 'Currently Downloading ($tracks_length)';
  }

  @override
  String get cancel_all => 'Cancel All';

  @override
  String get filter_artist => 'Filter artists...';

  @override
  String followers(Object followers) {
    return '$followers Followers';
  }

  @override
  String get add_artist_to_blacklist => 'Add artist to blacklist';

  @override
  String get top_tracks => 'Top Tracks';

  @override
  String get fans_also_like => 'Fans also like';

  @override
  String get loading => 'Loading...';

  @override
  String get loading_album => 'Loading album...';

  @override
  String get loading_artist => 'Loading artist...';

  @override
  String get album_not_found => 'Album not found';

  @override
  String get album_not_found_hint =>
      'The album you\'re looking for doesn\'t exist or has been removed.';

  @override
  String get artist_not_found => 'Artist not found';

  @override
  String get artist_not_found_hint =>
      'The artist you are looking for could not be found';

  @override
  String get unknown_release_date => 'Unknown release date';

  @override
  String get label => 'Label';

  @override
  String get album_details => 'Album Details';

  @override
  String get no_tracks_available => 'No tracks available';

  @override
  String get no_albums_available => 'No albums available';

  @override
  String get no_related_artists_found => 'No related artists found';

  @override
  String get popular_tracks => 'Popular Tracks';

  @override
  String get see_all_tracks => 'See All Tracks';

  @override
  String get all_tracks => 'All Tracks';

  @override
  String songs_count(Object count) {
    return '$count songs';
  }

  @override
  String get artist => 'Artist';

  @override
  String get blacklisted => 'Blacklisted';

  @override
  String get following => 'Following';

  @override
  String get follow => 'Follow';

  @override
  String get artist_url_copied => 'Artist URL copied to clipboard';

  @override
  String added_to_queue(Object tracks) {
    return 'Added $tracks tracks to queue';
  }

  @override
  String get filter_albums => 'Filter albums...';

  @override
  String get synced => 'Synced';

  @override
  String get plain => 'Plain';

  @override
  String get shuffle => 'Shuffle';

  @override
  String get search_tracks => 'Search tracks...';

  @override
  String get released => 'Released';

  @override
  String error(Object error) {
    return 'Error $error';
  }

  @override
  String get title => 'Title';

  @override
  String get time => 'Time';

  @override
  String get more_actions => 'More actions';

  @override
  String download_count(Object count) {
    return 'Download ($count)';
  }

  @override
  String add_count_to_playlist(Object count) {
    return 'Add ($count) to Playlist';
  }

  @override
  String add_count_to_queue(Object count) {
    return 'Add ($count) to Queue';
  }

  @override
  String play_count_next(Object count) {
    return 'Play ($count) next';
  }

  @override
  String get album => 'Album';

  @override
  String copied_to_clipboard(Object data) {
    return 'Copied $data to clipboard';
  }

  @override
  String add_to_following_playlists(Object track) {
    return 'Add $track to following Playlists';
  }

  @override
  String get add => 'Add';

  @override
  String added_track_to_queue(Object track) {
    return 'Added $track to queue';
  }

  @override
  String get add_to_queue => 'Add to queue';

  @override
  String track_will_play_next(Object track) {
    return '$track will play next';
  }

  @override
  String get play_next => 'Play next';

  @override
  String removed_track_from_queue(Object track) {
    return 'Removed $track from queue';
  }

  @override
  String get remove_from_queue => 'Remove from queue';

  @override
  String get remove_from_favorites => 'Remove from favorites';

  @override
  String get save_as_favorite => 'Save as favorite';

  @override
  String get add_to_playlist => 'Add to playlist';

  @override
  String get remove_from_playlist => 'Remove from playlist';

  @override
  String get add_to_blacklist => 'Add to blacklist';

  @override
  String get remove_from_blacklist => 'Remove from blacklist';

  @override
  String get share => 'Share';

  @override
  String get mini_player => 'Mini Player';

  @override
  String get slide_to_seek => 'Slide to seek forward or backward';

  @override
  String get shuffle_playlist => 'Shuffle playlist';

  @override
  String get unshuffle_playlist => 'Unshuffle playlist';

  @override
  String get previous_track => 'Previous track';

  @override
  String get next_track => 'Next track';

  @override
  String get pause_playback => 'Pause Playback';

  @override
  String get resume_playback => 'Resume Playback';

  @override
  String get loop_track => 'Loop track';

  @override
  String get repeat_playlist => 'Repeat playlist';

  @override
  String get queue => 'Queue';

  @override
  String get alternative_track_sources => 'Alternative track sources';

  @override
  String get download_track => 'Download track';

  @override
  String tracks_in_queue(Object tracks) {
    return '$tracks tracks in queue';
  }

  @override
  String get clear_all => 'Clear all';

  @override
  String get show_hide_ui_on_hover => 'Show/Hide UI on hover';

  @override
  String get always_on_top => 'Always on top';

  @override
  String get exit_mini_player => 'Exit Mini player';

  @override
  String get download_location => 'Download location';

  @override
  String get local_library => 'Local library';

  @override
  String get add_library_location => 'Add to library';

  @override
  String get remove_library_location => 'Remove from library';

  @override
  String get account => 'Account';

  @override
  String get login_with_spotify => 'Login with your Spotify account';

  @override
  String get connect_with_spotify => 'Connect with Spotify';

  @override
  String get connect_with_youtube => 'Connect with Youtube';

  @override
  String get logout => 'Logout';

  @override
  String get logout_of_this_account => 'Logout of this account';

  @override
  String get language_region => 'Language & Region';

  @override
  String get language => 'Language';

  @override
  String get language_settings => 'Language Settings';

  @override
  String get timeZone => 'Time Zone';

  @override
  String get timeFormat => 'Time Format';

  @override
  String get use24HourFormat => 'Use 24-hour Format';

  @override
  String get save => 'Save';

  @override
  String get current_language => 'Current Language';

  @override
  String get select_language => 'Select Language';

  @override
  String get failed_to_load_language_settings =>
      'Failed to load language settings';

  @override
  String get system_default => 'System Default';

  @override
  String get market_place_region => 'Marketplace Region';

  @override
  String get recommendation_country => 'Recommendation Country';

  @override
  String get appearance => 'Appearance';

  @override
  String get layout_mode => 'Layout Mode';

  @override
  String get override_layout_settings =>
      'Override responsive layout mode settings';

  @override
  String get adaptive => 'Adaptive';

  @override
  String get compact => 'Compact';

  @override
  String get extended => 'Extended';

  @override
  String get theme => 'Theme';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get system => 'System';

  @override
  String get accent_color => 'Accent Color';

  @override
  String get sync_album_color => 'Sync album color';

  @override
  String get sync_album_color_description =>
      'Uses the dominant color of the album art as the accent color';

  @override
  String get playback => 'Playback';

  @override
  String get audio_quality => 'Audio Quality';

  @override
  String get select_audio_quality => 'Select audio playback quality';

  @override
  String get low_quality => 'Low';

  @override
  String get medium_quality => 'Medium';

  @override
  String get high_quality => 'High';

  @override
  String get crossfade => 'Crossfade';

  @override
  String get crossfade_description => 'Set transition effect between songs';

  @override
  String get off => 'Off';

  @override
  String seconds(Object count) {
    return '$count Seconds';
  }

  @override
  String get download_path => 'Download Path';

  @override
  String get download_format => 'Download Format';

  @override
  String get download_lyrics => 'Download Lyrics';

  @override
  String get download_lyrics_description =>
      'Download lyric files along with songs';

  @override
  String get download_cover => 'Download Cover';

  @override
  String get download_cover_description =>
      'Download cover images along with songs';

  @override
  String get file_naming_format => 'File Naming Format';

  @override
  String get file_naming_format_description =>
      'Set naming rules for downloaded files';

  @override
  String get song_title => 'Song Title';

  @override
  String get artist_song_title => 'Artist - Song Title';

  @override
  String get song_title_artist => 'Song Title - Artist';

  @override
  String get album_track_song_title => 'Album - Track - Song Title';

  @override
  String get desktop => 'Desktop';

  @override
  String get auto_start => 'Auto-start on boot';

  @override
  String get auto_start_description =>
      'Run app automatically when system starts';

  @override
  String get minimize_to_tray => 'Minimize to Tray';

  @override
  String get minimize_to_tray_description =>
      'Minimize to system tray instead of exiting when closing window';

  @override
  String get media_key_control => 'Media Key Control';

  @override
  String get media_key_control_description =>
      'Control playback using keyboard media keys';

  @override
  String get system_notifications => 'System Notifications';

  @override
  String get system_notifications_description =>
      'Show system notifications for track changes etc.';

  @override
  String get shortcut_settings => 'Shortcut Settings';

  @override
  String get shortcut_settings_description => 'Customize global shortcuts';

  @override
  String get set => 'Set';

  @override
  String get high => 'High';

  @override
  String get low => 'Low';

  @override
  String get pre_download_play => 'Pre-download and play';

  @override
  String get pre_download_play_description =>
      'Instead of streaming audio, download bytes and play instead (Recommended for higher bandwidth users)';

  @override
  String get skip_non_music => 'Skip non-music segments (SponsorBlock)';

  @override
  String get blacklist_description => 'Blacklisted tracks and artists';

  @override
  String get wait_for_download_to_finish =>
      'Please wait for the current download to finish';

  @override
  String get local_music => 'Local Music';

  @override
  String get recently_added => 'Recently Added';

  @override
  String get most_played => 'Most Played';

  @override
  String get shuffle_all => 'Shuffle All';

  @override
  String get play_all => 'Play All';

  @override
  String get scan_local_music => 'Scan Local Music';

  @override
  String get scanning => 'Scanning...';

  @override
  String get no_playlists => 'No playlists found';

  @override
  String track_count(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tracks',
      one: '1 track',
      zero: 'No tracks',
    );
    return '$_temp0';
  }

  @override
  String get edit_tags => 'Edit Tags';

  @override
  String get added_to_playlist => 'Added to playlist';

  @override
  String confirm_delete_tracks(Object count) {
    return 'Are you sure you want to delete $count tracks from your library?';
  }

  @override
  String get home => 'Home';

  @override
  String get favorites => 'Favorites';

  @override
  String get close_behavior => 'Close Behavior';

  @override
  String get close => 'Close';

  @override
  String get show_tray_icon => 'Show System tray icon';

  @override
  String get about => 'About';

  @override
  String get u_love_pyro_music => 'We know you love Pyro Music';

  @override
  String get version_info => 'Version Info';

  @override
  String get failed_to_check_for_updates => 'Failed to check for updates';

  @override
  String get import_cookie => 'Import Cookie';

  @override
  String get import_cookie_description => 'Import authentication from file';

  @override
  String get import => 'Import';

  @override
  String get export_cookie => 'Export Cookie';

  @override
  String get export_cookie_description => 'Export authentication to file';

  @override
  String get export => 'Export';

  @override
  String get clear_cookie => 'Clear Cookie';

  @override
  String get clear_cookie_description => 'Clear all authentication';

  @override
  String get show_plain_lyrics => 'Show plain lyrics';

  @override
  String get show_synced_lyrics => 'Show synced lyrics';

  @override
  String get exit_edit_mode => 'Exit edit mode';

  @override
  String get enter_edit_mode => 'Enter edit mode';

  @override
  String get export_lyrics => 'Export lyrics';

  @override
  String get import_lyrics => 'Import lyrics';

  @override
  String get search_lyrics => 'Search lyrics';

  @override
  String get lyrics_settings => 'Lyrics settings';

  @override
  String get no_track_playing => 'No track playing';

  @override
  String get login_error => 'Login Error';

  @override
  String failed_to_get_auth_service(Object platform) {
    return 'Failed to get auth service for $platform';
  }

  @override
  String login_failed(Object error) {
    return 'Login failed: $error';
  }

  @override
  String get welcome_to_pyro_music => 'Welcome to Pyro Music';

  @override
  String get let_us_configure_first =>
      'Before we start, let\'s configure some basic settings';

  @override
  String get check_for_updates => 'Check for updates';

  @override
  String get about_pyro_music => 'About Pyro Music';

  @override
  String get repository => 'Repository';

  @override
  String get bug_issues => 'Bug Issues';

  @override
  String get license => 'License';

  @override
  String get pyro_music_description =>
      'An open source music player built with Flutter';

  @override
  String get blacklist => 'Blacklist';

  @override
  String get please_sponsor => 'Please Sponsor/Donate';

  @override
  String get version => 'Version';

  @override
  String get build_number => 'Build Number';

  @override
  String get founder => 'Founder';

  @override
  String get made_with => 'Made with ❤️ in Bangladesh🇧🇩';

  @override
  String get kingkor_roy_tirtho => 'Kingkor Roy Tirtho';

  @override
  String copyright(Object current_year) {
    return '© 2021-$current_year Kingkor Roy Tirtho';
  }

  @override
  String get add_spotify_credentials =>
      'Add your spotify credentials to get started';

  @override
  String get credentials_will_not_be_shared_disclaimer =>
      'Don\'t worry, any of your credentials won\'t be collected or shared with anyone';

  @override
  String get know_how_to_login => 'Don\'t know how to do this?';

  @override
  String get follow_step_by_step_guide => 'Follow along the Step by Step guide';

  @override
  String spotify_cookie(Object name) {
    return 'Spotify $name Cookie';
  }

  @override
  String cookie_name_cookie(Object name) {
    return '$name Cookie';
  }

  @override
  String get fill_in_all_fields => 'Please fill in all the fields';

  @override
  String get submit => 'Submit';

  @override
  String get exit => 'Exit';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get done => 'Done';

  @override
  String get step_1 => 'Step 1';

  @override
  String get first_go_to => 'First, Go to';

  @override
  String get login_if_not_logged_in =>
      'and Login/Signup if you are not logged in';

  @override
  String get export_logs => 'Export Logs';

  @override
  String get export_logs_description => 'Export application logs for debugging';

  @override
  String get scan_completed => 'Scan Completed';

  @override
  String get equalizer => 'Equalizer';

  @override
  String get enable_equalizer => 'Enable Equalizer';

  @override
  String get sleep_timer => 'Sleep Timer';

  @override
  String minutes(num count) {
    return '$count minutes';
  }

  @override
  String get sleep_timer_description => 'Stop playback after a set time';

  @override
  String get accounts => 'Accounts';

  @override
  String get backup_restore => 'Backup & Restore';

  @override
  String get developers_options => 'Developer Options';

  @override
  String get cookie_management => 'Cookie Management';

  @override
  String by_author(Object author) {
    return 'By $author';
  }

  @override
  String selected_count(Object count) {
    return '$count selected';
  }

  @override
  String get pause => 'Pause';

  @override
  String get repeat => 'Repeat';

  @override
  String get queue_is_empty => 'Queue is empty';

  @override
  String get add_tracks_to_get_started => 'Add some tracks to get started';

  @override
  String queue_count(Object count) {
    return '$count tracks in queue';
  }

  @override
  String get no_tracks => 'No tracks';

  @override
  String get removed_from_playlist => 'Removed from playlist';

  @override
  String import_success(Object count) {
    return 'Successfully imported $count items';
  }

  @override
  String import_failed(Object error) {
    return 'Import failed: $error';
  }

  @override
  String export_success(Object path) {
    return 'Successfully exported to $path';
  }

  @override
  String export_failed(Object error) {
    return 'Export failed: $error';
  }

  @override
  String get cookie_cleared => 'Cookie cleared';

  @override
  String clear_failed(Object error) {
    return 'Clear failed: $error';
  }

  @override
  String get clear => 'Clear';

  @override
  String get cache_cleared => 'Cache cleared';

  @override
  String clearing_failed(Object error) {
    return 'Clearing failed: $error';
  }

  @override
  String get api_endpoint_config => 'API Endpoint Configuration';

  @override
  String get api_server_address => 'API Server Address';

  @override
  String get no_logs_to_export => 'No logs to export';

  @override
  String logs_exported(Object path) {
    return 'Logs exported to $path';
  }

  @override
  String get debug_mode => 'Debug Mode';

  @override
  String get debug_mode_description => 'Enable debug features and logging';

  @override
  String get verbose_logging => 'Verbose Logging';

  @override
  String get verbose_logging_description =>
      'Show detailed logs for troubleshooting';

  @override
  String get use_default_server => 'Use default server';

  @override
  String get configure => 'Configure';

  @override
  String get cache_management => 'Cache Management';

  @override
  String get cache_management_description =>
      'Manage application cache and temporary files';

  @override
  String logged_in(Object name) {
    return 'Logged in as $name';
  }

  @override
  String get not_logged_in => 'Not logged in';

  @override
  String get choose_theme_mode => 'Choose Theme Mode';

  @override
  String get follow_system => 'Follow System';

  @override
  String get light_mode => 'Light Mode';

  @override
  String get dark_mode => 'Dark Mode';

  @override
  String get amoled_mode => 'AMOLED Mode';

  @override
  String get amoled_mode_description => 'Pure black theme for AMOLED screens';

  @override
  String get choose_accent_color => 'Choose Accent Color';

  @override
  String get export_backup => 'Export Backup';

  @override
  String get backup_description => 'Create a backup of your data';

  @override
  String get backup_success => 'Backup created successfully';

  @override
  String backup_failed(Object error) {
    return 'Backup failed: $error';
  }

  @override
  String get import_backup => 'Import Backup';

  @override
  String get restore_description => 'Restore data from a backup file';

  @override
  String get restore_success => 'Restore completed successfully';

  @override
  String restore_failed(Object error) {
    return 'Restore failed: $error';
  }

  @override
  String get cookie_import_success => 'Cookie imported successfully';

  @override
  String get cookie_export_success => 'Cookie exported successfully';

  @override
  String get text_size => 'Text Size';

  @override
  String get line_spacing => 'Line Spacing';

  @override
  String get ok => 'OK';

  @override
  String get playlist_not_found => 'Playlist not found';

  @override
  String get something_went_wrong => 'Something went wrong';

  @override
  String get edit_playlist => 'Edit Playlist';

  @override
  String get delete_playlist => 'Delete Playlist';

  @override
  String delete_playlist_confirm(Object name) {
    return 'Are you sure you want to delete the playlist \'$name\'?';
  }

  @override
  String get details => 'Details';

  @override
  String get search_for_music => 'Search for music';

  @override
  String get search_hint => 'Search for tracks, artists, or albums';

  @override
  String get all => 'All';

  @override
  String no_results_found(Object query) {
    return 'No results found for \'$query\'';
  }

  @override
  String logged_out(Object platform) {
    return 'Logged out from $platform';
  }

  @override
  String logout_failed(Object error) {
    return 'Logout failed: $error';
  }

  @override
  String get account_management => 'Account Management';

  @override
  String logged_in_on(Object name, Object platform) {
    return 'Logged in as $name on $platform';
  }

  @override
  String get paste_lrc_here => 'Paste LRC lyrics here...';

  @override
  String get lyrics_content_cannot_be_empty => 'Lyrics content cannot be empty';

  @override
  String get input_search_keywords => 'Input search keywords...';

  @override
  String get search_keywords_cannot_be_empty =>
      'Search keywords cannot be empty';

  @override
  String get no_lyrics_found => 'No lyrics found';

  @override
  String get search_results => 'Search Results';

  @override
  String get lyrics_applied_successfully => 'Lyrics applied successfully';

  @override
  String get auto_scroll => 'Auto Scroll';

  @override
  String get highlight_current_line => 'Highlight Current Line';

  @override
  String get show_translation => 'Show Translation';

  @override
  String get font_size => 'Font Size';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get recently_played => 'Recently Played';

  @override
  String get lyrics_imported_successfully => 'Lyrics imported successfully';

  @override
  String get failed_to_import_lyrics => 'Failed to import lyrics';

  @override
  String get recent_tracks => 'Recent Tracks';

  @override
  String get see_all => 'See All';

  @override
  String get no_recent_tracks => 'No recent tracks';

  @override
  String get start_listening_hint =>
      'Start listening to some music to see your history here!';

  @override
  String get login_with_lastfm => 'Login with Last.fm';

  @override
  String get go_back => 'Go Back';

  @override
  String get release_date => 'Release Date';

  @override
  String followers_count(Object count) {
    return '$count Followers';
  }

  @override
  String get featured_playlists => 'Featured Playlists';

  @override
  String get no_featured_playlists => 'No featured playlists';

  @override
  String welcome_back(Object name) {
    return 'Welcome back, $name';
  }

  @override
  String get good_morning => 'Good morning';

  @override
  String get good_afternoon => 'Good afternoon';

  @override
  String get good_evening => 'Good evening';

  @override
  String get recommended_artists => 'Recommended Artists';

  @override
  String get no_recommended_artists => 'No recommended artists';
}
