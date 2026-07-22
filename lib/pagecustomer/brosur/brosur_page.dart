import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import '../../theme/app_theme.dart';
import 'bloc/brosur_bloc.dart';
import 'datasource/brosur_datasource.dart';
import 'model/brosur_model.dart';

class BrosurPage extends StatefulWidget {
  const BrosurPage({super.key});

  @override
  State<BrosurPage> createState() => _BrosurPageState();
}

class _BrosurPageState extends State<BrosurPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  late final BrosurBloc _brosurBloc;

  @override
  void initState() {
    super.initState();
    _brosurBloc = BrosurBloc(datasource: BrosurDatasource())..add(const BrosurEvent.fetch());
    _searchCtrl.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _brosurBloc.add(BrosurEvent.fetch(search: _searchCtrl.text.trim()));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onDownload(Brosur brosur) {
    // Ekstrak nama file dari URL
    final fileName = brosur.downloadUrl.split('/').last + '.pdf';
    _brosurBloc.add(BrosurEvent.download(id: brosur.id, fileName: fileName));
  }

  Future<void> _openFile(String filePath) async {
    final result = await OpenFilex.open(filePath);
    if (result.type != ResultType.done) {
      _showSnackbar('Gagal membuka file: ${result.message}');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _card({required Widget child}) {
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
      child: child,
    );
  }

  Widget _searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          const Icon(Icons.search_rounded, color: Color(0xFF6F646B)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchCtrl,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Cari brosur...',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (_searchCtrl.text.isNotEmpty)
            IconButton(
              onPressed: () {
                _searchCtrl.clear();
                setState(() {});
              },
              icon: const Icon(Icons.close_rounded, color: Color(0xFF6F646B)),
            ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _brosurBloc,
      child: BlocListener<BrosurBloc, BrosurState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message, _) => _showSnackbar(message),
            downloadSuccess: (filePath, _) {
              _showSnackbar('Download berhasil');
              _openFile(filePath);
            },
          );
        },
        child: BlocBuilder<BrosurBloc, BrosurState>(
          builder: (context, state) {
            final filtered = state.maybeWhen(
              loaded: (brosur, _) => brosur,
              downloadSuccess: (_, brosur) => brosur,
              error: (_, brosur) => brosur,
              orElse: () => <Brosur>[],
            );

            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            final downloadingId = state.maybeWhen(
              loaded: (_, id) => id,
              orElse: () => null,
            );

            return Scaffold(
              backgroundColor: AppTheme.bg,
              appBar: AppBar(
                title: const Text('Brosur'),
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
              ),
              body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: _searchBox(),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final it = filtered[i];
                return _card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              it.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: AppTheme.textDark,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              it.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF6F646B),
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: downloadingId == it.id ? null : () => _onDownload(it),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4ECF2),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFEADDE6)),
                          ),
                          child: downloadingId == it.id
                              ? const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                )
                              : const Icon(
                                  Icons.download_rounded,
                                  color: AppTheme.primary,
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                'Brosur tidak ditemukan',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withOpacity(0.45),
                ),
              ),
            ),
        ],
      ),
    );
          },
        ),
      ),
    );
  }
}