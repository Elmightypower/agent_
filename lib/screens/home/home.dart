import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Shipr Agent',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.language, color: Colors.blue),
            label: const Text(
              'Français',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ratings Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange),
                  SizedBox(width: 4),
                  Text(
                    '4.8  2000+ Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Delivery Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryCard(
                    title: 'Local',
                    imagePath: 'assets/local.png',
                  ),
                  CategoryCard(
                    title: 'Packers & Movers',
                    imagePath: 'assets/packers.png',
                  ),
                  CategoryCard(
                    title: 'All India Parcel',
                    imagePath: 'assets/parcel.png',
                    isNew: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Promotional Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF6CB4A), // Hex color #f6cb4a,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Homecooked Meals\nStraight to Your Door',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Delicious, healthy, & loved meals from home!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: null,
                      child: Text(
                        'Book Local',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Recent Deliveries Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Opération en cours',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            DeliveryCard(
              time: '10/01/23, 3:40 PM',
              price: '138 \$',
              pickup: 'Depart de Paris',
              dropoff:
              'Destination Kinshasa, le contact expeditaire: 0816371059',
              deliveredBy: 'Solange Rudas',
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isNew;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.imagePath,
    this.isNew = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  height: 50,
                ),
              ),
            ),
            if (isNew)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class DeliveryCard extends StatelessWidget {
  final String time;
  final String price;
  final String pickup;
  final String dropoff;
  final String deliveredBy;

  const DeliveryCard({
    Key? key,
    required this.time,
    required this.price,
    required this.pickup,
    required this.dropoff,
    required this.deliveredBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline with dots and lines
                Column(
                  children: [
                    // First step dot
                    _buildDot(Colors.green),
                    _buildLine(),
                    // Second step dot
                    _buildDot(Colors.red),
                  ],
                ),
                const SizedBox(width: 8),
                // Timeline Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pickup Location
                      Text(
                        pickup,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      // Dropoff Location
                      Text(
                        dropoff,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivered by $deliveredBy',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  price,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build Dot for Timeline
  Widget _buildDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  // Build Vertical Line for Timeline
  Widget _buildLine() {
    return Container(
      width: 2,
      height: 40,
      color: Colors.grey[300],
    );
  }
}



