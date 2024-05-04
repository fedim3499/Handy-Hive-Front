import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:intl/intl.dart'; // Import the intl package
import 'package:flutter/foundation.dart';
import 'dart:typed_data';


class ClientWorkRequestPage extends StatefulWidget {
  @override
  _ClientWorkRequestPageState createState() => _ClientWorkRequestPageState();
}

class _ClientWorkRequestPageState extends State<ClientWorkRequestPage> {
    String? imageData; // Variable to store base64-encoded image data
    String? fileName; // Variable to store base64-encoded image data
    String? UrlApi="http://localhost:5032/api/workrequests";
    String? date; // Variable to store base64-encoded image data
    XFile? aa; // Variable to store base64-encoded image data

  final picker = ImagePicker();
  late String _description;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  File? _selectedImage;
  String?selected;
 // late latlong.LatLng _selectedLocation;
 // bool _locationSelected = false;

  @override
  void initState() {
    super.initState();
    _description = '';
   // _selectedLocation = latlong.LatLng(0, 0); // Default location
   // _getCurrentLocation();
  }

  /*Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _selectedLocation = latlong.LatLng(position.latitude, position.longitude);
    });
  }*/

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
    date= DateFormat('yyyy-MM-dd').format(pickedDate);
    print(date);

      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _submitWorkRequest() async {

  // Ensure all required fields are filled
  if (date== null || _selectedTime == null || _description.isEmpty) {
    print('Please fill all required fields.');
    return;
  }
  // Create JSON object
  Map<String, dynamic> jsonObject = {
    'date': date,
    'time': _selectedTime!.format(context),
    'photo': fileName,
    'description': _description,
  };

  // Convert the map to a JSON string
  String jsonString = json.encode(jsonObject);

  // Print the JSON string to the console
  print('JSON Data: $jsonString');

 

  try {
    // Make POST request
    http.Response response = await http.post(
      Uri.parse(UrlApi!),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonString,
    );

    // Check the response status
    if (response.statusCode == 200) {
      uploadImage();
      print('Request successful: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }

  }

 Future<void> uploadImage() async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:5032/api/UploadImages/upload'),
    );

    // Check if the platform is web or mobile
    if (kIsWeb) {
      // If it's web, encode the image as base64 and add it to the request body
      var bytes = await _selectedImage!.readAsBytes();
      var imageData = base64Encode(bytes);
      request.fields['ImageFile'] = imageData;
    } else {
      // If it's mobile, attach the image file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'ImageFile',
          selected!,// !!!!!!!!!!!!!!!!!
        ),
      );
    }

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var response = await streamedResponse.stream.bytesToString();
      var parsedResponse = json.decode(response);
      print(parsedResponse);
    } else {
      print('Failed to upload image. Error: ${streamedResponse.reasonPhrase}');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Work Request'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description *',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select Date${_selectedDate != null ? ": ${_selectedDate!.toString().split(' ')[0]}" : ""}'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Select Time${_selectedTime != null ? ": ${_selectedTime!.format(context)}" : ""}'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _selectedImage = File(pickedFile.path);
                  imageData = path.basenameWithoutExtension(_selectedImage!.path);
                     fileName = pickedFile.name; // Get the file name from pickedFile
selected=pickedFile.path;
                        print('Selected file name: $fileName');

                    });
                  }
                },
                child: Text('Select Image (Optional)'),
              ),
              SizedBox(height: 16.0),
             /* ElevatedButton(
                onPressed: () async {
                  // Navigate to map page to select location
                  final selectedLocation = await Navigator.push(context, MaterialPageRoute(builder: (context) => MapSelectionPage()));
                  if (selectedLocation != null && selectedLocation is latlong.LatLng) {
                    setState(() {
                      _selectedLocation = selectedLocation;
                      _locationSelected = true;
                    });
                  }
                },
                child: Text('Select Location *'),
              ),*/
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _submitWorkRequest(),
                child: Text('Submit Work Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class MapSelectionPage extends StatefulWidget {
  @override
  _MapSelectionPageState createState() => _MapSelectionPageState();
}

class _MapSelectionPageState extends State<MapSelectionPage> {
  late latlong.LatLng _selectedLocation;
  
  get layers => null;

  @override
  void initState() {
    super.initState();
    _selectedLocation = latlong.LatLng(0, 0); // Default location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: latlong.LatLng(0, 0), // Set center to some default location
          zoom: 13.0,
        ),
        children: [
        layers: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _selectedLocation,
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
              ),
            ],
        
          ),
        ],
        
        onTap: (latlong.LatLng latLng) {
          setState(() {
            _selectedLocation = latLng;
          });
        },
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _selectedLocation);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}*/
















