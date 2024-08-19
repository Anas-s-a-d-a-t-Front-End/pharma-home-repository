import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_home/const_value/constrain.dart';
import 'package:pharma_home/order_pages/activity_order.dart';
import 'package:pharma_home/order_pages/comblite_order.dart';
import 'package:pharma_home/payment%20methods/Complete%20the%20order.dart';

class orders_page extends StatefulWidget {
  const orders_page({super.key});

  @override
  State<orders_page> createState() => _orders_pageState();
}

class _orders_pageState extends State<orders_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('الطلبيات'),
          centerTitle: true,
          backgroundColor: Kprimary_color,
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Kprimary_color),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display user data
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => OrderDetails(),
                            duration: Duration(seconds: 3),
                            transition: Transition.cupertino);
                      },
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Kwhite_color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.alarm_on_outlined,
                              size: 100,
                              color: Kprimary_color,
                            ),
                            Divider(
                              color: Kprimary_color,
                              endIndent: 30,
                              indent: 30,
                            ),
                            Text(
                              'الطلبات النشطة',
                              style: TextStyle(
                                  fontSize: 18, color: Kprimary_color),
                            ),
                            Divider(
                              color: Kprimary_color,
                              endIndent: 30,
                              indent: 30,
                            ),
                            Text(
                              'اضغط لمعرفة الطلبات النشطة',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CombliteOrder(),
                            duration: Duration(seconds: 3),
                            transition: Transition.cupertino);
                      },
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Kwhite_color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.done_outline_outlined,
                              size: 100,
                              color: Kprimary_color,
                            ),
                            Divider(
                              color: Kprimary_color,
                              endIndent: 30,
                              indent: 30,
                            ),
                            Text(
                              'الطلبات المنجزة',
                              style: TextStyle(
                                  fontSize: 18, color: Kprimary_color),
                            ),
                            Divider(
                              color: Kprimary_color,
                              endIndent: 30,
                              indent: 30,
                            ),
                            Text(
                              'أضغط لمعرفة الطلبات المنتهية',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
