import 'package:flutter/material.dart';
import 'package:flutter_fachri/models/doa_model.dart';
import '../services/doa_service.dart';
import 'doa_detail.dart';

class ListDoaScreen extends StatefulWidget {
  const ListDoaScreen({super.key});

  @override
  State<ListDoaScreen> createState() => _ListDoaScreenState();
}

class _ListDoaScreenState extends State<ListDoaScreen> {
  late Future<List<DoaModel>> _futureDoa;

  @override
  void initState() {
    super.initState();
    _futureDoa = DoaService.fetchDoa();
  }

  Future<void> _refreshDoa() async {
    setState(() {
      _futureDoa = DoaService.fetchDoa();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Doa')),
      body: RefreshIndicator(
        onRefresh: _refreshDoa,
        child: FutureBuilder<List<DoaModel>>(
          future: _futureDoa,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada doa.'));
            } else {
              final doaList = snapshot.data!;
              return ListView.builder(
                itemCount: doaList.length,
                itemBuilder: (context, index) {
                  final doa = doaList[index];
                  return ListTile(
                    title: Text(doa.doa ?? ''),
                    subtitle: Text(doa.latin ?? ''),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoaDetailPage(doa: doa),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
