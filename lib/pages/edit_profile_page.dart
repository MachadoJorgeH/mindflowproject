import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _ageController = TextEditingController();
  File? _image;
  String? _photoUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    int retryCount = 0;
    while (retryCount < 3) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .get();

        final data = doc.data();
        if (data != null) {
          _nameController.text = data['name'] ?? '';
          _bioController.text = data['bio'] ?? '';
          _ageController.text = data['age']?.toString() ?? '';
          _photoUrl = data['photoUrl'];
          setState(() {});
        }
        return; // Sai do loop se a operação for bem-sucedida
      } catch (e) {
        retryCount++;
        await Future.delayed(
          Duration(seconds: retryCount * 2),
        ); // Backoff exponencial
        if (retryCount == 3) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Erro ao carregar dados: $e')));
        }
      }
    }
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<void> saveProfile() async {
    setState(() => isLoading = true);
    try {
      String? imageUrl = _photoUrl;

      if (_image != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${user!.uid}.jpg');
        await ref.putFile(_image!);
        imageUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'uid': user?.uid,
        'name': _nameController.text,
        'bio': _bioController.text,
        'age': int.tryParse(_ageController.text) ?? 0,
        'email': user?.email,
        'photoUrl': imageUrl ?? '',
        'updatedAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Perfil atualizado!')));
    } catch (e) {
      print(e);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = _image != null
        ? Image.file(_image!, fit: BoxFit.cover)
        : _photoUrl != null && _photoUrl!.isNotEmpty
        ? Image.network(_photoUrl!, fit: BoxFit.cover)
        : const Icon(Icons.person, size: 80, color: Colors.white);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: const Color(0xFF6C63FF),
                          child: ClipOval(
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: imageWidget,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onPressed: pickImage,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                        labelText: 'Bio',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Idade',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: saveProfile,
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
