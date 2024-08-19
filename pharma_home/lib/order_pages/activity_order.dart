import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_home/const_value/constrain.dart';
import 'package:pharma_home/order_pages/confirm_order.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Future<void> acceptOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('activityOrder')
          .doc(orderId)
          .update({'status': 'accepted'});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم قبول الطلب بنجاح')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم رفض الطلب: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الطلب'),
        centerTitle: true,
        backgroundColor: Kprimary_color,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('activityOrder').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No active orders found.'));
          }

          var orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index].data() as Map<String, dynamic>;
              var items = order['items'] as List<dynamic>;

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
                            leading: Image.network(item['image']),
                            title: Text(
                              item['name'],
                              style: TextStyle(
                                  color: Kwhite_color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            subtitle: Text(
                              'الكمية: ${item['count']} علبة',
                              style: TextStyle(
                                  color: Kwhite_color,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  'السعر: ${item['price']}',
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
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            acceptOrder(orders[index].id);
                            Get.to(
                              () => ConfirmOrder(orderId: orders[index].id),
                              transition: Transition.fade,
                              duration: Duration(seconds: 1),
                            );
                          },
                          child: Text('قبول الطلب'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Kwhite_color,
                            foregroundColor: Kprimary_color,
                          ),
                        ),
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
