import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_home/const_value/constrain.dart';
import 'package:pharma_home/payment%20methods/Complete%20the%20order.dart';

class ChoicePaymentMethods extends StatefulWidget {
  const ChoicePaymentMethods({super.key});

  @override
  State<ChoicePaymentMethods> createState() => _ChoicePaymentMethodsState();
}

class _ChoicePaymentMethodsState extends State<ChoicePaymentMethods> {
  String selectedPaymentMethod = '';

  Future<void> _handleTap(String paymentMethod) async {
    // Set the selected payment method and update the state
    setState(() {
      selectedPaymentMethod = paymentMethod;
    });

    // Wait for 5 seconds
    await Future.delayed(Duration(seconds: 2));

    // Navigate to different pages based on payment method
    if (paymentMethod == 'card') {
      Get.to(() => complete_the_order(),
          duration: Duration(seconds: 3), transition: Transition.fadeIn);
    } else if (paymentMethod == 'cash') {
      Get.to(() => complete_the_order(),
          duration: Duration(seconds: 3), transition: Transition.fadeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kprimary_color,
        title: Text(
          'طرق الدفع',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Kprimary_color, Colors.green],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'الرجاء اختيار طريقة دفع',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _handleTap('card'),
                    child: Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                        color: selectedPaymentMethod == 'card'
                            ? Kprimary_color
                            : Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Icon(
                            Icons.payment,
                            color: Colors.white,
                            size: 100,
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Text(
                              'بطاقة بنك',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _handleTap('cash'),
                    child: Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                        color: selectedPaymentMethod == 'cash'
                            ? Kprimary_color
                            : Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Icon(
                            Icons.payments_rounded,
                            color: Colors.white,
                            size: 100,
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Text(
                              'نقدي',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
