import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/models/location.dart';
import '../utils/colors.dart';
import '../utils/providers.dart';
import '../widgets/city_block.dart';

class LocationsScreen extends StatefulWidget {

  const LocationsScreen({Key? key}): super(key: key);

  @override
  _LocationsScreenState createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Providers.getLocations,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text('Something went wrong');

        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Locations'),
              automaticallyImplyLeading: false,
              elevation: 5,
              backgroundColor: secondaryColor,
            ),

            body: const Center(child: CircularProgressIndicator()),

          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Locations'),
            automaticallyImplyLeading: false,
            elevation: 5,
            backgroundColor: secondaryColor,
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


