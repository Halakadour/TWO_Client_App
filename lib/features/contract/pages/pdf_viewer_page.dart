import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:two_client_app/config/constants/baseuri.dart';

import 'signature_page.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerPage({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View PDF"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_document),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SignaturePage(pdfUrl: "$pdfUri$pdfUrl"),
                ),
              );
            },
          ),
        ],
      ),
      body: SfPdfViewer.network("$pdfUri$pdfUrl"),
    );
  }
}
