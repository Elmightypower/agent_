import 'package:agentshipr/controllers/colisController.dart';
import 'package:agentshipr/models/colis_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderDetails extends StatefulWidget {

  final Data colis;


  const OrderDetails({
    Key? key,
   required this.colis,
  }) : super(key: key);

  @override
  _PackageDetailsPageState createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<OrderDetails> {
  bool isTracking = false; // Example state variable for toggling live tracking
  final _formKey = GlobalKey<FormState>();

  String selectedValue = 'Soumis'; // Initial value
  final List<String> options = ['Soumis', 'Ramassés', 'Livrés'];
  late TextEditingController _idColisController;
  String _userId = '';

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the default value
    _idColisController = TextEditingController(
      text: widget.colis.colisPriseId ?? 'Nature Colis', // Set default value here
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is destroyed
    _idColisController.dispose();
    super.dispose();
  }

  Future<void> _updateStatut() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.put(
          Uri.parse('https://shipr.ggsdrc.com/index.php/api/post/update_statut'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'colis_prise_id': _idColisController.text,
            'statut_colis_verification': selectedValue,
          }),
        );

        // Log the response body for debugging
        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['status']) {

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Statut mis à jour avec succès')),
            );
            Navigator.pushReplacementNamed(context, '/orderPage', arguments: () {
              // Call the method to fetch data in ColisController

            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Erreur lors de la mise à jour')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erreur de serveur')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }


  void _showUpdateStatutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mettre à jour le statut'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures the dialog isn't too large
              children: [
                // TextFormField with default value
                TextFormField(
                  controller: _idColisController, // Use the controller here
                  decoration: const InputDecoration(
                    labelText: 'ID du colis',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le ID du colis';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // Handle the value entered in the TextField
                  },
                  enabled: false, // Disable the TextField
                ),
                const SizedBox(height: 10), // Add space between fields
                // DropdownButtonFormField remains the same
                DropdownButtonFormField<String>(
                  value: selectedValue.isEmpty ? null : selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue ?? '';
                    });
                  },
                  items: options
                      .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: 'Statut du colis',
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Veuillez sélectionner un statut'
                      : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _updateStatut();
                Navigator.pop(context);
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details Colis',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF6CB4A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Package Tracking Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Map Placeholder
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.map, size: 80, color: Colors.grey),
                      ),
                    ),
                    // Live Tracking Button (with toggle example)
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isTracking = !isTracking;
                          });
                        },
                        child: Text(
                          isTracking ? 'Stop Tracking' : 'Live Tracking',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Order Information Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Order Status: ${widget.colis.statutColisVerification ?? 'N/A'}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Tracking ID: ${widget.colis.colisNumber ?? 'N/A'}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Date: ${widget.colis.dateHeureDepart ?? 'N/A'}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                leading: const Icon(Icons.check_box, size: 40, color: Colors.orange),
                title: Text(widget.colis.natureColis ?? 'Nature Colis'),
                subtitle: Text(widget.colis.typageColis ?? 'Typage Colis'),
                trailing: Text(
                  '${widget.colis.montantColis ?? '0'} \$',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Divider(),
            // QR Code Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Scan QR Code for Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Image.network(
                      widget.colis.qrCodeColis ?? 'https://placehold.jp/150x150.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          // Image has finished loading, return the child (image)
                          return child;
                        } else {
                          // Image is still loading, show a circular progress indicator
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                    ),



                  ],
                ),
              ),
            ),
            const Divider(),
            // Delivery Status Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Delivery Status',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const DeliveryStatusItem(
              status: 'Picked',
              location: 'Jakarta, IDN',
              time: '10:40 PM, 12 Dec, 2024',
              isCompleted: true,
            ),
            const DeliveryStatusItem(
              status: 'Sorted',
              location: 'Jakarta, IDN',
              time: '12:50 PM, 16 Dec, 2024',
              isCompleted: true,
            ),
            const DeliveryStatusItem(
              status: 'Out for Delivery',
              location: 'Jakarta, IDN',
              time: 'Pending',
              isCompleted: false,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showUpdateStatutDialog(); // Call the dialog function
        },
        label: const Text('Mettre à jour',style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        )),
        icon: const Icon(Icons.update),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

class DeliveryStatusItem extends StatelessWidget {
  final String status;
  final String location;
  final String time;
  final bool isCompleted;

  const DeliveryStatusItem({
    Key? key,
    required this.status,
    required this.location,
    required this.time,
    required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Indicator
          Column(
            children: [
              Icon(
                Icons.check_circle,
                color: isCompleted ? Colors.green : Colors.grey,
              ),
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? Colors.green : Colors.grey[300],
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Status Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: isCompleted ? Colors.black : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
