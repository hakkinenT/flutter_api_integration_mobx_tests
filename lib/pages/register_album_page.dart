import 'package:flutter/material.dart';
import 'package:flutter_test_widget_integration_unit/controllers/album_controller.dart';
import 'package:flutter_test_widget_integration_unit/core/utils/validations_mixin.dart';
import 'package:flutter_test_widget_integration_unit/data/models/album.dart';
import 'package:provider/provider.dart';

import 'widgets/page_title.dart';

class RegisterAlbumPage extends StatefulWidget {
  const RegisterAlbumPage({super.key});

  @override
  State<RegisterAlbumPage> createState() => _RegisterAlbumPageState();
}

class _RegisterAlbumPageState extends State<RegisterAlbumPage>
    with ValidationsMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SafeArea(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButton(),
                  const SizedBox(
                    height: 24,
                  ),
                  const PageTitle(text: "Cadastrar Álbum"),
                  const SizedBox(
                    height: 48,
                  ),
                  TitleInput(
                    controller: titleController,
                    validator: (value) => combine(
                        [() => isNotEmpty(value), () => isValid(value)]),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  RegisterButton(
                    onPressed: () {
                      _sendAlbum(context);
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }

  void _sendAlbum(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Album album = Album(title: titleController.text);
      Provider.of<AlbumController>(context, listen: false).createAlbum(album);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Album cadastrado com sucesso!")));
      Navigator.pop(context);
    }
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
          )),
    );
  }
}

class TitleInput extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const TitleInput({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal.shade200),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          hintText: "Digite um título",
          hintStyle: const TextStyle(color: Colors.black45),
          labelText: "Título",
          labelStyle: const TextStyle(color: Colors.teal),
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 52,
        width: double.maxFinite,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: onPressed,
            child: const Text("Cadastrar")),
      ),
    );
  }
}
