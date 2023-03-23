import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_test_widget_integration_unit/controllers/album_controller.dart';
import 'package:flutter_test_widget_integration_unit/pages/register_album_page.dart';
import 'package:provider/provider.dart';

import '../data/models/album.dart';
import 'widgets/page_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: Provider.of<AlbumController>(context)..getAllAlbums(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              PageTitle(
                text: "Álbuns",
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(child: AlbumList()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key("floating-action-open"),
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const RegisterAlbumPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AlbumList extends StatefulWidget {
  const AlbumList({super.key});

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  late AlbumController albumController;

  @override
  void initState() {
    super.initState();
    albumController = Provider.of<AlbumController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final albums = albumController.albums;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
              itemCount: albums.length,
              separatorBuilder: (_, __) => const SizedBox(
                    height: 5,
                  ),
              itemBuilder: (_, index) {
                return AlbumItem(album: albums[index]);
              }),
        );
      },
    );
  }
}

class AlbumItem extends StatelessWidget {
  final Album album;
  const AlbumItem({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.teal.shade100,
            child: const Icon(
              Icons.music_note,
              size: 30,
              color: Colors.teal,
            ),
          ),
          title: Text(album.title),
        ),
      ),
    );
  }
}
