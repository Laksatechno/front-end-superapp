import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// =======================
/// MODEL UPDATE INFO
/// =======================
class UpdateInfo {
  final String latestVersion;
  final bool forceUpdate;
  final String apkUrl;
  final List<String> changelog;

  UpdateInfo({
    required this.latestVersion,
    required this.forceUpdate,
    required this.apkUrl,
    required this.changelog,
  });

  factory UpdateInfo.fromJson(Map<String, dynamic> json) {
    return UpdateInfo(
      latestVersion: (json['latest_version'] ?? '').toString(),
      forceUpdate: json['force_update'] == true,
      apkUrl: (json['apk_url'] ?? '').toString(),
      changelog: (json['changelog'] is List)
          ? (json['changelog'] as List).map((e) => e.toString()).toList()
          : <String>[],
    );
  }
}

/// =======================
/// APP UPDATER SERVICE
/// =======================
class AppUpdater {
  final Dio dio;

  AppUpdater({Dio? dio})
      : dio = dio ??
            Dio(BaseOptions(
              followRedirects: true,
              receiveTimeout: const Duration(minutes: 10),
              connectTimeout: const Duration(seconds: 30),
              sendTimeout: const Duration(seconds: 30),
            ));

  /// ambil info aplikasi lokal
  Future<PackageInfo> packageInfo() => PackageInfo.fromPlatform();

  /// =======================
  /// FETCH UPDATE FROM API
  /// =======================
  Future<UpdateInfo> fetchUpdateInfo({
    required String apiBaseUrl,
    String? token,
  }) async {
    try {
      final res = await dio.get(
        '$apiBaseUrl/app/update',
        options: Options(headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        }),
      );

      return UpdateInfo.fromJson(
        Map<String, dynamic>.from(res.data ?? {}),
      );
    } catch (e) {
      throw Exception('Gagal mengambil update: $e');
    }
  }

  /// =======================
  /// VERSION PARSER FIX (INI INTI BUG KAMU)
  /// =======================
  List<int> _parseVersion(String version) {
    // buang build metadata: 1.0.1+1 -> 1.0.1
    final clean = version.split('+').first.trim();

    return clean
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();
  }

  /// =======================
  /// VERSION COMPARISON
  /// =======================
  bool isNewerVersion(String current, String latest) {
    final c = _parseVersion(current);
    final l = _parseVersion(latest);

    final maxLen = c.length > l.length ? c.length : l.length;

    while (c.length < maxLen) c.add(0);
    while (l.length < maxLen) l.add(0);

    for (int i = 0; i < maxLen; i++) {
      if (l[i] > c[i]) return true;
      if (l[i] < c[i]) return false;
    }

    return false;
  }

  /// =======================
  /// PERMISSION HANDLING
  /// =======================
Future<void> ensurePermissions() async {
  if (!Platform.isAndroid) return;

  final installStatus = await Permission.requestInstallPackages.status;

  if (!installStatus.isGranted) {
    final result = await Permission.requestInstallPackages.request();

    if (!result.isGranted) {
      await openAppSettings();
      throw Exception(
        'Izinkan aplikasi untuk menginstal APK dari sumber ini, lalu klik update lagi.',
      );
    }
  }
}

  /// =======================
  /// DOWNLOAD APK
  /// =======================
Future<File> downloadApk({
  required String url,
  required void Function(int received, int total) onProgress,
  CancelToken? cancelToken,
}) async {
  final dir = await getApplicationDocumentsDirectory();
  final savePath = '${dir.path}/update.apk';
  final file = File(savePath);

  if (await file.exists()) {
    await file.delete();
  }

  int retry = 0;
  const maxRetry = 3;

  while (retry < maxRetry) {
    try {
      await dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        deleteOnError: true,
        onReceiveProgress: (received, total) {
          onProgress(received, total);
        },
        options: Options(
          receiveTimeout: const Duration(minutes: 20),
          sendTimeout: const Duration(minutes: 5),
          headers: const {
            'Accept': 'application/vnd.android.package-archive',
            'Connection': 'close',
          },
        ),
      );

      return file;
    } on DioException {
      retry++;

      if (retry >= maxRetry) {
        rethrow;
      }

      await Future.delayed(Duration(seconds: retry * 2));
    }
  }

  throw Exception('Download gagal setelah beberapa percobaan');
}

  /// =======================
  /// OPEN INSTALLER
  /// =======================
  Future<void> openInstaller(File apkFile) async {
    final result = await OpenFilex.open(apkFile.path);

    if (result.type != ResultType.done) {
      throw Exception('Gagal membuka installer: ${result.message}');
    }
  }
}