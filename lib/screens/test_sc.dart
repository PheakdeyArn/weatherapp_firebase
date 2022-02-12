import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/models/location.dart';
// import 'package:ros_socheath/detail.dart';

import '../widgets/city_block.dart';

class prasat extends StatefulWidget {

  @override
  _prasatState createState() => _prasatState();
}

class _prasatState extends State<prasat> {

  // Get data from Firebase collection
  final Future<QuerySnapshot> prasat = FirebaseFirestore.instance.collection('location').get();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: prasat,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("");
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Locations'),
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

              Location temp = Location(
                  city: data['city'],
                  country: data['country'],
                  lat: data['lat'],
                  lon: data['lon']
              );

              return LocationBlock(location: temp);
            }).toList(),
          ),
        );
      },
    );
  }
}


