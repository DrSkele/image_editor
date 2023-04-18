import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor/selected_image.dart';
import 'package:provider/provider.dart';

class EditView extends StatefulWidget {
  const EditView({super.key});

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: 300,
        child: Stack(
          fit: StackFit.expand,
          children: [
            InteractiveViewer(
              constrained: false,
              child: Image.file(
                File(context.watch<SelectedImage>().file.path),
                colorBlendMode: BlendMode.dstOut,
              ),
            ),
            IgnorePointer(
              child: CustomPaint(
                painter: CameraPainter(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CameraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.black.withAlpha(160);

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.height / 2;

    final Path path = Path();
    path.fillType = PathFillType.evenOdd;
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
