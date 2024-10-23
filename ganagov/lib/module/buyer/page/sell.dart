// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ganagov/global/user_model.dart';
import 'package:ganagov/global/widgets/loanding.dart';
import 'package:ganagov/global/widgets/notify_dialog.dart';
import 'package:ganagov/global/widgets/text_form.dart';
import 'package:ganagov/global/widgets/text_span.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegistroGanadoPage extends StatefulWidget {
  @override
  _RegistroGanadoPageState createState() => _RegistroGanadoPageState();
}

class _RegistroGanadoPageState extends State<RegistroGanadoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  String _tipoVentaSeleccionado = '';
  String _categoriaSeleccionada = '';
  String _razaSeleccionada = '';
  String _departamentoSeleccionado = '';
  bool _negociable = false;
  List<File> _images = [];
  File? _video;
  final ImagePicker _picker = ImagePicker();
  List<String> _razas = [];
  final List<String> _categorias = ['Lechero', 'De Carne', 'Doble Propósito'];
  final List<String> _tiposVenta = ['Animal', 'Lote'];
  final List<String> _departamentos = [
    'Amazonas',
    'Antioquia',
    'Arauca',
    'Atlántico',
    'Bolívar',
    'Boyacá',
    'Caldas',
    'Caquetá',
    'Casanare',
    'Cauca',
    'Cesar',
    'Chocó',
    'Córdoba',
    'Cundinamarca',
    'Guainía',
    'Guaviare',
    'Huila',
    'La Guajira',
    'Magdalena',
    'Meta',
    'Nariño',
    'Norte de Santander',
    'Putumayo',
    'Quindío',
    'Risaralda',
    'San Andrés y Providencia',
    'Santander',
    'Sucre',
    'Tolima',
    'Valle del Cauca',
    'Vaupés',
    'Vichada',
  ];

  @override
  void initState() {
    super.initState();
    _fetchRazas();
  }

  Future<void> _fetchRazas() async {
    try {
      QuerySnapshot breedsSnapshot =
          await FirebaseFirestore.instance.collection('Breeds').get();
      setState(() {
        _razas =
            breedsSnapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    } catch (e) {
      NotifyDialog.showErrorDialog(context, "Error al cargar las razas: $e");
    }
  }

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      if (pickedFiles != null) {
        _images =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      }
    });
  }

  Future<void> _pickVideo() async {
    final pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      if (pickedVideo != null) {
        _video = File(pickedVideo.path);
      }
    });
  }

  Future _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_images.isEmpty && _video == null) {
        NotifyDialog.showWarningDialog(
            context, "Por favor selecciona al menos una imagen o un video.");
        return;
      }

      LoadingDialog.showLoadingDialog(context);

      try {
        final _userBox = Hive.box<UserModel>('users');

        final _userModel = _userBox.getAt(0);

        if (_userModel!.idNumber == null) {
          NotifyDialog.showErrorDialog(
              context, "Error: no se encontró el ID del usuario en Hive.");
          return;
        }

        final imageUrls = await _uploadImages();
        final videoUrl = await _uploadVideo();
        final dataTime = DateTime.now().toString();
        await FirebaseFirestore.instance.collection('Ganado').add({
          'idNumber': _userModel.idNumber,
          'telefono': _userModel.telefono,
          'tipoVenta': _tipoVentaSeleccionado,
          'categoria': _categoriaSeleccionada,
          'raza': _razaSeleccionada,
          'peso': _pesoController.text,
          'departamento': _departamentoSeleccionado,
          'edad': _edadController.text,
          'precio': _precioController.text,
          'negociable': _negociable,
          'cantidad': _cantidadController.text,
          'descripcion': _descripcionController.text,
          'fotos': imageUrls,
          'video': videoUrl,
          'estado': 'VENTA',
          'fecha': dataTime
        });
        LoadingDialog.dismissLoadingDialog(context);
        NotifyDialog.showSuccessDialog(context);
        _limpiarFormulario();
      } catch (e) {
        LoadingDialog.dismissLoadingDialog(context);
        NotifyDialog.showErrorDialog(context, "Error al registrar: $e");
      }
    }
  }

  void _limpiarFormulario() {
    _pesoController.clear();
    _edadController.clear();
    _precioController.clear();
    _cantidadController.clear();
    _descripcionController.clear();

    setState(() {
      _tipoVentaSeleccionado = '';
      _categoriaSeleccionada = '';
      _razaSeleccionada = '';
      _departamentoSeleccionado = '';
      _negociable = false;
      _images.clear(); // Limpiar la lista de imágenes
      _video = null; // Limpiar el video seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        centerTitle: true,
        title: CustomTextSpan(
          primary: const Color.fromARGB(255, 54, 54, 54),
          secondary: colorScheme.primary,
          textPrimary: "Registro de Ganado     Gana",
          textSecondary: "Gov",
          sizePrimary: 23,
          sizeSecondary: 23,
        ),
        shape: const UnderlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 17, 163, 3), width: 5),
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                DropdownButtonFormField<String>(
                  value: _tipoVentaSeleccionado.isNotEmpty
                      ? _tipoVentaSeleccionado
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Tipo de Venta',
                    border: OutlineInputBorder(),
                  ),
                  items: _tiposVenta.map((String tipo) {
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _tipoVentaSeleccionado = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'El tipo de venta es obligatorio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                DropdownButtonFormField<String>(
                  value: _categoriaSeleccionada.isNotEmpty
                      ? _categoriaSeleccionada
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(),
                  ),
                  items: _categorias.map((String categoria) {
                    return DropdownMenuItem<String>(
                      value: categoria,
                      child: Text(categoria),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _categoriaSeleccionada = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'La categoría es obligatoria';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                DropdownButtonFormField<String>(
                  value:
                      _razaSeleccionada.isNotEmpty ? _razaSeleccionada : null,
                  decoration: const InputDecoration(
                    labelText: 'Raza',
                    border: OutlineInputBorder(),
                  ),
                  items: _razas.map((raza) {
                    return DropdownMenuItem(
                      value: raza,
                      child: Text(raza),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _razaSeleccionada = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione una raza';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                DropdownButtonFormField<String>(
                  value: _departamentoSeleccionado.isNotEmpty
                      ? _departamentoSeleccionado
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Departamento',
                    border: OutlineInputBorder(),
                  ),
                  items: _departamentos.map((departamento) {
                    return DropdownMenuItem(
                      value: departamento,
                      child: Text(departamento),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _departamentoSeleccionado = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione un departamento';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                CustomTextForm(
                  controller: _pesoController,
                  hintText: "Peso promedio (kg)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese el peso promedio";
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                CustomTextForm(
                  controller: _cantidadController,
                  hintText: "Cantidad",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese la cantidad";
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                CustomTextForm(
                  controller: _edadController,
                  hintText: "Edad promedio (meses)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese la edad promedio";
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                CustomTextForm(
                  controller: _precioController,
                  hintText: "Precio promedio por cabeza (COP)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese el precio promedio";
                    }
                    return null;
                  },
                ),
                CheckboxListTile(
                  title: const Text('¿Negociable?'),
                  value: _negociable,
                  onChanged: (bool? value) {
                    setState(() {
                      _negociable = value ?? false;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                CustomTextForm(
                  controller: _descripcionController,
                  hintText: "Descripción",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese una descripción";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextButton.icon(
                  onPressed: _pickImages,
                  icon: const Icon(Icons.image),
                  label: const Text('Seleccionar imágenes'),
                ),
                _images.isNotEmpty
                    ? Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _images
                            .map((image) => Image.file(
                                  image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ))
                            .toList(),
                      )
                    : const Text('No se han seleccionado imágenes'),
                const SizedBox(height: 16.0),
                TextButton.icon(
                  onPressed: _pickVideo,
                  icon: const Icon(Icons.video_collection),
                  label: const Text('Seleccionar video'),
                ),
                _video != null
                    ? Text(
                        'Video seleccionado: ${_video!.path.split('/').last}')
                    : const Text('No se ha seleccionado un video'),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 249, 188, 99),
                  ),
                  onPressed: () async {
                    _submitForm(context);
                  },
                  child: const Text(
                    'Registrar Ganado',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<List<String>> _uploadImages() async {
    final List<String> imageUrls = [];
    for (var image in _images) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('ganado_images/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }

  Future<String?> _uploadVideo() async {
    if (_video != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('ganado_videos/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putFile(_video!);
      final snapshot = await uploadTask.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    }
    return null;
  }
}
