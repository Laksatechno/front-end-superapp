import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/pagecustomer/tagihan/bloc/tagihan_bloc.dart';
import 'package:yofa/pagecustomer/tagihan/datasource/tagihan_datasource.dart';
import 'package:yofa/pagecustomer/tagihan/model/tagihan_model.dart';
import 'package:yofa/theme/app_theme.dart';
import 'payment_page.dart';

class TagihanPage extends StatelessWidget {
  const TagihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TagihanBloc(TagihanDatasource())
        ..add(const TagihanEvent.started()),
      child: const _TagihanPageContent(),
    );
  }
}

class _TagihanPageContent extends StatefulWidget {
  const _TagihanPageContent({super.key});

  @override
  State<_TagihanPageContent> createState() => _TagihanPageState();
}

class _TagihanPageState extends State<_TagihanPageContent> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TagihanBloc, TagihanState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message, items) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF5F7FB),
        appBar: AppBar(
          title: const Text(
            'Tagihan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final desktop = constraints.maxWidth > 900;

            return Padding(
              padding: EdgeInsets.all(desktop ? 32 : 16),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      context.read<TagihanBloc>().add(
                        TagihanEvent.searchChanged(search: value),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari nomor invoice...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<TagihanBloc, TagihanState>(
                    builder: (context, state) {
                      final total = state.maybeWhen(
                        loaded: (_, __, ___, ____, _____, totalTagihan) => totalTagihan,
                        orElse: () => 0,
                      );
                      final count = state.maybeWhen(
                        loaded: (items, _, __, ___, ____, _____) => items.length,
                        orElse: () => 0,
                      );

                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Tagihan',
                              style: TextStyle(color: Colors.white70, fontSize: 15),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Rp $total',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '$count Invoice',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: BlocBuilder<TagihanBloc, TagihanState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const Center(child: CircularProgressIndicator()),
                          loading: (items, _) => items.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : _buildList(items, context),
                          loaded: (items, _, __, ___, ____, _____) => _buildList(items, context),
                          error: (message, items) => items.isEmpty
                              ? Center(child: Text(message))
                              : _buildList(items, context),
                        );
                      },
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

  Widget _buildList(List<Tagihan> items, BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('Tidak ada tagihan'));
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<TagihanBloc>().add(const TagihanEvent.started());
      },
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return InvoiceCard(
            invoice: item,
          onPay: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PaymentPage(invoice: item)),
            );
            if (mounted) {
              context.read<TagihanBloc>().add(const TagihanEvent.refresh());
            }
          },
          );
        },
      ),
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final Tagihan invoice;
  final VoidCallback onPay;

  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.onPay,
  });

@override
  Widget build(BuildContext context) {
    final paid = invoice.isPaid;
    final waiting = invoice.isPending;
    final verifikasiAdmin = invoice.isVerifikasiAdmin;

    Color statusColor;
    Color statusBgColor;
    IconData statusIcon;

    if (paid) {
      statusColor = Colors.green;
      statusBgColor = Colors.green.shade50;
      statusIcon = Icons.check_circle;
    } else if (verifikasiAdmin) {
      statusColor = Colors.blue;
      statusBgColor = Colors.blue.shade50;
      statusIcon = Icons.fact_check;
    } else {
      // waiting
      statusColor = Colors.orange;
      statusBgColor = Colors.orange.shade50;
      statusIcon = Icons.access_time;
    }


    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      invoice.invoiceNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Tagihan',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),

                  ],
                ),
              ),


              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  children: [

                    Icon(
                      statusIcon,
                      size: 16,
                      color: statusColor,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      invoice.displayStatus,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),


          const SizedBox(height: 8),


          Text(
            'Total Pembayaran',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),


          const SizedBox(height: 4),


          Text(
            'Rp ${invoice.total}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),


          const SizedBox(height: 18),


          // Tombol bayar hanya jika masih menunggu
          if (waiting)
            SizedBox(
              width: double.infinity,
              height: 45,

              child: ElevatedButton.icon(
                onPressed: onPay,

                icon: const Icon(
                  Icons.payment,
                  size: 18,
                ),

                label: const Text(
                  'Bayar Sekarang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),



          // Status verifikasi admin
          if (verifikasiAdmin)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.hourglass_top,
                    color: Colors.blue,
                    size: 18,
                  ),

                  SizedBox(width: 8),

                  Text(
                    'Pembayaran sedang diverifikasi admin',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              ),
            ),



          // Status lunas
          if (paid)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),

              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.verified,
                    color: Colors.green,
                    size: 18,
                  ),

                  SizedBox(width: 8),

                  Text(
                    'Pembayaran telah lunas',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}