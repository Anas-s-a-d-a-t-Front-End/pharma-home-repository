import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharma_home/const_value/constrain.dart';
import 'package:pharma_home/logic_operations/cart_provider.dart';
import 'package:provider/provider.dart';

class MedicineDetailPage extends StatefulWidget {
  final String medicineId;

  MedicineDetailPage({required this.medicineId});

  @override
  State<MedicineDetailPage> createState() => _MedicineDetailPageState();
}

class _MedicineDetailPageState extends State<MedicineDetailPage> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'حول المنتج',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('allProducts')
            .doc(widget.medicineId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var medicine = snapshot.data!.data() as Map<String, dynamic>;

          return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ListView(
              children: [
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Color(0Xff66BC89),
                      borderRadius: BorderRadius.circular(30)),
                  child: medicine['item_image'] != null
                      ? Image.network(
                          medicine['item_image'],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported,
                              size: 100,
                              color: Colors.grey,
                            );
                          },
                        )
                      : Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: Colors.grey,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    medicine['name'] ?? 'غير متوفر',
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 30,
                        color: Kprimary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${medicine['Medication_titer'] ?? 'غير متوفر'} ملغ',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${medicine['price'] ?? 'غير متوفر'} ل.س',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        '${medicine['old_price'] ?? 'غير متوفر'} ل.س',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 20,
                          color: Kprimary_color,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(5),
                  width: 100,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0Xff66BC89),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    medicine['description'] ?? 'لا يوجد وصف',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
