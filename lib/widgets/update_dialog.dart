import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yofa/theme/app_theme.dart';
import '../services/app_updater.dart';

class UpdateDialog extends StatefulWidget {
  final String apiBaseUrl;
  final String? token;
  final AppUpdater? updater;

  const UpdateDialog({
    super.key,
    required this.apiBaseUrl,
    this.token,
    this.updater,
  });

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  late final AppUpdater updater;

  UpdateInfo? info;
  PackageInfo? pkg;

  bool loading = true;
  bool downloading = false;
  double progress = 0;
  String statusText = 'Memeriksa update...';
  CancelToken? cancelToken;

  // STATE FINAL (tidak pakai getter lagi → lebih stabil)
  bool hasUpdate = false;
  bool forceUpdate = false;

  int downloadedBytes = 0;
  int totalBytes = 0;

  String _formatMb(int bytes) {
    if (bytes <= 0) return '0 MB';

    final mb = bytes / (1024 * 1024);
    return '${mb.toStringAsFixed(2)} MB';
  }

  @override
  void initState() {
    super.initState();
    updater = widget.updater ?? AppUpdater();
    _load();
  }

  Future<void> _load() async {
    try {
      pkg = await updater.packageInfo();

      info = await updater.fetchUpdateInfo(
        apiBaseUrl: widget.apiBaseUrl,
        token: widget.token,
      );

      final current = pkg!.version;
      final latest = info!.latestVersion;

      hasUpdate = updater.isNewerVersion(current, latest);
      forceUpdate = info!.forceUpdate;

      statusText = hasUpdate
          ? 'Update tersedia: $current → $latest'
          : 'Aplikasi sudah versi terbaru ($current)';

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          statusText = 'Gagal cek update';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> _showPermissionDialog() async {
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Izin Penyimpanan'),
      content: const Text(
        'Aplikasi membutuhkan izin penyimpanan untuk mengunduh update.'
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Lanjut'),
        ),
      ],
    ),
  );
}

  Future<void> _downloadAndInstall() async {
    if (info == null) return;

    setState(() {
      downloading = true;
      progress = 0;
      downloadedBytes = 0;
      totalBytes = 0;
      cancelToken = CancelToken();
    });

    try {
      // WAJIB di awal
      await _showPermissionDialog();
      await updater.ensurePermissions();

      final file = await updater.downloadApk(
        url: info!.apkUrl,
        cancelToken: cancelToken,
      onProgress: (received, total) {
        if (!mounted) return;

        setState(() {
          downloadedBytes = received;
          totalBytes = total;

          if (total > 0) {
            progress = received / total;
          }
        });
      },
      );

      if (!mounted) return;

      await updater.openInstaller(file);

    } catch (e) {
      setState(() {
        statusText = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          downloading = false;
          progress = 0;
          cancelToken = null;
        });
      }
    }
  }

  void _cancelDownload() {
    cancelToken?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final canUpdate = !loading && hasUpdate;

    return PopScope(
      canPop: !(forceUpdate && hasUpdate && !downloading),
      child: AlertDialog(
        title: const Text('Pembaruan Aplikasi'),

        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // STATUS TEXT
              Text(statusText),
              const SizedBox(height: 12),

              // LOADING BAR
              if (loading)
                const LinearProgressIndicator(),

              // CHANGELOG
              if (!loading && hasUpdate && (info?.changelog.isNotEmpty ?? false)) ...[
                const Text(
                  'Perubahan:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                ...info!.changelog.map((e) => Text('• $e')),
                const SizedBox(height: 12),
              ],

              // DOWNLOAD PROGRESS
            if (downloading) ...[
              LinearProgressIndicator(
                value: totalBytes > 0 ? progress : null,
              ),
              const SizedBox(height: 6),

              if (totalBytes > 0)
                Text(
                  '${(progress * 100).toStringAsFixed(0)}% • '
                  '${_formatMb(downloadedBytes)} dari ${_formatMb(totalBytes)}',
                )
              else
                Text(
                  'Mengunduh... ${_formatMb(downloadedBytes)}',
                ),
            ],
            ],
          ),
        ),

        actions: [

          // TOMBOL TUTUP (HIDDEN jika force update)
          if (!(forceUpdate && hasUpdate))
            TextButton(
              onPressed: downloading ? null : () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),

          // CANCEL DOWNLOAD
          if (downloading)
            TextButton(
              onPressed: _cancelDownload,
              child: const Text('Batal'),
            ),

          // BUTTON UPDATE (FIX UTAMA)
          if (canUpdate)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
              ),
              onPressed: downloading ? null : _downloadAndInstall,
              icon: const Icon(Icons.system_update),
              label: Text(
                forceUpdate ? 'Wajib Update' : 'Download',
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}