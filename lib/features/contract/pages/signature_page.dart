import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class SignaturePage extends StatefulWidget {
  final String pdfUrl;
  const SignaturePage({super.key, required this.pdfUrl});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
  );

  Future<void> _saveSignature() async {
    try {
      // 1️⃣ جلب ملف الـ PDF من الانترنت
      final response = await http.get(Uri.parse(widget.pdfUrl));
      final Uint8List pdfData = response.bodyBytes;

      // 2️⃣ تحويل التوقيع لصورة PNG
      final signatureBytes = await _controller.toPngBytes();
      if (signatureBytes == null) return;

      // 3️⃣ فتح الـ PDF
      final PdfDocument document = PdfDocument(inputBytes: pdfData);

      // 4️⃣ أخذ الصفحة الأولى وإضافة التوقيع
      final PdfPage page = document.pages[0];
      final PdfBitmap signatureImage = PdfBitmap(signatureBytes);

      // (x,y,width,height) لمكان التوقيع
      page.graphics.drawImage(
        signatureImage,
        const Rect.fromLTWH(100, 500, 150, 80),
      );

      // 5️⃣ حفظ الملف المعدل محلياً
      final List<int> updatedPdf = await document.save();
      document.dispose();

      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/signed_file.pdf");
      await file.writeAsBytes(updatedPdf, flush: true);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم حفظ PDF مع التوقيع هنا:\n${file.path}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("خطأ: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signature page")),
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: _controller,
              backgroundColor: Colors.grey[200]!,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _controller.clear(),
                child: const Text("clear"),
              ),
              ElevatedButton(
                onPressed: _saveSignature,
                child: const Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
