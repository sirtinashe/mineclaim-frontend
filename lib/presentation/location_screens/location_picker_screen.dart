import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../add_new_mine_screen/add_new_mine_screen.dart';






class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? mapController;
  LatLng? selectedLocation;
  String? selectedAddress;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<String?> getAddressFromLatLng(LatLng location) async {
    final apiKey = 'AIzaSyClo4POuqvYz7ErhH6sir0a98131qT53Vs';
    final endpoint =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.latitude},${location.longitude}&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(endpoint));
      print("================ Response ===================================");
      print(response.body);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final results = decoded['results'] as List<dynamic>;
        if (results.isNotEmpty) {
          return results.first['formatted_address'];
        }
      }
    } catch (e) {
      print('Error while geocoding: $e');
    }

    return null;
  }

  void _onMapTapped(LatLng location) async {
    setState(() {
      selectedLocation = location;
      selectedAddress = " please wait...";
    });

    try {
      final address = await getAddressFromLatLng(location);
      if (address != null) {
        setState(() {
          selectedAddress = address;
        });
      }
    } catch (e) {
      print('Error while retrieving address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search for a mine location',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12),
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                // TODO: Clear the search text field
              },
            ),
          ),
          onChanged: (value) {
            // TODO: Handle search text changes
          },
          onSubmitted: (value) {
            // TODO: Perform search based on the submitted value
          },
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            onTap: _onMapTapped,
            initialCameraPosition: CameraPosition(
              target: LatLng(-20.112960, 28.604691), // Initial map position (Harare) #
              zoom: 12,
            ),
            markers: Set<Marker>.from([
              if (selectedLocation != null)
                Marker(
                  markerId: MarkerId('selectedLocation'),
                  position: selectedLocation!,
                ),
            ]),
          ),
          if (selectedLocation != null)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latitude: ${selectedLocation!.latitude}\nLongitude: ${selectedLocation!.longitude}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (selectedAddress != null)
                      SizedBox(height: 8),
                    Text(
                      'Address: $selectedAddress',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          onPressed: () {
            // Respond to button press
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: AddNewMineScreen(),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          icon: Icon(Icons.add),
          label: Text(
            'Continue',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16
            ),
          ),
        )
    );
  }
}