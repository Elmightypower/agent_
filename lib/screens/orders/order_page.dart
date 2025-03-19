import 'package:agentshipr/models/colis_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/colisController.dart';


import 'order_details.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ColisController colisController = Get.put(ColisController());  // Initialize the controller


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // Schedule a callback after the current frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      colisController.fetchColisData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Call the fetchColisData method whenever this page is revisited
    colisController.fetchColisData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6CB4A), // Yellow Header
        elevation: 0,
        title: const Text(
          'Listing des Colis',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.purple,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Tout'),
            Tab(text: 'Soumis'),
            Tab(text: 'Ramassés'),
            Tab(text: 'Livrés'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const OrderList(), // Display all orders
          const OrderList(status: 'Soumis'),
          const OrderList(status: 'Ramassés'),
          const OrderList(status: 'Livrés'),
        ],
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final String? status;

  const OrderList({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ColisController colisController = Get.put(ColisController());

    return Obx(() {
      if (colisController.isLoading.value) {
        // Show loading indicator while data is being fetched
        return const Center(child: CircularProgressIndicator());
      }

      // Filter orders based on status if provided
      final filteredOrders = status == null
          ? colisController.colisList
          : colisController.colisList
          .where((colis) => colis.statutColisVerification == status)
          .toList();

      if (filteredOrders.isEmpty) {
        return const Center(
          child: Text(
            'Aucune commande trouvée',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          final order = filteredOrders[index];
          return OrderCard(
            colis: order, // Pass the full Colis object
            status: order.statutColisVerification ?? 'N/A',
            price: '${order.montantColis ?? '0'} \$',
            tracking: order.colisNumber ?? 'N/A',
            date: order.dateHeureDepart ?? 'N/A',
            color: _getColorForStatus(order.statutColisVerification),
          );
        },
      );
    });
  }

  String _getColorForStatus(String? status) {
    switch (status) {
      case 'Soumis':
        return 'orange';
      case 'Ramassés':
        return 'blue';
      case 'Livrés':
        return 'green';
      default:
        return 'grey';
    }
  }
}

class OrderCard extends StatelessWidget {
  final Data colis;
  final String status;
  final String price;
  final String tracking;
  final String date;
  final String color;

  const OrderCard({
    Key? key,
    required this.colis,
    required this.status,
    required this.price,
    required this.tracking,
    required this.date,
    required this.color,
  }) : super(key: key);

  Color getStatusColor() {
    switch (color) {
      case 'green':
        return Colors.green.shade100;
      case 'blue':
        return Colors.blue.shade100;
      case 'orange':
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade300;
    }
  }

  Color getTextColor() {
    switch (color) {
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetails(colis: colis),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: getTextColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tracking: $tracking',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/parcel.png',
                height: 72,
                width: 72,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

