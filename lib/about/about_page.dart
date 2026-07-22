import 'package:flutter/material.dart';
import 'package:yofa/theme/app_theme.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Hero Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primary,
                    AppTheme.primary.withOpacity(0.75),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                children: [

                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.apps_rounded,
                      size: 50,
                      color: AppTheme.primary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "YOFA",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Smart Solution For Better Experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 15,
                    ),
                  ),

                ],
              ),
            ),


            const SizedBox(height: 25),


            // About Application
            _sectionCard(
              title: "Tentang Aplikasi",
              icon: Icons.info_outline_rounded,
              child: const Text(
                "YOFA merupakan aplikasi digital yang dirancang "
                "untuk memberikan pengalaman pengguna yang cepat, "
                "mudah, dan modern. Aplikasi ini mengintegrasikan "
                "teknologi terkini untuk membantu pengguna dalam "
                "menyelesaikan aktivitas secara lebih efektif.",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),


            const SizedBox(height: 20),


            // Features
            _sectionCard(
              title: "Fitur Utama",
              icon: Icons.star_outline_rounded,

              child: Column(
                children: [

                  _featureItem(
                    Icons.speed_rounded,
                    "Performa Cepat",
                    "Navigasi ringan dengan pengalaman pengguna yang optimal.",
                  ),

                  _featureItem(
                    Icons.security_rounded,
                    "Aman & Terpercaya",
                    "Data pengguna diproses dengan sistem keamanan modern.",
                  ),

                  _featureItem(
                    Icons.design_services_rounded,
                    "Desain Modern",
                    "Antarmuka clean dengan tampilan yang mudah digunakan.",
                  ),

                ],
              ),
            ),


            const SizedBox(height: 20),


            // Developer
            _sectionCard(
              title: "Developer",
              icon: Icons.code_rounded,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "YOFA Development Team",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Dibangun dengan Flutter untuk menghasilkan "
                    "aplikasi multiplatform yang modern dan responsif.",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Version 1.0.0",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0,5),
          )
        ],
      ),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Icon(
                  icon,
                  color: AppTheme.primary,
                ),
              ),


              const SizedBox(width: 12),


              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),


          const SizedBox(height: 18),

          child,

        ],
      ),
    );
  }




  Widget _featureItem(
      IconData icon,
      String title,
      String subtitle,
      ) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: AppTheme.primary,
            size: 28,
          ),

          const SizedBox(width: 15),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),


                const SizedBox(height: 4),


                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}