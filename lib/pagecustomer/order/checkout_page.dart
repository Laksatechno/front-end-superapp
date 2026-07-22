import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/models/response/auth_response_model.dart';
import 'package:yofa/pagecustomer/history/bloc/history_order_bloc.dart';
import 'package:yofa/pagecustomer/order/bloc/checkout_bloc.dart';
import 'package:yofa/pagecustomer/order/datasource/checkout_user_ds.dart';
import 'package:yofa/pagecustomer/order/orderedsuccess_page.dart';
import 'package:yofa/theme/app_theme.dart';


class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const CheckoutPage({
    super.key,
    required this.items,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late final Future<AuthResponseModel?> _authFuture;
  String paymentType = 'cash';

  @override
  void initState() {
    super.initState();
    _authFuture = AuthLocalDatasource().getAuthData();
  }

  int get subtotal {
    int total = 0;

    for (final item in widget.items) {
      final price = int.tryParse(
            item['price'].toString(),
          ) ??
          0;

      final qty = int.tryParse(
            item['qty'].toString(),
          ) ??
          0;

      total += price * qty;
    }

    return total;
  }


  int get shipping => 0;


  // int get grandTotal => subtotal + shipping;
int get grandTotal => subtotal;


  String currency(int value) {
    return 'Rp ${value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )}';
  }


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => CheckoutBloc(
        checkoutUserDataSource: CheckoutUserDataSource(
          authLocalDatasource: AuthLocalDatasource(),
        ),
      ),

      child: BlocListener<CheckoutBloc, CheckoutState>(

        listener: (context, state) {

          if (state is CheckoutSuccess) {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const OrderSuccessPage(),
              ),
            );

            //panggil bloc history order untuk refresh data
            context.read<HistoryOrderBloc>().add(const HistoryOrderEvent.getOrders());
          }


          if (state is CheckoutError) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                backgroundColor: Colors.red,
              ),
            );

          }

        },


        child: FutureBuilder<AuthResponseModel?>(
          future: _authFuture,
          builder: (context, snapshot) {
            final auth = snapshot.data;
            final userName =
                auth?.employee?.employeesName
                            ?.trim()
                            .isNotEmpty ==
                        true
                    ? auth!.employee!.employeesName!
                    : auth?.user?.name
                                ?.trim()
                                .isNotEmpty ==
                            true
                        ? auth!.user!.name!
                        : 'Nama Pengguna';
            final userAddress =
                auth?.user?.address
                            ?.trim()
                            .isNotEmpty ==
                        true
                    ? auth!.user!.address!
                    : 'Alamat belum tersedia';
            final userPhone =
                auth?.user?.noHp
                            ?.trim()
                            .isNotEmpty ==
                        true
                    ? auth!.user!.noHp!
                    : 'Nomor Telepon belum tersedia';
            if (snapshot.connectionState ==
                ConnectionState.waiting) {

              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            }
            return Scaffold(
              backgroundColor: AppTheme.bg,
              appBar: AppBar(
                backgroundColor: AppTheme.primary,

                foregroundColor: Colors.white,

                elevation: 0,

                title: const Text(
                  'Checkout',
                  style: TextStyle(
                    color: AppTheme.bg,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),


              body: _buildBody(
                context,
                userName,
                userAddress,
                userPhone,
                paymentType,
              ),


              bottomNavigationBar:
                  _buildBottomCheckout(
                    context,
                    userName,
                    userAddress,
                    userPhone,
                    paymentType,
                  ),

            );

          },

        ),

      ),

    );

  }

    Widget _buildBody(
    BuildContext context,
    String userName,
    String userAddress,
    String userPhone,
    String paymentType
  ) {

    return SingleChildScrollView(

      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        120,
      ),


      child: Column(

        children: [


          /// =========================
          /// ADDRESS CARD
          /// =========================

          Container(

            width: double.infinity,

            padding: const EdgeInsets.all(18),


            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(24),


              border: Border.all(
                color: AppTheme.border,
              ),

            ),


            child: Row(

              crossAxisAlignment:
                  CrossAxisAlignment.start,


              children: [


                Container(

                  width: 52,

                  height: 52,


                  decoration: BoxDecoration(

                    color:
                        AppTheme.primary
                            .withOpacity(0.1),

                    borderRadius:
                        BorderRadius.circular(16),

                  ),


                  child: const Icon(

                    Icons.location_on_rounded,

                    color: AppTheme.primary,

                  ),

                ),



                const SizedBox(
                  width: 14,
                ),



                Expanded(

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,


                    children: [


                      const Text(

                        'Alamat Pengiriman',

                        style: TextStyle(

                          fontSize: 15,

                          fontWeight:
                              FontWeight.bold,

                          color:
                              AppTheme.textDark,

                        ),

                      ),



                      const SizedBox(
                        height: 12,
                      ),



                      Row(

                        children: [


                          const Icon(

                            Icons.person,

                            size: 18,

                            color:
                                AppTheme.primary,

                          ),



                          const SizedBox(
                            width: 8,
                          ),



                          Expanded(

                            child: Text(

                              userName,

                              style:
                                  const TextStyle(

                                fontWeight:
                                    FontWeight.w700,

                                color:
                                    AppTheme.textDark,

                              ),

                            ),

                          ),


                        ],

                      ),



                      const SizedBox(
                        height: 10,
                      ),



                      Row(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,


                        children: [


                          const Icon(

                            Icons.home_rounded,

                            size: 18,

                            color:
                                AppTheme.primary,

                          ),



                          const SizedBox(
                            width: 8,
                          ),



                          Expanded(

                            child: Text(

                              userAddress,

                              style:
                                  const TextStyle(

                                color:
                                    AppTheme.textMuted,

                                height: 1.5,

                              ),

                            ),

                          ),

                        ],

                      ),



                      const SizedBox(
                        height: 10,
                      ),



                      Row(

                        children: [


                          const Icon(

                            Icons.phone,

                            size: 18,

                            color:
                                AppTheme.primary,

                          ),



                          const SizedBox(
                            width: 8,
                          ),



                          Text(

                            userPhone,

                            style:
                                const TextStyle(

                              fontWeight:
                                  FontWeight.w700,

                              color:
                                  AppTheme.textDark,

                            ),

                          ),

                        ],

                      ),


                    ],

                  ),

                ),


              ],

            ),

          ),



          const SizedBox(
            height: 18,
          ),




          /// =========================
          /// PRODUCT DETAIL CARD
          /// =========================


          Container(

            width: double.infinity,

            padding: const EdgeInsets.all(18),


            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(24),

              border: Border.all(

                color:
                    AppTheme.border,

              ),

            ),


            child: Column(

              children: [



                Row(

                  children: [


                    const Icon(

                      Icons.storefront,

                      color:
                          AppTheme.primary,

                    ),



                    const SizedBox(
                      width: 10,
                    ),



                    const Expanded(

                      child: Text(

                        'Rincian Pesanan',

                        style:
                            TextStyle(

                          fontSize: 16,

                          fontWeight:
                              FontWeight.bold,

                          color:
                              AppTheme.textDark,

                        ),

                      ),

                    ),



                    Text(

                      '${widget.items.length} Item',

                      style:
                          const TextStyle(

                        color:
                            AppTheme.textMuted,

                      ),

                    ),

                  ],

                ),



                const SizedBox(
                  height: 20,
                ),



                if (widget.items.isEmpty)

                  const Text(

                    'Tidak ada produk dipilih',

                    style:
                        TextStyle(

                      color:
                          AppTheme.textMuted,

                    ),

                  )


                else


                  ...widget.items.map(
                    (item) {

                      final image =
                          item['image']
                              ?.toString()
                              ?? '';


                      final name =
                          item['name']
                              ?.toString()
                              ??
                              'Produk';

                      final productId = item['product_id']
                          ?.toString()
                          ??
                          '0';



                      final qty =
                          int.tryParse(
                            item['qty']
                                .toString(),
                          )
                          ??
                          0;



                      final price =
                          int.tryParse(
                            item['price']
                                .toString(),
                          )
                          ??
                          0;



                      return Padding(

                        padding:
                            const EdgeInsets.only(
                              bottom: 18,
                            ),



                        child: Row(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,


                          children: [


                            _buildProductImage(
                              image,
                            ),



                            const SizedBox(
                              width: 14,
                            ),



                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment.start,


                                children: [


                                  Text(

                                    name ,

                                    style:
                                        const TextStyle(

                                      fontWeight:
                                          FontWeight.bold,

                                      color:
                                          AppTheme.textDark,

                                    ),

                                  ),



                                  // const SizedBox(
                                  //   height: 8,
                                  // ),



                                  // Text(

                                  //   'Jumlah : $qty',

                                  //   style:
                                  //       const TextStyle(

                                  //     color:
                                  //         AppTheme.textMuted,

                                  //   ),

                                  // ),



                                  const SizedBox(
                                    height: 8,
                                  ),



                                  Text(

                                    currency(price),

                                    style:
                                        const TextStyle(

                                      color:
                                          AppTheme.primary,

                                      fontWeight:
                                          FontWeight.bold,

                                    ),

                                  ),


                                ],

                              ),

                            ),



                            Text(
                              'x$qty',
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,

                                color:
                                    AppTheme.textDark,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
              ],

            ),

          ),



          const SizedBox(
            height: 18,
          ),



          _buildPaymentSummary(),

          const SizedBox(
            height: 18,
          ),
          _buildPaymentType(),


        ],

      ),

    );

  }


  Widget _buildPaymentType() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Metode Pembayaran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      paymentType = 'cash';
                    });
                  },
                  child: _paymentCard(
                    title: 'Cash',
                    value: 'cash',
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      paymentType = '1';
                    });
                  },
                  child: _paymentCard(
                    title: 'Tempo 1 Bulan',
                    value: '1',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _paymentCard({
    required String title,
    required String value,
  }) {
    bool selected = paymentType == value;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: selected
            ? AppTheme.primary.withOpacity(0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected
              ? AppTheme.primary
              : AppTheme.border,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio<String>(
            value: value,
            groupValue: paymentType,
            activeColor: AppTheme.primary,
            onChanged: (value) {
              setState(() {
                paymentType = value!;
              });
            },
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildPaymentSummary() {

    return Container(

      width: double.infinity,

      padding:
          const EdgeInsets.all(18),


      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),


        border: Border.all(
          color: AppTheme.border,
        ),

      ),


      child: Column(

        children: [


          Row(

            children: [


              const Icon(

                Icons.receipt_long,

                color:
                    AppTheme.primary,

              ),



              const SizedBox(
                width: 10,
              ),



              const Text(

                'Ringkasan Pembayaran',

                style: TextStyle(

                  fontSize: 16,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      AppTheme.textDark,

                ),

              ),

            ],

          ),



          const SizedBox(
            height: 22,
          ),



          _paymentRow(

            'Subtotal Produk',

            currency(subtotal),

          ),

          _paymentRow(

            'Ongkos Kirim',

            currency(shipping),

          ),



          const SizedBox(
            height: 14,
          ),

          const Padding(

            padding:
                EdgeInsets.symmetric(
              vertical: 18,
            ),


            child: Divider(
              color:
                  AppTheme.border,
            ),

          ),



          _paymentRow(

            'Total Pembayaran',

            currency(grandTotal),

            isTotal: true,

          ),


        ],

      ),

    );

  }





  Widget _buildBottomCheckout(

    BuildContext context,

    String userName,

    String userAddress,

    String userPhone,

    String paymentType,

  ) {


    return SafeArea(

      child: Container(

        padding:
            const EdgeInsets.all(16),


        decoration:
            const BoxDecoration(

          color:
              Colors.white,


          border:

              Border(

            top: BorderSide(

              color:
                  AppTheme.border,

            ),

          ),

        ),



        child: Row(

          children: [


            Expanded(

              child: Column(

                mainAxisSize:
                    MainAxisSize.min,


                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children: [


                  const Text(

                    'Total Pembayaran',

                    style:
                        TextStyle(

                      fontSize: 13,

                      color:
                          AppTheme.textMuted,

                    ),

                  ),



                  const SizedBox(
                    height: 4,
                  ),



                  Text(

                    currency(grandTotal),

                    style:
                        const TextStyle(

                      fontSize: 22,

                      fontWeight:
                          FontWeight.bold,

                      color:
                          AppTheme.primary,

                    ),

                  ),


                ],

              ),

            ),



            const SizedBox(
              width: 14,
            ),



            ElevatedButton(

              onPressed: () {


                if (widget.items.isEmpty) {

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(

                    const SnackBar(

                      content:
                          Text(
                            'Produk belum dipilih',
                          ),

                    ),

                  );


                  return;

                }



                final checkoutItems = widget.items.map((item) {
                  return {
                    "product_id": item['product_id'],
                    "quantity": item['qty'],
                    "price": item['price'],
                  };
                }).toList();

                print("payment type: $paymentType" );


                context
                    .read<CheckoutBloc>()
                    .add(
                      CheckoutRequested(
                        items: checkoutItems,
                        userName: userName,
                        userAddress: userAddress,
                        userPhone: userPhone,
                        paymentType: paymentType,
                      ),
                    );
              },


              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    AppTheme.primary,


                foregroundColor:
                    Colors.white,


                elevation:
                    0,


                padding:

                    const EdgeInsets.symmetric(

                  horizontal:
                      26,

                  vertical:
                      16,

                ),



                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(18),

                ),

              ),



              child:
                  const Text(

                'Buat Pesanan',

                style:
                    TextStyle(

                  fontWeight:
                      FontWeight.bold,

                ),

              ),


            ),


          ],

        ),

      ),

    );

  }





  Widget _paymentRow(

    String title,

    String value, {

    bool isTotal = false,

  }) {


    return Row(

      children: [


        Expanded(

          child: Text(

            title,

            style:
                TextStyle(

              fontSize:
                  isTotal ? 16 : 14,


              fontWeight:
                  isTotal

                      ? FontWeight.bold

                      : FontWeight.normal,


              color:
                  isTotal

                      ? AppTheme.textDark

                      : AppTheme.textMuted,


            ),

          ),

        ),



        Text(

          value,

          style:
              TextStyle(

            fontSize:
                isTotal ? 18 : 14,


            fontWeight:
                FontWeight.bold,


            color:
                isTotal

                    ? AppTheme.primary

                    : AppTheme.textDark,


          ),

        ),


      ],

    );

  }

    Widget _buildProductImage(String imageUrl) {

    if (imageUrl.isEmpty) {

      return _buildImagePlaceholder();

    }


    final url =
        imageUrl.startsWith('http')
            ? imageUrl
            : Variables.storageUrl + imageUrl;



    return ClipRRect(

      borderRadius:
          BorderRadius.circular(18),


      child: Image.network(

        url,


        width: 82,

        height: 82,


        fit: BoxFit.cover,


        errorBuilder:
            (context, error, stackTrace) {

          return _buildImagePlaceholder();

        },


        loadingBuilder:
            (context, child, loadingProgress) {


          if (loadingProgress == null) {

            return child;

          }


          return _buildImagePlaceholder();


        },


      ),

    );

  }





  Widget _buildImagePlaceholder() {


    return Container(

      width: 82,

      height: 82,


      decoration: BoxDecoration(

        color:
            const Color(0xffF5F7FA),


        borderRadius:
            BorderRadius.circular(18),


      ),


      child: Center(

        child: Container(

          width: 42,

          height: 42,


          decoration: BoxDecoration(

            color:
                AppTheme.primary
                    .withOpacity(0.12),


            shape:
                BoxShape.circle,


          ),



          child: const Icon(

            Icons.medical_services_rounded,


            color:
                AppTheme.primary,


            size:
                24,


          ),


        ),

      ),

    );

  }

}

