import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_home/const_value/constrain.dart';
import 'package:pharma_home/logic_operations/cart_provider.dart';
import 'package:pharma_home/payment%20methods/choise_payment_methoud.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  double? delivery_cost = 0.0;
  double? total_cost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Container(
            width: double.infinity,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0XFF21A06A),
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.location_on),
                        color: Colors.white,
                        iconSize: 35,
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 125,
                      height: 125,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0XFF21A06A),
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        color: Colors.white,
                        iconSize: 35,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("الاوامر النشطة",
                        style: TextStyle(fontSize: 20, color: Kprimary_color)),
                  ],
                ),
                Divider(color: Kprimary_color),
                SizedBox(height: 20),
                cartProvider.items.isEmpty
                    ? Center(
                        child: Text(
                        'السلة فارغة',
                        style: TextStyle(
                            fontSize: 20,
                            color: Kprimary_color,
                            fontWeight: FontWeight.bold),
                      ))
                    : GridView.builder(
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: cartProvider.items.length,
                        itemBuilder: (context, index) {
                          var item = cartProvider.items[index];
                          return Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Kprimary_color, width: 2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 125,
                                        padding: EdgeInsets.only(left: 5),
                                        child: item['image'] != null
                                            ? Image.network(
                                                item['image'] ?? '',
                                                fit: BoxFit.fill,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Icon(
                                                    Icons.image_not_supported,
                                                    size: 100,
                                                    color: Kprimary_color,
                                                  );
                                                },
                                              )
                                            : Icon(
                                                Icons.image_not_supported,
                                                size: 100,
                                                color: Kprimary_color,
                                              ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: Text(
                                          'السعر: ${item['price'] ?? 'غير متوفر'} ل.س',
                                          style: TextStyle(
                                              color: Kprimary_color,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        item['name'] ?? 'غير متوفر',
                                        style: TextStyle(
                                            color: Kprimary_color,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        'الكمية: ${item['count'] ?? 'غير متوفر'}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.remove_circle_outline),
                                        color: Colors.red,
                                        onPressed: () {
                                          cartProvider.removeItem(index);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Kprimary_color,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'المجموع: ${cartProvider.totalPrice} ل.س',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'التوصيل:${delivery_cost = cartProvider.totalPrice * 0.3}  ل.س',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Kprimary_color,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'المجموع الكلي: ${total_cost = cartProvider.totalPrice + delivery_cost!} ل.س',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (total_cost! >= 30000) {
                      Get.to(
                        () => ChoicePaymentMethods(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(seconds: 3),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'السلة فارغة يرجى تعبئة السلة والمحاولة مرة اخرى',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 100),
                    decoration: BoxDecoration(
                      color: Kprimary_color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'اتمام عملية الشراء',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
