import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListRepository extends StatelessWidget {
  const ListRepository({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference gasStations =
        FirebaseFirestore.instance.collection('gas_stations');

    return FutureBuilder<QuerySnapshot>(
      future: gasStations.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
          return Text("Name: ${data['name']}");
        }

        return const Text("loading");
      },
    );
  }
}
