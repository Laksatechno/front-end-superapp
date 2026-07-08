enum CutiJenis { tahunan, mendadak }
enum CutiStatus { menunggu, ditolak, disetujui }

extension CutiStatusLabel on CutiStatus {
  String get label {
    switch (this) {
      case CutiStatus.menunggu:
        return 'Menunggu';
      case CutiStatus.ditolak:
        return 'Ditolak';
      case CutiStatus.disetujui:
        return 'Disetujui';
    }
  }
}

class CutiItem {
  final int id;
  final CutiJenis jenis;
  final CutiStatus status;
  final DateTime mulai;
  final DateTime sampai;
  final DateTime mulaiKerja;
  final int jumlah;
  final String alasan;

  /// khusus mendadak: surat dokter ada / belum
  final bool? suratAda;

  const CutiItem({
    required this.id,
    required this.jenis,
    required this.status,
    required this.mulai,
    required this.sampai,
    required this.mulaiKerja,
    required this.jumlah,
    required this.alasan,
    required this.suratAda,
  });

  String get jenisLabel => jenis == CutiJenis.tahunan ? 'Tahunan' : 'Mendadak';
  String get statusLabel => status.label;
}
