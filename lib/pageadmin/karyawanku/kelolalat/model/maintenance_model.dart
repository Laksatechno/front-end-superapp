import 'dart:convert';

class MaintenanceModel {
  final int? id;
  final int? employeesId;
  final int? idCustomers;
  final int? alatId;
  final String? kalibrasiAwal;
  final String? kodeRef;
  final String? tglMt;
  final String? jamMt;
  final String? terakhirDigunakan;
  final String? riwayat;
  final String? snBackup;
  final String? fotoHasil;
  final String? ketMt;
  final String? kalibrasiMt;
  final String? lokasiMt;
  final String? createdAt;
  final String? updatedAt;

  final String? noseri;
  final String? valueQc;
  final String? statusAlat;
  final String? condition;
  final String? detailsCondition;
  final String? tanggalInstall;

  final String? namaOutlet;
  final String? alamat;

  final String? employeesName;
  final String? employeesEmail;
  final String? employeesCode;

  const MaintenanceModel({
    this.id,
    this.employeesId,
    this.idCustomers,
    this.alatId,
    this.kalibrasiAwal,
    this.kodeRef,
    this.tglMt,
    this.jamMt,
    this.terakhirDigunakan,
    this.riwayat,
    this.snBackup,
    this.fotoHasil,
    this.ketMt,
    this.kalibrasiMt,
    this.lokasiMt,
    this.createdAt,
    this.updatedAt,
    this.noseri,
    this.valueQc,
    this.statusAlat,
    this.condition,
    this.detailsCondition,
    this.tanggalInstall,
    this.namaOutlet,
    this.alamat,
    this.employeesName,
    this.employeesEmail,
    this.employeesCode,
  });

  String get displayOutlet => namaOutlet ?? '-';
  String get displayNoSeri => noseri ?? '-';
  String get displayTeknisi => employeesName ?? '-';
  String get displayQc {
    if (kalibrasiAwal != null && kalibrasiAwal!.isNotEmpty) return kalibrasiAwal!;
    if (valueQc != null && valueQc!.isNotEmpty) return valueQc!;
    return '-';
  }

  String get displayHasil {
    if (kalibrasiMt != null && kalibrasiMt!.isNotEmpty) return kalibrasiMt!;
    return '-';
  }

  factory MaintenanceModel.fromMap(Map<String, dynamic> map) {
    final alat = map['alat'] is Map
        ? Map<String, dynamic>.from(map['alat'])
        : <String, dynamic>{};

    final customer = map['customer'] is Map
        ? Map<String, dynamic>.from(map['customer'])
        : <String, dynamic>{};

    final employees = map['employees'] is Map
        ? Map<String, dynamic>.from(map['employees'])
        : <String, dynamic>{};

    return MaintenanceModel(
      id: int.tryParse('${map['id'] ?? ''}'),
      employeesId: int.tryParse('${map['employees_id'] ?? ''}'),
      idCustomers: int.tryParse('${map['id_customers'] ?? ''}'),
      alatId: int.tryParse('${map['alat_id'] ?? ''}'),
      kalibrasiAwal: map['kalibrasi_awal']?.toString(),
      kodeRef: map['kode_ref']?.toString(),
      tglMt: map['tgl_mt']?.toString(),
      jamMt: map['jam_mt']?.toString(),
      terakhirDigunakan: map['terakhir_digunakan']?.toString(),
      riwayat: map['riwayat']?.toString(),
      snBackup: map['sn_backup']?.toString(),
      fotoHasil: map['foto_hasil']?.toString(),
      ketMt: map['ket_mt']?.toString(),
      kalibrasiMt: map['kalibrasi_mt']?.toString(),
      lokasiMt: map['lokasi_mt']?.toString(),
      createdAt: map['created_at']?.toString(),
      updatedAt: map['updated_at']?.toString(),
      noseri: alat['noseri']?.toString(),
      valueQc: alat['value_qc']?.toString(),
      statusAlat: alat['status']?.toString(),
      condition: alat['condition']?.toString(),
      detailsCondition: alat['details_condition']?.toString(),
      tanggalInstall: alat['tanggal_install']?.toString(),
      namaOutlet: customer['nama_outlet']?.toString(),
      alamat: customer['alamat']?.toString(),
      employeesName: employees['employees_name']?.toString(),
      employeesEmail: employees['employees_email']?.toString(),
      employeesCode: employees['employees_code']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employees_id': employeesId,
      'id_customers': idCustomers,
      'alat_id': alatId,
      'kalibrasi_awal': kalibrasiAwal,
      'kode_ref': kodeRef,
      'tgl_mt': tglMt,
      'jam_mt': jamMt,
      'terakhir_digunakan': terakhirDigunakan,
      'riwayat': riwayat,
      'sn_backup': snBackup,
      'foto_hasil': fotoHasil,
      'ket_mt': ketMt,
      'kalibrasi_mt': kalibrasiMt,
      'lokasi_mt': lokasiMt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'alat': {
        'noseri': noseri,
        'value_qc': valueQc,
        'status': statusAlat,
        'condition': condition,
        'details_condition': detailsCondition,
        'tanggal_install': tanggalInstall,
      },
      'customer': {
        'nama_outlet': namaOutlet,
        'alamat': alamat,
      },
      'employees': {
        'employees_name': employeesName,
        'employees_email': employeesEmail,
        'employees_code': employeesCode,
      },
    };
  }

  factory MaintenanceModel.fromJson(String source) =>
      MaintenanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}