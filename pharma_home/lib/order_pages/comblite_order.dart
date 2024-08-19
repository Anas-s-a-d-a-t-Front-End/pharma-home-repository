import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharma_home/const_value/constrain.dart';

class CombliteOrder extends StatefulWidget {
  const CombliteOrder({super.key});

  @override
  State<CombliteOrder> createState() => _CombliteOrderState();
}

class _CombliteOrderState extends State<CombliteOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الطلبات المنجزة'),
        centerTitle: true,
        backgroundColor: Kprimary_color,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('previousOrder').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('لا يوجد طلبات منجزة'));
          }

          var orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index].data() as Map<String, dynamic>;
              var items =
                  order['items'] != null ? order['items'] as List<dynamic> : [];

              return Card(
                color: Kprimary_color,
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'اسم الزبون: ${order['first_name']}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        'العنوان: ${order['location']}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        'الهاتف: ${order['phone']}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        'السعر الإجمالي: ${order['totalPrice']} الف ل.س',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Divider(color: Colors.white),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, itemIndex) {
                          var item = items[itemIndex] as Map<String, dynamic>;
                          return ListTile(
                            leading: item['image'] != null
                                ? Image.network(item['image'])
                                : Icon(Icons.image, color: Kwhite_color),
                            title: Text(
                              item['name'] ?? 'اسم غير متوفر',
                              style: TextStyle(
                                  color: Kwhite_color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            subtitle: Text(
                              'الكمية: ${item['count'] ?? 'غير متوفر'} علبة',
                              style: TextStyle(
                                  color: Kwhite_color,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  'السعر: ${item['price'] ?? 'غير متوفر'}',
                                  style: TextStyle(
                                      color: Kwhite_color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'افرادي',
                                  style: TextStyle(
                                      color: Kwhite_color,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
