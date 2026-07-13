import 'package:flutter/material.dart';
import 'package:yofa/pagecustomer/history/model/history_order_model.dart';
import 'package:yofa/theme/app_theme.dart';


class ShipmentTrackingPage extends StatelessWidget {

  final CustomerOrderHistory order;

  const ShipmentTrackingPage({
    super.key,
    required this.order,
  });


  @override
  Widget build(BuildContext context) {

    final shipment = order.shipment;
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primary,
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Detail Pengiriman",
          style: TextStyle(
            fontSize:18,
            fontWeight:FontWeight.w700,

          ),

        ),

      ),


      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [


            _ShipmentHeader(
              order: order,
            ),


            const SizedBox(height:22),



            const Text(

              "Status Pengiriman",

              style: TextStyle(

                fontSize:17,

                fontWeight:FontWeight.bold,

              ),

            ),


            const SizedBox(height:14),



            if(shipment != null &&
                shipment.statuses.isNotEmpty)

            _Timeline(
              statuses: shipment.statuses,
            ),
            if (shipment?.photoProof != null &&
                shipment!.photoProof!.isNotEmpty)

              const SizedBox(height:20),


            if (shipment?.photoProof != null &&
                shipment!.photoProof!.isNotEmpty)

              _PhotoProofCard(

                imageUrl: shipment.photoProof!,

              ),
            const SizedBox(height:20),
          ],

        ),

      ),

    );

  }

}




class _ShipmentHeader extends StatelessWidget {


  final CustomerOrderHistory order;


  const _ShipmentHeader({
    required this.order,
  });



  @override
  Widget build(BuildContext context){


    final shipment = order.shipment;


    final currentStatus =
        shipment != null &&
        shipment.statuses.isNotEmpty

        ? shipment.statuses.last.status

        : "Menunggu pengiriman";


    return Container(


      padding: const EdgeInsets.all(18),


      decoration: BoxDecoration(
        color:
        AppTheme.primary,
        borderRadius:
        BorderRadius.circular(22),
        boxShadow:[
          BoxShadow(
            color:
            AppTheme.primary.withOpacity(.25),
            blurRadius:15,

            offset:
            const Offset(0,8),

          )

        ]

      ),



      child:Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,


        children:[


          Row(

            children:[


              Container(

                padding:
                const EdgeInsets.all(12),


                decoration:BoxDecoration(

                  color:
                  Colors.white.withOpacity(.2),

                  borderRadius:
                  BorderRadius.circular(15),

                ),
                child:
                const Icon(

                  Icons.local_shipping_rounded,

                  color:Colors.white,

                  size:28,

                ),

              ),


              const SizedBox(width:14),



              const Expanded(

                child:Text(

                  "Pengiriman Pesanan",

                  style:TextStyle(

                    color:Colors.white,

                    fontSize:16,

                    fontWeight:
                    FontWeight.bold,

                  ),

                ),

              ),



            ],

          ),



          const SizedBox(height:18),



          Text(

            currentStatus,

            style:const TextStyle(

              color:Colors.white,

              fontSize:15,

              fontWeight:
              FontWeight.w700,

            ),

          ),



          const SizedBox(height:8),



          Text(

            "Invoice ${order.invoice}",

            style:TextStyle(

              color:
              Colors.white.withOpacity(.85),

              fontSize:13,

            ),

          ),



          if(shipment?.deliveryDate != null)

            Padding(

              padding:
              const EdgeInsets.only(top:5),

              child:Text(

                "Dikirim: ${shipment!.deliveryDate}",

                style:TextStyle(

                  color:
                  Colors.white.withOpacity(.85),

                  fontSize:13,

                ),

              ),

            )


        ],

      ),

    );


  }


}






class _Timeline extends StatelessWidget {


  final List<ShipmentStatus> statuses;


  const _Timeline({

    required this.statuses,

  });



