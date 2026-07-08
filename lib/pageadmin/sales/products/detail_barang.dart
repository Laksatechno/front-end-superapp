import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yofa/pageadmin/sales/products/bloc/product_bloc.dart';
import 'package:yofa/pageadmin/sales/products/model/products_model.dart';
import '../../../theme/app_theme.dart';

class DetailBarangPage extends StatefulWidget {
  final int productId;
  const DetailBarangPage({super.key, required this.productId});

  @override
  State<DetailBarangPage> createState() => _DetailBarangPageState();
}

class _DetailBarangPageState extends State<DetailBarangPage> {
  String _productName = '-';

  // ===== Batch Form Controllers =====
  final TextEditingController _batchNoCtrl = TextEditingController();
  final TextEditingController _qtyCtrl = TextEditingController(text: '1');
  final TextEditingController _nieCtrl = TextEditingController();
  final TextEditingController _tipeCtrl = TextEditingController();
  final TextEditingController _serialCtrl = TextEditingController();
  final List<String> _serialNumbers = [];
  bool _isSerialized = false;
  DateTime? _expDate;

  // ===== Batch List (akan diisi dari API saat detail loaded) =====
  final List<_BatchItem> _batches = [];


  int get _totalStock => _batches.fold(0, (a, b) => a + b.qty);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(ProductEvent.getProductDetail(id: widget.productId));
    });
  }

  @override
  void dispose() {
    _serialCtrl.dispose();
    _batchNoCtrl.dispose();
    _qtyCtrl.dispose();
    _nieCtrl.dispose();
    _tipeCtrl.dispose();
    super.dispose();
  }

  // ===== Helpers =====
  String _fmtDate(DateTime? d) {
    if (d == null) return '--:--:--';
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    return '$dd/$mm/${d.year}';
  }

  DateTime _parseDateOrNow(String? v) {
    if (v == null || v.isEmpty) return DateTime.now();
    return DateTime.tryParse(v) ?? DateTime.now(); // "--:--:--";
  }

  int _qtyFromString(String v) {
    // API qty_on_hand: "500.0000"
    final d = double.tryParse(v) ?? 0;
    return d.round();
  }

  Future<void> _pickExp() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _expDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 20),
    );
    if (picked == null) return;
    setState(() => _expDate = picked);
  }

  void _incFormQty() {
    final cur = int.tryParse(_qtyCtrl.text.trim()) ?? 0;
    _qtyCtrl.text = '${cur + 1}';
    setState(() {});
  }

  void _decFormQty() {
    final cur = int.tryParse(_qtyCtrl.text.trim()) ?? 0;
    final next = (cur - 1) < 1 ? 1 : (cur - 1);
    _qtyCtrl.text = '$next';
    setState(() {});
  }

