import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_home/const_value/constrain.dart';
import 'package:pharma_home/store_pages/repositry.dart';

class ConfirmOrder extends StatelessWidget {
  final String orderId;

  const ConfirmOrder({super.key, required this.orderId});

  Future<void> moveOrderToPrevious(BuildContext context) async {
    try {
      DocumentSnapshot orderDoc = await FirebaseFirestore.instance
          .collection('activityOrder')
          .doc(orderId)
          .get();

      if (orderDoc.exists) {
        await FirebaseFirestore.instance
            .collection('previousOrder')
            .doc(orderId)
            .set(orderDoc.data() as Map<String, dynamic>);

        await FirebaseFirestore.instance
            .collection('activityOrder')
            .doc(orderId)
            .delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم نقل الطلب الى الطلبات المنجزة بنجاح')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لم يتم ايجاد طلب')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في نقل الطلب: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Icon(
            Icons.done_outline_outlined,
            size: 150,
            color: Kprimary_color,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'مندوبنا بالطريق اليك',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'نشكركم لاستخدام خدمة pharam home',
            style: TextStyle(
                color: Kprimary_color,
                fontSize: 35,
                fontWeight: FontWeight.bold),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              await moveOrderToPrevious(context);
              Get.off(() => RepositoryHomeStorePage(),
                  transition: Transition.circularReveal,
                  duration: Duration(seconds: 3));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 90),
              height: 60,
              decoration: BoxDecoration(
                color: Kprimary_color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'العودة للصفحة الرئيسية',
                  style: TextStyle(
                      color: Kwhite_color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