  @override
  Widget build(BuildContext context){


    return Container(


      padding:
      const EdgeInsets.all(18),


      decoration:BoxDecoration(

        color:Colors.white,

        borderRadius:
        BorderRadius.circular(20),

      ),



      child:Column(

        children:

        statuses.asMap().entries.map((entry){


          final index =
          entry.key;


          final item =
          entry.value;


          final isLast =
          index == statuses.length-1;



          return Row(


            crossAxisAlignment:
            CrossAxisAlignment.start,


            children:[



              Column(

                children:[


                  Container(

                    width:24,

                    height:24,


                    decoration:
                    BoxDecoration(

                      shape:
                      BoxShape.circle,


                      color:isLast

                      ? Colors.green

                      : Colors.blue,

                    ),



                    child:Icon(

                      isLast

                      ? Icons.check

                      : Icons.local_shipping,

                      size:14,

                      color:Colors.white,

                    ),


                  ),



                  if(!isLast)

                    Container(

                      width:2,

                      height:65,

                      color:
                      Colors.blue.shade100,

                    )


                ],

              ),



              const SizedBox(width:16),



              Expanded(

                child:Container(

                  margin:
                  const EdgeInsets.only(
                    bottom:22,
                  ),


                  padding:
                  const EdgeInsets.all(14),


                  decoration:BoxDecoration(

                    color:isLast

                    ? Colors.green.withOpacity(.08)

                    : Colors.grey.withOpacity(.05),


                    borderRadius:
                    BorderRadius.circular(14),


                  ),


                  child:Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,


                    children:[


                      Text(

                        item.status,

                        style:TextStyle(

                          fontSize:14,

                          fontWeight:

                          isLast

                          ? FontWeight.bold

                          : FontWeight.w500,

                        ),

                      ),



                      const SizedBox(height:6),



                      Text(

                        item.timestamp,

                        style:const TextStyle(

                          fontSize:12,

                          color:Colors.grey,

                        ),

                      ),
                      
                      // Tampilkan foto jika ada

                    ],

                  ),


                ),

              )


            ],

          );



        }).toList(),

      ),

    );


  }


}





class _EmptyShipment extends StatelessWidget {


  @override
  Widget build(BuildContext context){

    return Container(

      width:double.infinity,

      padding:
      const EdgeInsets.all(20),


      decoration:BoxDecoration(

        color:Colors.white,

        borderRadius:
        BorderRadius.circular(18),

      ),


      child:Column(

        children:[


          Icon(

            Icons.inventory_2_outlined,

            size:45,

            color:Colors.grey.shade400,

          ),


          const SizedBox(height:10),


          const Text(

            "Belum ada informasi pengiriman",

            style:TextStyle(

              color:Colors.grey,

              fontWeight:FontWeight.w500,

            ),

          )

        ],

      ),

    );

  }

}

class _PhotoProofCard extends StatelessWidget {


  final String imageUrl;


  const _PhotoProofCard({
    required this.imageUrl,
  });



  @override
  Widget build(BuildContext context){
    return InkWell(

      borderRadius:
      BorderRadius.circular(18),
      onTap:(){
        print ('foto' + imageUrl);
        Navigator.push(

          context,

          MaterialPageRoute(

            builder:(_)=>
            _PreviewPhotoPage(
              imageUrl:imageUrl,
            ),

          ),

        );

      },


      child:Container(

        padding:
        const EdgeInsets.all(16),


        decoration:BoxDecoration(

          color:Colors.white,

          borderRadius:
          BorderRadius.circular(18),


          boxShadow:[

            BoxShadow(

              color:
              Colors.black.withOpacity(.05),

              blurRadius:10,

            )

          ],

        ),


        child:Row(

          children:[


            Container(

              width:45,

              height:45,

              decoration:BoxDecoration(

                color:
                Colors.green.withOpacity(.1),

                borderRadius:
                BorderRadius.circular(14),

              ),


              child:
              const Icon(

                Icons.photo_camera_outlined,

                color:Colors.green,

              ),

            ),


            const SizedBox(width:14),
            const Expanded(

              child:Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children:[

                  Text(

                    "Bukti Pengiriman",

                    style:TextStyle(

                      fontWeight:
                      FontWeight.bold,

                      fontSize:15,

                    ),

                  ),


                  SizedBox(height:4),


                  Text(

                    "Lihat foto barang telah diterima",

                    style:TextStyle(

                      fontSize:12,

                      color:Colors.grey,

                    ),

                  ),

                ],

              ),

            ),


            const Icon(

              Icons.chevron_right,

              color:Colors.grey,

            )


          ],

        ),

      ),

    );

  }

}

class _PreviewPhotoPage extends StatelessWidget {


final String imageUrl;

const _PreviewPhotoPage({
required this.imageUrl
});



@override
Widget build(BuildContext context){


return Scaffold(

backgroundColor:
Colors.black,


appBar:AppBar(

backgroundColor:
Colors.black,

title:
const Text(
"Bukti Pengiriman"
),

),


body:
Center(

child:
InteractiveViewer(

child:
Image.network(

imageUrl,

fit:
BoxFit.contain,

errorBuilder:
(context,error,stack)=>

const Icon(

Icons.broken_image,

color:Colors.white,

size:60,

),

),

),

),


);


}

}