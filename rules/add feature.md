Saya ingin kamu membuat fitur Flutter/Dart baru dengan arsitektur yang sama persis.

Gunakan struktur folder seperti ini:

lib/
└── pageadmin/
    └── [module]/
        └── [feature]/
            ├── bloc/
            │   ├── [feature]_bloc.dart
            │   ├── [feature]_event.dart
            │   ├── [feature]_state.dart
            │   └── [feature]_bloc.freezed.dart
            ├── datasource/
            │   └── [feature]_ds.dart
            ├── model/
            │   └── [feature]_model.dart
            └── view/
                └── [feature]_page.dart

Gunakan package dan pola berikut:
- flutter_bloc
- freezed_annotation
- dartz Either
- http
- AuthLocalDatasource untuk mengambil token
- Variables.baseUrl untuk base URL API
- Bloc menggunakan event: get data, refresh, changeFilter
- State menggunakan: initial, loading, loaded, error, success
- DataSource return Future<Either<String, List<Model>>>
- Model wajib memiliki fromMap, toMap, fromJson, toJson
- View wajib responsive untuk mobile, tablet, desktop
- UI mengikuti AppTheme yang sudah ada
- Jangan membuat dummy data di view jika data berasal dari API
- Gunakan BlocBuilder / BlocConsumer untuk menampilkan loading, error, empty state, dan data
- Gunakan RefreshIndicator
- Gunakan search dan filter jika dibutuhkan
- Gunakan pagination/perPage jika endpoint mendukung
- Kode harus lengkap, rapi, dan langsung bisa dipakai

Theme yang digunakan:

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color.fromRGBO(101, 39, 105, 1);
  static const Color bg = Color(0xFFF7F3F6);
  static const Color textDark = Color(0xFF2D232B);
  static const Color textMuted = Color(0xFF7C6F77);
  static const Color hint = Color(0xFF9A8F97);
  static const Color border = Color(0xFFE7DAE3);

  static ThemeData themeData() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
    );
  }
}

Format Bloc wajib mengikuti contoh ini:

[Feature]Bloc extends Bloc<[Feature]Event, [Feature]State> {
  final [Feature]DataSource _remote;

  [Feature]Bloc(this._remote) : super(const [Feature]State.initial()) {
    on<_Get[Features]>(_onGet[Features]);
    on<_Refresh[Features]>(_onRefresh[Features]);
    on<_ChangeFilter>(_onChangeFilter);
  }
}

Event wajib berisi:

const factory [Feature]Event.get[Features]({
  @Default(1) int page,
  @Default(10) int perPage,
  String? filterType,
  String? status,
  String? search,
}) = _Get[Features];

const factory [Feature]Event.refresh({
  @Default(1) int page,
  @Default(10) int perPage,
  String? filterType,
  String? status,
  String? search,
}) = _Refresh[Features];

const factory [Feature]Event.changeFilter({
  @Default(10) int perPage,
  String? filterType,
  String? status,
  String? search,
}) = _ChangeFilter;

State wajib berisi:

const factory [Feature]State.initial() = _Initial;
const factory [Feature]State.loading() = _Loading;

const factory [Feature]State.loaded({
  required List<[Model]> data,
  @Default(1) int page,
  @Default(10) int perPage,
  String? filterType,
  String? status,
  String? search,
}) = _Loaded;

const factory [Feature]State.error(String message) = _Error;
const factory [Feature]State.success(String message) = _Success;

DataSource wajib:
- mengambil token dari AuthLocalDatasource().getAuthData()
- jika token kosong return Left('Authorization token is missing')
- request ke API memakai Authorization Bearer token
- Accept application/json
- Content-Type application/json
- handle statusCode selain 200
- handle response JSON dengan aman
- mapping data list ke model

Contoh pola endpoint:
GET ${Variables.baseUrl}/[endpoint]
query:
- page
- per_page
- filter_type
- status
- search

Response API bisa berbentuk:
{
  "success": true,
  "message": "...",
  "data": {
    "data": [
      ...
    ]
  }
}

atau:
{
  "success": true,
  "data": [
    ...
  ]
}

Buat parser yang aman untuk kedua bentuk response tersebut.

View wajib:
- menggunakan Scaffold
- AppBar warna AppTheme.primary
- search bar
- filter chip/dropdown jika dibutuhkan
- card list responsive
- empty state
- loading state
- error state dengan tombol refresh
- tombol tambah/edit/delete jika fitur membutuhkan CRUD
- layout tidak overflow di mobile
- tablet/desktop menggunakan maxWidth atau GridView jika cocok
- semua widget kecil dipisah agar rapi

Tambahkan juga kode BlocProvider untuk main.dart seperti ini:

BlocProvider(
  create: (_) => [Feature]Bloc([Feature]DataSource())
    ..add(const [Feature]Event.get[Features](page: 1, perPage: 200)),
),

Sekarang buatkan fitur berikut:

Nama fitur:
[ISI NAMA FITUR]

Folder:
[ISI PATH FOLDER]

Nama model:
[ISI NAMA MODEL]

Endpoint list:
[ISI ENDPOINT]

Field model:
[ISI FIELD JSON DAN TIPE DATANYA]

Filter yang dibutuhkan:
[ISI FILTER, JIKA TIDAK ADA TULIS TIDAK ADA]

Aksi halaman:
[contoh: tambah, edit, hapus, detail, download, dll]

Catatan tambahan:
[ISI CATATAN TAMBAHAN]

Output yang saya mau:
1. Struktur folder
2. Kode lengkap model
3. Kode lengkap datasource
4. Kode lengkap bloc
5. Kode lengkap event
6. Kode lengkap state
7. Kode lengkap view
8. Kode BlocProvider di main.dart
9. Perintah build_runner:
   dart run build_runner build --delete-conflicting-outputs