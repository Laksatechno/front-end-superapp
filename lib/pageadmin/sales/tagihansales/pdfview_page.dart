import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

class PDFViewPage extends StatefulWidget {
  final String path;

  const PDFViewPage({super.key, required this.path});

  @override
  State<PDFViewPage> createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  bool isPrinting = false;

  ///  PRINT PDF
  Future<void> _printPdf() async {
    try {
      setState(() => isPrinting = true);

      final file = File(widget.path);
      final bytes = await file.readAsBytes();

      await Printing.layoutPdf(
        onLayout: (format) async => bytes,
      );

    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal print: $e')),
      );
    } finally {
      setState(() => isPrinting = false);
    }
  }

  ///  SAVE PDF ke storage
Future<void> _savePdf() async {
  try {
    // Request permission
    var status = await Permission.manageExternalStorage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission ditolak')),
      );
      return;
    }

    // Path ke folder Download
    Directory dir = Directory('/storage/emulated/0/Download');

    final fileName = 'invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final newFile = File('${dir.path}/$fileName');

    final original = File(widget.path);
    await newFile.writeAsBytes(await original.readAsBytes());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tersimpan di Download: $fileName')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal simpan: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview PDF'),
        actions: [
          ///  SAVE BUTTON
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _savePdf,
          ),

          /// PRINT BUTTON
          IconButton(
            icon: isPrinting
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.print),
            onPressed: isPrinting ? null : _printPdf,
          ),
        ],
      ),
      body: PDFView(
        filePath: widget.path,
      ),
    );
  }
}