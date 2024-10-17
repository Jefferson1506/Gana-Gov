import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/global/widgets/notify_dialog.dart';
import 'package:ganagov/module/admin/provider/breed_provider.dart';
import 'package:provider/provider.dart';

class BreedCrudPage extends StatelessWidget {
  const BreedCrudPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => BreedProvider(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 48, 39),
        body: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            children: [
              Expanded(child: BreedList(size: size)),
              SizedBox(height: size.height * 0.03),
              CrudActions(size: size),
            ],
          ),
        ),
      ),
    );
  }
}

class CrudActions extends StatelessWidget {
  final Size size;
  const CrudActions({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          onPressed: () {
            CrudDialogs.showAddBreedDialog(context, size);
          },
          child: const AutoSizeText(
            'Agregar Raza',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class CrudDialogs {
  static void showAddBreedDialog(BuildContext context, Size size) {
    final TextEditingController breedController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final breedProvider = Provider.of<BreedProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Nueva Raza'),
          content: BreedForm(
            breedController: breedController,
            descriptionController: descriptionController,
            size: size,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (breedController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  try {
                    await breedProvider
                        .addBreed(
                      context,
                      breedController.text,
                      descriptionController.text,
                    )
                        .then((value) {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    });
                  } catch (error) {
                    NotifyDialog.showErrorDialog(
                        context, "Error al agregar la raza.");
                  }
                } else {
                  NotifyDialog.showWarningDialog(
                      context, "Todos los campos son obligatorios.");
                }
              },
              child: const Text(
                'Agregar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showEditBreedDialog(
      BuildContext context, Size size, DocumentSnapshot breed) {
    final TextEditingController breedController =
        TextEditingController(text: breed['name']);
    final TextEditingController descriptionController =
        TextEditingController(text: breed['description']);
    final breedProvider = Provider.of<BreedProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Raza'),
          content: BreedForm(
            breedController: breedController,
            descriptionController: descriptionController,
            size: size,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (breedController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  try {
                    await breedProvider.editBreed(
                      context,
                      breed.id,
                      breedController.text,
                      descriptionController.text,
                    );
                    Navigator.of(context).pop();
                  } catch (error) {
                    NotifyDialog.showErrorDialog(
                        context, "Error al editar la raza.");
                  }
                } else {
                  NotifyDialog.showWarningDialog(
                      context, "Todos los campos son obligatorios.");
                }
              },
              child: const Text('Guardar Cambios',
                  style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  static void showDeleteBreedDialog(
      BuildContext context, DocumentSnapshot breed) {
    final breedProvider = Provider.of<BreedProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Raza'),
          content: Text(
              '¿Está seguro que desea eliminar la raza "${breed['name']}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await breedProvider
                      .deleteBreed(context, breed.id)
                      .then((value) {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  });
                } catch (error) {
                  NotifyDialog.showErrorDialog(
                      context, "Error al eliminar la raza.");
                }
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BreedForm extends StatelessWidget {
  final TextEditingController breedController;
  final TextEditingController descriptionController;
  final Size size;

  const BreedForm({
    super.key,
    required this.breedController,
    required this.descriptionController,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: breedController,
          decoration: InputDecoration(
            labelText: 'Nombre de la Raza',
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          ),
          style: const TextStyle(color: Colors.black),
          validator: (value) =>
              value!.isEmpty ? 'Este campo es obligatorio' : null,
        ),
        SizedBox(height: size.height * 0.02),
        TextFormField(
          controller: descriptionController,
          decoration: InputDecoration(
            labelText: 'Descripción',
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          ),
          style: const TextStyle(color: Colors.black),
          validator: (value) =>
              value!.isEmpty ? 'Este campo es obligatorio' : null,
        ),
      ],
    );
  }
}

class BreedList extends StatelessWidget {
  final Size size;
  const BreedList({required this.size});

  @override
  Widget build(BuildContext context) {
    return Consumer<BreedProvider>(
      builder: (context, breedProvider, child) {
        if (breedProvider.breeds.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: breedProvider.breeds.length,
          itemBuilder: (context, index) {
            final breed = breedProvider.breeds[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.white,
                textColor: Colors.black,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(
                        color: Color.fromARGB(255, 249, 188, 99), width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text(breed['name']),
                subtitle: Text(breed['description']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        CrudDialogs.showEditBreedDialog(context, size, breed);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        CrudDialogs.showDeleteBreedDialog(context, breed);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
