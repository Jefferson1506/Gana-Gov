import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ShowImagePage extends StatelessWidget {
  final String imageUrl;

  const ShowImagePage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AutoSizeText('Mostrar Imagen')),
      body: Center(
        child: imageUrl.isNotEmpty
            ? Image.network(imageUrl) 
            : const AutoSizeText('No hay imagen para mostrar'),
      ),
    );
  }
}
