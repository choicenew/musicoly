// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get guest => '访客';

  @override
  String get browse => '浏览';

  @override
  String get search => '搜索';

  @override
  String get library => '媒体库';

  @override
  String get lyrics => '歌词';

  @override
  String get settings => '设置';

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
  String get playlists => '歌单';

  @override
  String get artists => '艺人';

  @override
  String get albums => '专辑';

  @override
  String get tracks => '单曲';

  @override
  String get downloads => '下载';

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
  String get cancel => '取消';

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
  String get play => '播放';

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
  String get fans_also_like => '粉丝也喜欢';

  @override
  String get loading => '加载中...';

  @override
  String get loading_album => '正在加载专辑...';

  @override
  String get loading_artist => '正在加载艺术家...';

  @override
  String get album_not_found => '未找到专辑';

  @override
  String get album_not_found_hint => '找不到您要查看的专辑';

  @override
  String get artist_not_found => '未找到艺术家';

  @override
  String get artist_not_found_hint => '找不到您要查看的艺术家';

  @override
  String get unknown_release_date => '发行日期未知';

  @override
  String get label => '唱片公司';

  @override
  String get album_details => '专辑详情';

  @override
  String get no_tracks_available => '无可用曲目';

  @override
  String get no_albums_available => '无可用专辑';

  @override
  String get no_related_artists_found => '未找到相关艺术家';

  @override
  String get popular_tracks => '热门曲目';

  @override
  String get see_all_tracks => '查看全部曲目';

  @override
  String get all_tracks => '全部曲目';

  @override
  String songs_count(Object count) {
    return '$count 首歌曲';
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
  String get shuffle => '随机播放';

  @override
  String get search_tracks => 'Search tracks...';

  @override
  String get released => 'Released';

  @override
  String error(Object error) {
    return '错误 $error';
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
  String get language_region => '语言和地区设置';

  @override
  String get language => '语言';

  @override
  String get language_settings => '语言设置';

  @override
  String get timeZone => '时区';

  @override
  String get timeFormat => '时间格式';

  @override
  String get use24HourFormat => '使用24小时格式';

  @override
  String get save => '保存';

  @override
  String get current_language => '当前语言';

  @override
  String get select_language => '选择语言';

  @override
  String get failed_to_load_language_settings => '加载语言设置失败';

  @override
  String get system_default => '系统默认';

  @override
  String get market_place_region => 'Marketplace Region';

  @override
  String get recommendation_country => 'Recommendation Country';

  @override
  String get appearance => '外观';

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
  String get theme => '主题';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get system => 'System';

  @override
  String get accent_color => '强调色';

  @override
  String get sync_album_color => '同步专辑颜色';

  @override
  String get sync_album_color_description => '根据专辑封面同步界面颜色';

  @override
  String get playback => '播放';

  @override
  String get audio_quality => '音频质量';

  @override
  String get select_audio_quality => '选择音频播放质量';

  @override
  String get low_quality => '低质量';

  @override
  String get medium_quality => '中等质量';

  @override
  String get high_quality => '高质量';

  @override
  String get crossfade => '交叉淡入淡出';

  @override
  String get crossfade_description => '设置歌曲之间的过渡效果';

  @override
  String get off => '关闭';

  @override
  String seconds(Object count) {
    return '$count 秒';
  }

  @override
  String get download_path => '下载路径';

  @override
  String get download_format => '下载格式';

  @override
  String get download_lyrics => '下载歌词';

  @override
  String get download_lyrics_description => '同时下载歌曲的歌词文件';

  @override
  String get download_cover => '下载封面';

  @override
  String get download_cover_description => '同时下载歌曲的封面图片';

  @override
  String get file_naming_format => '文件命名格式';

  @override
  String get file_naming_format_description => '设置下载文件的命名规则';

  @override
  String get song_title => '歌曲名';

  @override
  String get artist_song_title => '歌手 - 歌曲名';

  @override
  String get song_title_artist => '歌曲名 - 歌手';

  @override
  String get album_track_song_title => '专辑 - 曲目 - 歌曲名';

  @override
  String get desktop => '桌面';

  @override
  String get auto_start => '开机自启动';

  @override
  String get auto_start_description => '系统启动时自动运行应用';

  @override
  String get minimize_to_tray => '最小化到系统托盘';

  @override
  String get minimize_to_tray_description => '关闭窗口时最小化到系统托盘而不是退出';

  @override
  String get media_key_control => '媒体键控制';

  @override
  String get media_key_control_description => '使用键盘媒体键控制播放';

  @override
  String get system_notifications => '系统通知';

  @override
  String get system_notifications_description => '显示歌曲切换等系统通知';

  @override
  String get shortcut_settings => '快捷键设置';

  @override
  String get shortcut_settings_description => '自定义全局快捷键';

  @override
  String get set => '设置';

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
  String get local_music => '本地音乐';

  @override
  String get recently_added => 'Recently Added';

  @override
  String get most_played => 'Most Played';

  @override
  String get shuffle_all => 'Shuffle All';

  @override
  String get play_all => '播放全部';

  @override
  String get scan_local_music => '扫描本地音乐';

  @override
  String get scanning => '正在扫描...';

  @override
  String get no_playlists => '未找到歌单';

  @override
  String track_count(num count) {
    return '$count 首歌曲';
  }

  @override
  String get edit_tags => 'Edit Tags';

  @override
  String get added_to_playlist => '已添加到歌单';

  @override
  String confirm_delete_tracks(Object count) {
    return '确定要从曲库中移除这 $count 首歌曲吗？';
  }

  @override
  String get home => '首页';

  @override
  String get favorites => 'Favorites';

  @override
  String get close_behavior => 'Close Behavior';

  @override
  String get close => 'Close';

  @override
  String get show_tray_icon => 'Show System tray icon';

  @override
  String get about => '关于';

  @override
  String get u_love_pyro_music => '我们知道你喜欢 Pyro Music';

  @override
  String get version_info => '版本信息';

  @override
  String get failed_to_check_for_updates => '检查更新失败';

  @override
  String get import_cookie => '导入Cookie';

  @override
  String get import_cookie_description => '从文件导入认证信息';

  @override
  String get import => '导入';

  @override
  String get export_cookie => '导出Cookie';

  @override
  String get export_cookie_description => '导出当前认证信息到文件';

  @override
  String get export => '导出';

  @override
  String get clear_cookie => '清除Cookie';

  @override
  String get clear_cookie_description => '清除所有平台的认证信息';

  @override
  String get show_plain_lyrics => '显示普通歌词';

  @override
  String get show_synced_lyrics => '显示同步歌词';

  @override
  String get exit_edit_mode => '退出编辑模式';

  @override
  String get enter_edit_mode => '进入编辑模式';

  @override
  String get export_lyrics => '导出歌词';

  @override
  String get import_lyrics => '导入歌词';

  @override
  String get search_lyrics => '搜索歌词';

  @override
  String get lyrics_settings => '歌词设置';

  @override
  String get no_track_playing => '没有正在播放的曲目';

  @override
  String get login_error => '登录错误';

  @override
  String failed_to_get_auth_service(Object platform) {
    return '无法获取 $platform 认证服务';
  }

  @override
  String login_failed(Object error) {
    return '登录失败: $error';
  }

  @override
  String get welcome_to_pyro_music => '欢迎使用 Pyro Music';

  @override
  String get let_us_configure_first => '开始使用前，让我们先进行一些基本设置';

  @override
  String get check_for_updates => '检查更新';

  @override
  String get about_pyro_music => '关于 Pyro Music';

  @override
  String get repository => '项目仓库';

  @override
  String get bug_issues => '问题反馈';

  @override
  String get license => '开源许可';

  @override
  String get pyro_music_description => '基于Flutter构建的开源音乐播放器';

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
  String get previous => '上一首';

  @override
  String get next => '下一首';

  @override
  String get done => '完成';

  @override
  String get step_1 => 'Step 1';

  @override
  String get first_go_to => 'First, Go to';

  @override
  String get login_if_not_logged_in =>
      'and Login/Signup if you are not logged in';

  @override
  String get export_logs => '导出日志';

  @override
  String get export_logs_description => '导出应用日志文件';

  @override
  String get scan_completed => '扫描完成';

  @override
  String get equalizer => '均衡器';

  @override
  String get enable_equalizer => '启用均衡器';

  @override
  String get sleep_timer => '睡眠定时器';

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 分钟',
      one: '1 分钟',
    );
    return '$_temp0';
  }

  @override
  String get sleep_timer_description => '设置定时停止播放音乐';

  @override
  String get accounts => '账户';

  @override
  String get backup_restore => '备份与恢复';

  @override
  String get developers_options => '开发者选项';

  @override
  String get cookie_management => 'Cookie管理';

  @override
  String by_author(Object author) {
    return '作者: $author';
  }

  @override
  String selected_count(Object count) {
    return '已选择 $count 项';
  }

  @override
  String get pause => '暂停';

  @override
  String get repeat => '重复播放';

  @override
  String get queue_is_empty => '队列为空';

  @override
  String get add_tracks_to_get_started => '添加一些歌曲以开始播放';

  @override
  String queue_count(Object count) {
    return '$count 首歌曲';
  }

  @override
  String get no_tracks => 'No tracks';

  @override
  String get removed_from_playlist => 'Removed from playlist';

  @override
  String import_success(Object count) {
    return '导入成功';
  }

  @override
  String import_failed(Object error) {
    return '导入失败: $error';
  }

  @override
  String export_success(Object path) {
    return 'Successfully exported to $path';
  }

  @override
  String export_failed(Object error) {
    return '导出失败: $error';
  }

  @override
  String get cookie_cleared => 'Cookie 已清除';

  @override
  String clear_failed(Object error) {
    return '清除失败: $error';
  }

  @override
  String get clear => '清理';

  @override
  String get cache_cleared => '缓存清理完成';

  @override
  String clearing_failed(Object error) {
    return '清理失败: $error';
  }

  @override
  String get api_endpoint_config => 'API端点配置';

  @override
  String get api_server_address => 'API服务器地址';

  @override
  String get no_logs_to_export => '没有可导出的日志';

  @override
  String logs_exported(Object path) {
    return '日志导出成功';
  }

  @override
  String get debug_mode => '调试模式';

  @override
  String get debug_mode_description => '启用开发者工具和详细日志';

  @override
  String get verbose_logging => '详细日志';

  @override
  String get verbose_logging_description => '记录更详细的应用日志';

  @override
  String get use_default_server => '使用默认服务器';

  @override
  String get configure => '配置';

  @override
  String get cache_management => '缓存管理';

  @override
  String get cache_management_description => '清理应用临时缓存数据';

  @override
  String logged_in(Object name) {
    return '已登录: $name';
  }

  @override
  String get not_logged_in => '未登录';

  @override
  String get choose_theme_mode => '选择应用的主题模式';

  @override
  String get follow_system => '跟随系统';

  @override
  String get light_mode => '浅色';

  @override
  String get dark_mode => '深色';

  @override
  String get amoled_mode => 'AMOLED模式';

  @override
  String get amoled_mode_description => '使用纯黑背景的深色主题';

  @override
  String get choose_accent_color => '选择应用的强调色方案';

  @override
  String get export_backup => '导出备份';

  @override
  String get backup_description => '将您的曲库和歌单导出到文件';

  @override
  String get backup_success => '备份导出成功';

  @override
  String backup_failed(Object error) {
    return '备份失败: $error';
  }

  @override
  String get import_backup => '导入备份';

  @override
  String get restore_description => '从文件导入您的曲库和歌单';

  @override
  String get restore_success => '备份导入成功';

  @override
  String restore_failed(Object error) {
    return '恢复失败: $error';
  }

  @override
  String get cookie_import_success => 'Cookie 导入成功';

  @override
  String get cookie_export_success => 'Cookie 导出成功';

  @override
  String get text_size => 'Text Size';

  @override
  String get line_spacing => '行间距';

  @override
  String get ok => '确定';

  @override
  String get playlist_not_found => '未找到歌单';

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
  String get search_for_music => '搜索音乐';

  @override
  String get search_hint => '查找你喜欢的歌曲、艺人、专辑和歌单';

  @override
  String get all => '全部';

  @override
  String no_results_found(Object query) {
    return '未找到 \"$query\" 的结果';
  }

  @override
  String logged_out(Object platform) {
    return '$platform 已登出';
  }

  @override
  String logout_failed(Object error) {
    return '登出失败: $error';
  }

  @override
  String get account_management => '账户管理';

  @override
  String logged_in_on(Object name, Object platform) {
    return 'Logged in as $name on $platform';
  }

  @override
  String get paste_lrc_here => '粘贴LRC格式歌词...';

  @override
  String get lyrics_content_cannot_be_empty => '歌词内容不能为空';

  @override
  String get input_search_keywords => '输入搜索关键词...';

  @override
  String get search_keywords_cannot_be_empty => '搜索关键词不能为空';

  @override
  String get no_lyrics_found => '未找到匹配的歌词';

  @override
  String get search_results => '搜索结果';

  @override
  String get lyrics_applied_successfully => '歌词应用成功';

  @override
  String get auto_scroll => '自动滚动';

  @override
  String get highlight_current_line => '高亮当前行';

  @override
  String get show_translation => '显示翻译';

  @override
  String get font_size => '字体大小';

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
  String get recent_tracks => '最近播放';

  @override
  String get see_all => '查看全部';

  @override
  String get no_recent_tracks => '暂无最近播放记录';

  @override
  String get start_listening_hint => '开始听歌以在此处查看历史记录';

  @override
  String get login_with_lastfm => '使用 Last.fm 登录';

  @override
  String get go_back => '返回';

  @override
  String get release_date => '发行日期';

  @override
  String followers_count(Object count) {
    return '$count 位关注者';
  }

  @override
  String get featured_playlists => '推荐歌单';

  @override
  String get no_featured_playlists => '暂无推荐歌单';

  @override
  String welcome_back(Object name) {
    return '欢迎回来, $name';
  }

  @override
  String get good_morning => '早上好';

  @override
  String get good_afternoon => '下午好';

  @override
  String get good_evening => '晚上好';

  @override
  String get recommended_artists => '推荐艺人';

  @override
  String get no_recommended_artists => '暂无推荐艺人';
}
