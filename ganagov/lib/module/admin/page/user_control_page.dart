import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/module/admin/provider/user_provider.dart';
import 'package:provider/provider.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 48, 39),
      body: ChangeNotifierProvider(
        create: (_) => UserProvider(),
        child: const UserListWithFilter(),
      ),
    );
  }
}

class UserListWithFilter extends StatelessWidget {
  const UserListWithFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);

    return FutureBuilder(
      future: provider.fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.filteredUsers.isEmpty) {
          return const Center(child: Text('No hay usuarios disponibles'));
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Buscar por nombre',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  provider.filterUsers(value);
                },
              ),
            ),
            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, provider, _) {
                  return ListView.builder(
                    itemCount: provider.filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = provider.filteredUsers[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: user['Estado'] =='SI'?Colors.green:Colors.grey,
                          textColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromARGB(255, 249, 188, 99),
                                  width: 2.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          title: AutoSizeText(
                            'Nombre :${user['nombre'] ?? '---'}  Usuario :${user['User']}',
                            maxFontSize: 15,
                          ),
                          subtitle: AutoSizeText(
                            'Correo:${user['correo']} - Estado:${user['Estado']} - Rol:${user['rol']}  ',
                            maxFontSize: 15,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              provider.deleteUser(user['id']);
                            },
                          ),
                          onTap: () =>
                              _showUpdateDialog(context, provider, user),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

void _showUpdateDialog(
    BuildContext context, UserProvider provider, Map<String, dynamic> user) {
  final TextEditingController statusController =
      TextEditingController(text: user['estado']);
  bool isUpdating = false;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Actualizar estado'),
            content: TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'Nuevo estado'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              isUpdating
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: statusController.text.isEmpty ||
                              statusController.text == user['estado']
                          ? null
                          : () async {
                              setState(() => isUpdating = true);
                              await provider.updateUserStatus(
                                  user['id'], statusController.text);
                              setState(() => isUpdating = false);
                              Navigator.of(context).pop();
                            },
                      child: const Text('Actualizar'),
                    ),
            ],
          );
        },
      );
    },
  );
}
