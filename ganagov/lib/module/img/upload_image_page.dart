import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  String? _downloadURL;
  String? _fileName;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _fileName = path.basename(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;
    setState(() {
      _isUploading = true;
    });

    try {
      String fileName = path.basename(_image!.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('Perfil/$fileName');

      UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
      await uploadTask.whenComplete(() => null);

      String downloadURL = await firebaseStorageRef.getDownloadURL();

      setState(() {
        _downloadURL = downloadURL;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imagen subida con éxito!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al subir la imagen: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageHeight = screenWidth * 0.5;
    final double imageWidth = screenWidth * 0.5;

    return Scaffold(
      appBar: AppBar(title: const Text('Subir Imagen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: imageWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2), // Borde gris
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
              ),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Text(
                        'No has seleccionado ninguna imagen',
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Seleccionar Imagen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadImage,
              child: _isUploading
                  ? const CircularProgressIndicator()
                  : const Text('Subir Imagen'),
            ),
            const SizedBox(height: 20),
            if (_fileName != null) Text('Archivo seleccionado: $_fileName'),
            if (_downloadURL != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('URL de descarga: $_downloadURL'),
                    const SizedBox(height: 10),
                    Text('Ruta del archivo: uploads/$_fileName'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
