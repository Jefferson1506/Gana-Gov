import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/global/widgets/loanding.dart';
import 'package:ganagov/global/widgets/notify_dialog.dart';

class BreedProvider with ChangeNotifier {
  List<DocumentSnapshot> _breeds = [];

  List<DocumentSnapshot> get breeds => _breeds;

  BreedProvider() {
    fetchBreeds();
  }

  Future<void> fetchBreeds() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('Breeds').get();
      _breeds = snapshot.docs;
      notifyListeners();
    } catch (e) {
      print('Error fetching breeds: $e');
    }
  }

  Future<void> addBreed(BuildContext context, String name, String description) async {
    LoadingDialog.showLoadingDialog(context);
    
    if (name.isEmpty || description.isEmpty) {
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showWarningDialog(context, "Todos los campos son obligatorios.");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('Breeds').add({
        'name': name,
        'description': description,
      });
      
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showSuccessDialog(context);

      await fetchBreeds();
    } catch (error) {
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showErrorDialog(context, "Error al agregar la raza: ${error.toString()}");
    }
  }

  Future<void> editBreed(BuildContext context, String id, String name, String description) async {
    LoadingDialog.showLoadingDialog(context);

    if (name.isEmpty || description.isEmpty) {
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showWarningDialog(context, "Todos los campos son obligatorios.");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('Breeds').doc(id).update({
        'name': name,
        'description': description,
      });
      
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showSuccessDialog(context);

      await fetchBreeds();
    } catch (error) {
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showErrorDialog(context, "Error al editar la raza: ${error.toString()}");
    }
  }

  Future<void> deleteBreed(BuildContext context, String id) async {
    LoadingDialog.showLoadingDialog(context);

    try {
      await FirebaseFirestore.instance.collection('Breeds').doc(id).delete();
      
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showSuccessDialog(context);

      await fetchBreeds();
    } catch (error) {
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showErrorDialog(context, "Error al eliminar la raza: ${error.toString()}");
    }
  }
}
