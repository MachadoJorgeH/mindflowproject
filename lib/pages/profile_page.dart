import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindflow/pages/dashboard_page.dart';
import 'package:mindflow/pages/edit_profile_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mindflow/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Directory> _getDirectory() async {
      return await getApplicationDocumentsDirectory();
    }

    // Simular dados do usuário (iremos substituir pelo Firebase depois)
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? 'Email não encontrado';
    final userName = FirebaseAuth.instance.currentUser?.displayName;
    // final userId = user?.uid ?? 'ID não encontrado';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const DashboardPage(),
              ), // Redireciona para a DashboardPage
            );
          },
        ),
        title: const Text('Meu Perfil'),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Gap(24),
              SvgPicture.asset('assets/images/mindflow_logo.svg', height: 120),
              const Gap(24),
              FutureBuilder<Directory>(
                future: _getDirectory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    final directory = snapshot.data!;
                    return CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xFF6C63FF),
                      backgroundImage: FileImage(
                        File('${directory.path}/profile_picture.jpg'),
                      ),
                      // child: const Icon(Icons.person, size: 50, color: Colors.white),
                    );
                  }
                  return const CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF6C63FF),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  );
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                ),
                onPressed: () async {
                  try {
                    final imagePicker = ImagePicker();
                    final pickedFile = await imagePicker.pickImage(
                      source: ImageSource.camera,
                    );

                    if (pickedFile != null) {
                      // Obter o diretório local para salvar a imagem
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final localPath = '${directory.path}/profile_picture.jpg';

                      // Salvar a imagem localmente
                      final file = File(pickedFile.path);
                      await file.copy(localPath);

                      print('Foto salva localmente em: $localPath');

                      // Atualizar a interface
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Foto de perfil atualizada com sucesso!',
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao atualizar foto de perfil: $e'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Alterar Foto de Perfil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Gap(16),
              Text(
                userName!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userEmail,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Gap(32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfilePage(),
                    ), // Navega para EditProfilePage
                  );
                },
                child: const Text(
                  'Editar Perfil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Gap(12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut(); // Realiza o logout
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ), // Redireciona para a tela de login
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Erro ao sair: $e')));
                  }
                },
                child: const Text(
                  'Sair',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
