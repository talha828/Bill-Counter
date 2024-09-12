
import 'dart:typed_data';

import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/loading_indicator.dart';
import 'package:book_bank/model/main_screen_controller.dart';
import 'package:book_bank/view/create_customer_screen/create_cusomer_screen.dart';
import 'package:book_bank/view/edit_profile_screen/edit_profile_screen.dart';
import 'package:book_bank/view/login_screen/login_screen.dart';
import 'package:book_bank/view/monthly_data_input_screen/monthly_data_input_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatelessWidget {
   MainScreen({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.put(MainScreenController());
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: StreamBuilder<DocumentSnapshot>(
          stream: _firestore
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .snapshots(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Show loading
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('No User Data Available')); // No data available
            }
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            String userName = userData['name'] ?? 'User Name';
            String userEmail = userData['email'] ?? 'user@example.com';
            Uint8List? profileImage = userData['image']?.bytes; // Get the image blob
            return ListView(
              padding: const EdgeInsets.all(0),
              children: [
                 DrawerHeader(
                  decoration: const BoxDecoration(
                    color: appThemeColor,
                  ), //BoxDecoration
                  child: UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    decoration: const BoxDecoration(color: appThemeColor),
                    accountName: Text(
                      userName,
                      style: const TextStyle(color: Colors.white,fontSize: 18),
                    ),
                    accountEmail: Text(userEmail,style: const TextStyle(color: Colors.white,),),
                    currentAccountPictureSize: Size.fromRadius(width * 0.2),
                    currentAccountPicture: profileImage != null
                        ? Container(
                      margin: EdgeInsets.symmetric(vertical: width * 0.02),
                          child: CircleAvatar( radius: width * 0.1,
                                                backgroundImage: MemoryImage(profileImage), // Show the image if available
                                              ),
                        )
                        : Container(
                        margin: EdgeInsets.symmetric(vertical: width ),
                          child: const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Text(
                          "A",
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                                                ),
                                              ),
                        ), //circleAvatar
                  ), //UserAccountDrawerHeader
                ), //DrawerHeader
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(' My Profile'),
                  onTap: () {
                    Get.to(EditProfileScreen());
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Next Month'),
                  onTap: ()async {
                    controller.isLoading.value
                          ? {}
                          : await controller.copyCustomerNamesForNewMonth(context);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('LogOut'),
                  onTap: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString("email", "null");
                    await prefs.setString("password", "password");
                    Get.offAll(LoginScreen());
                  },
                ),
              ],
            );
          },
        )
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: appThemeColor,
        title: Obx(() => InkWell(
              onTap: () async => controller.isLoading.value
                  ? {}
                  : await controller.showMonthPickerDialog(context),
              child: Text(
                controller.selectedMonth.value.replaceAll("20", ""),
                style: const TextStyle(color: Colors.white),
              ),
            )),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.copy, color: Colors.white),
          //   onPressed: () async => controller.isLoading.value
          //       ? {}
          //       : await controller.copyCustomerNamesForNewMonth(context),
          // ),
          IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () => controller.isLoading.value
                  ? {}
                  : Get.to(AddCustomerScreen()))
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Positioned.fill(child: LoadingIndicator());
        }
        return StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('customers').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final customers = snapshot.data!.docs;
            return SingleChildScrollView(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  final customer = customers[index];
                  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream:
                          controller.getCustomerMonthlyDataStream(customer.id),
                      builder: (context, monthlyDataSnapshot) {
                        if (monthlyDataSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const ListTile(
                            title: Text('Loading...'),
                            subtitle: Text('Fetching data...'),
                          );
                        }
              
                        if (monthlyDataSnapshot.hasError ||
                            !monthlyDataSnapshot.hasData ||
                            !monthlyDataSnapshot.data!.exists) {
                          return Container();
                        }
              
                        // If data exists, display the relevant data in subtitle
                        final data = monthlyDataSnapshot.data!.data();
                        double totalMilk = double.parse(data!['total_milk'].toString()) ?? 0.0;
                        String milkData = data?['summary'] ?? "xx:(0-0):xx";
                        String receivedAmount = data?['received_amount'].toString() ?? 0.toString();
                        String previousAmount = data?['previous_amount'].toString() ?? 0.toString();
              
                        return _buildCustomerTile(
                            customer,
                            Text(
                              milkData
                                  .split(":")[1]
                                  .replaceAll("(", " ")
                                  .replaceAll(")", " ")
                                  .replaceAll("-", "--"),
                            ),
                            Text(
                              "${double.parse(totalMilk.toStringAsFixed(2))}L - ${(double.parse(previousAmount) - double.parse(receivedAmount)).toStringAsFixed(0)}",
                              style: TextStyle(fontSize: width * 0.05),
                            ),
                            controller,context);
                      });
                },
                // separatorBuilder: (context, index) => const Divider(),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: appThemeColor,
          onPressed: ()async=> controller.fetchAndOpenPdf(context,controller.selectedMonth.value), label: Row(children: [Text("Generate Invoice",style: TextStyle(color: Colors.white),),SizedBox(width: width*0.02,),Icon(Icons.play_arrow_outlined,color: Colors.white,)],)),
    );
  }

  Widget _buildCustomerTile(DocumentSnapshot customer, Widget subtitle,
      Widget trailing, MainScreenController controller, BuildContext context) {
    return  ListTile(
      title: Text(customer['name'].toString().toUpperCase()),
      subtitle: subtitle,
      trailing: trailing,
      onLongPress:()=> controller.showDeleteOptions(customer.id,context),
      onTap: () => Get.to(MonthlyDataInputScreen(
          customerId: customer.id,
          selectedMonth: controller.selectedMonth.value,
          customerName: customer['name'])),
    );
  }
}