void _addBatch() {
  final batchNo = _batchNoCtrl.text.trim();

  if (batchNo.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Batch No wajib diisi')),
    );
    return;
  }

  if (_isSerialized && _serialNumbers.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nomor seri harus diisi')),
    );
    return;
  }

  final qty = _isSerialized
      ? _serialNumbers.length
      : int.tryParse(_qtyCtrl.text.trim()) ?? 0;

  final request = CreateBatchRequest(
    productId: widget.productId,
    batchNo: batchNo,
    qty: qty,
    nie: _nieCtrl.text.trim().isEmpty ? null : _nieCtrl.text.trim(),
    typeModel: _tipeCtrl.text.trim().isEmpty ? null : _tipeCtrl.text.trim(),
    expDate: _expDate,
    serialNumbers: _isSerialized ? _serialNumbers : null,
  );

  context.read<ProductBloc>().add(
        ProductEvent.createBatch(request: request),
      );
}

  void _openEditBatch(_BatchItem item) {
    final TextEditingController batchCtrl = TextEditingController(text: item.batchNo);
    final TextEditingController nieCtrl = TextEditingController(text: item.nie);
    final TextEditingController tipeCtrl = TextEditingController(text: item.tipe);
    DateTime exp = item.exp;
    int qty = item.qty;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setLocal) {
            Future<void> pickExpLocal() async {
              final picked = await showDatePicker(
                context: ctx,
                initialDate: exp,
                firstDate: DateTime(DateTime.now().year - 1),
                lastDate: DateTime(DateTime.now().year + 20),
              );
              if (picked == null) return;
              setLocal(() => exp = picked);
            }

            void incQty() => setLocal(() => qty += 1);
            void decQty() => setLocal(() => qty = (qty - 1) < 0 ? 0 : (qty - 1));

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
                child: SizedBox(
                  height: MediaQuery.of(ctx).size.height * 0.82,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 12, 10),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Edit Batch',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.textDark,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text(
                                'Tutup',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: Color(0xFFEFE6EC)),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _fieldCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Batch No',
                                        style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                                    const SizedBox(height: 8),
                                    _textBox(controller: batchCtrl, hint: 'Contoh: BCH-003'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              _fieldCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('NIE',
                                        style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                                    const SizedBox(height: 8),
                                    _textBox(controller: nieCtrl, hint: 'Masukkan NIE'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              _fieldCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Tipe',
                                        style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                                    const SizedBox(height: 8),
                                    _textBox(controller: tipeCtrl, hint: 'REG / BPOM / dll'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              _fieldCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('EXP',
                                        style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: pickExpLocal,
                                      borderRadius: BorderRadius.circular(14),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF9F6F8),
                                          borderRadius: BorderRadius.circular(14),
                                          border: Border.all(color: const Color(0xFFEFE6EC)),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.event_outlined, color: AppTheme.primary, size: 18),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                _fmtDate(exp),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: AppTheme.textDark,
                                                ),
                                              ),
                                            ),
                                            const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6F646B)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              _fieldCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Qty',
                                        style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        _circleIconBtn(icon: Icons.remove_rounded, onTap: decQty),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                            height: 46,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF9F6F8),
                                              borderRadius: BorderRadius.circular(14),
                                              border: Border.all(color: const Color(0xFFEFE6EC)),
                                            ),
                                            child: Text(
                                              '$qty',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: AppTheme.textDark,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        _circleIconBtn(icon: Icons.add_rounded, onTap: incQty),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (_isSerialized) ...[
                                const SizedBox(height: 12),

                                const Text(
                                  'No Seri',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.textDark,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _textBox(
                                        controller: _serialCtrl,
                                        hint: 'Masukkan nomor seri',
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    _circleIconBtn(
                                      icon: Icons.add,
                                      onTap: () {
                                        final serial = _serialCtrl.text.trim();
                                        if (serial.isEmpty) return;

                                        setState(() {
                                          _serialNumbers.add(serial);
                                          _serialCtrl.clear();
                                        });
                                      },
                                    )
                                  ],
                                ),

                                const SizedBox(height: 10),

                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: _serialNumbers.map((s) {
                                    return Chip(
                                      label: Text(s),
                                      deleteIcon: const Icon(Icons.close, size: 18),
                                      onDeleted: () {
                                        setState(() {
                                          _serialNumbers.remove(s);
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              onPressed: () {
                                final newBatch = batchCtrl.text.trim();
                                final newNie = nieCtrl.text.trim();
                                final newTipe = tipeCtrl.text.trim();

                                if (newBatch.isEmpty || newNie.isEmpty || newTipe.isEmpty) {
                                  ScaffoldMessenger.of(ctx).showSnackBar(
                                    const SnackBar(content: Text('Batch/NIE/Tipe tidak boleh kosong')),
                                  );
                                  return;
                                }

                                setState(() {
                                  final idx = _batches.indexWhere((e) => e.id == item.id);
                                  if (idx != -1) {
                                    _batches[idx] = _batches[idx].copyWith(
                                      batchNo: newBatch,
                                      nie: newNie,
                                      tipe: newTipe,
                                      exp: exp,
                                      qty: qty,
                                    );
                                  }
                                });

                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Batch berhasil disimpan')),
                                );
                              },
                              child: const Text('Simpan', style: TextStyle(fontWeight: FontWeight.w900)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      batchCtrl.dispose();
      nieCtrl.dispose();
      tipeCtrl.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (data, page, perPage, search, selected) {
            if (selected == null) return;

            _isSerialized = selected.isSerialized;

            setState(() {
              _productName = selected.name;

              _batches
                ..clear()
                ..addAll(
                  selected.batches.map((b) {
                    return _BatchItem(
                      id: b.id,
                      batchNo: b.batchNo,
                      qty: _qtyFromString(b.qtyOnHand),
                      nie: (b.nie ?? '-'),
                      tipe: (b.typeModel ?? '-'),
                      exp: _parseDateOrNow(b.expDate),
                    );
                  }),
                );
            });
          },

          // TAMBAHKAN INI
          batchCreated: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );

            // reload product detail
            context.read<ProductBloc>().add(
              ProductEvent.getProductDetail(id: widget.productId),
            );
          },

          error: (msg) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg)),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: AppTheme.bg,
        appBar: AppBar(
          title: const Text('Detail Barang'),
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          children: [
            // Card Product (UI tetap)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEFE6EC)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x06000000),
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4ECF2),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFEADDE6)),
                    ),
                    child: const Icon(Icons.inventory_2_outlined, color: AppTheme.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _pill('Total Stok: $_totalStock', solid: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            _sectionTitle('Tambah Batch'),
            const SizedBox(height: 10),

            _fieldCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Batch No', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  _textBox(controller: _batchNoCtrl, hint: 'Contoh: BCH-003'),
                  const SizedBox(height: 12),

                  const Text('Qty', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _circleIconBtn(icon: Icons.remove_rounded, onTap: _decFormQty),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _textBox(
                          controller: _qtyCtrl,
                          hint: 'Qty',
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 10),
                      _circleIconBtn(icon: Icons.add_rounded, onTap: _incFormQty),
                    ],
                  ),
                  const SizedBox(height: 12),

                  const Text('NIE', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  _textBox(controller: _nieCtrl, hint: 'Masukkan NIE'),
                  const SizedBox(height: 12),

                  const Text('Tipe', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  _textBox(controller: _tipeCtrl, hint: 'REG / BPOM / dll'),
                  const SizedBox(height: 12),

                  const Text('EXP', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _pickExp,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F6F8),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFEFE6EC)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.event_outlined, color: AppTheme.primary, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _expDate == null ? 'Pilih tanggal EXP' : _fmtDate(_expDate),
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: _expDate == null ? const Color(0xFF6F646B) : AppTheme.textDark,
                              ),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6F646B)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: _addBatch,
                      child: const Text('Tambah', style: TextStyle(fontWeight: FontWeight.w900)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            _sectionTitle('Daftar Batch'),
            const SizedBox(height: 10),

            ..._batches.map((b) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _batchCard(b),
                )),
          ],
        ),
      ),
    );
  }

  // ===== UI Widgets (tetap sama) =====
  Widget _sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }

  Widget _fieldCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
      ),
      child: child,
    );
  }

  Widget _textBox({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    TextAlign textAlign = TextAlign.start,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textAlign: textAlign,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFF9F6F8),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFEFE6EC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFEFE6EC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppTheme.primary, width: 1.2),
        ),
      ),
    );
  }

  Widget _batchCard(_BatchItem b) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF4ECF2),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEADDE6)),
            ),
            child: const Icon(Icons.layers_outlined, color: AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  b.batchNo,
                  style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _pill('NIE: ${b.nie}'),
                    _pill('Tipe: ${b.tipe}'),
                    _pill('EXP: ${_fmtDate(b.exp)}', solid: true),
                    _pill('Qty: ${b.qty}', solid: true),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => _openEditBatch(b),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF4ECF2),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEADDE6)),
              ),
              child: const Icon(Icons.edit_outlined, color: AppTheme.primary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIconBtn({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF4ECF2),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFEADDE6)),
        ),
        child: Icon(icon, color: AppTheme.primary),
      ),
    );
  }

  Widget _pill(String text, {bool solid = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: solid ? const Color(0xFFF4ECF2) : Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}

class _BatchItem {
  final int id;
  final String batchNo;
  final int qty;
  final String nie;
  final String tipe;
  final DateTime exp;

  const _BatchItem({
    required this.id,
    required this.batchNo,
    required this.qty,
    required this.nie,
    required this.tipe,
    required this.exp,
  });

  _BatchItem copyWith({
    String? batchNo,
    int? qty,
    String? nie,
    String? tipe,
    DateTime? exp,
  }) {
    return _BatchItem(
      id: id,
      batchNo: batchNo ?? this.batchNo,
      qty: qty ?? this.qty,
      nie: nie ?? this.nie,
      tipe: tipe ?? this.tipe,
      exp: exp ?? this.exp,
    );
  }
}