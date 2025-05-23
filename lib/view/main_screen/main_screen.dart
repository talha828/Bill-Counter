import 'dart:typed_data';
import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/loading_indicator.dart';
import 'package:book_bank/model/customer_model.dart';
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
import 'package:text_to_speech/text_to_speech.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextToSpeech tts = TextToSpeech();
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
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
                child: Text('No User Data Available')); // No data available
          }
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          String userName = userData['name'] ?? 'User Name';
          String userEmail = userData['email'] ?? 'user@example.com';
          Uint8List? profileImage =
              userData['image']?.bytes; // Get the image blob
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
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  accountEmail: Text(
                    userEmail,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  currentAccountPictureSize: Size.fromRadius(width * 0.2),
                  currentAccountPicture: profileImage != null
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: width * 0.02),
                          child: CircleAvatar(
                            radius: width * 0.1,
                            backgroundImage: MemoryImage(
                                profileImage), // Show the image if available
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: width),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              "A",
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white),
                            ),
                          ),
                        ), //circleAvatar
                ), //UserAccountDrawerHeader
              ), //DrawerHeader
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(' My Profile'),
                onTap: () {
                  Get.to(const EditProfileScreen());
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Create Customer'),
                onTap: () async {
                  Get.to(AddCustomerScreen());
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Start New Month'),
                onTap: () async => controller.isLoading.value
                    ? {}
                    : await controller.copyCustomerNamesForNewMonth(context),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString("email", "null");
                  await prefs.setString("password", "password");
                  Get.offAll(LoginScreen());
                },
              ),
            ],
          );
        },
      )),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: appThemeColor,
        title: Obx(
          () => InkWell(
            onTap: () async => controller.isLoading.value
                ? {}
                : await controller.showMonthPickerDialog(context),
            child: Text(
              controller.selectedMonth.value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () => controller.fetchAndOpenInvoicePdf(
                  context, controller.selectedMonth.value)),
        ],
      ),
      body: Obx(
        () {
          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.searchController,
                      onChanged: (query) => controller.filterCustomers(query),
                      decoration: const InputDecoration(
                        labelText: 'Search Customers',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.filteredCustomers.length,
                            itemBuilder: (context, index) {
                              final customer = controller.filteredCustomers[index];
                              return StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                                stream: controller.getCustomerMonthlyDataStream(customer.id),
                                builder: (context, monthlyDataSnapshot) {
                                  if (monthlyDataSnapshot.connectionState == ConnectionState.waiting) {
                                    return const ListTile(
                                      title: Text('Loading...'),
                                      subtitle: Text('Fetching data...'),
                                    );
                                  }

                                  if (monthlyDataSnapshot.hasError || !monthlyDataSnapshot.hasData || !monthlyDataSnapshot.data!.exists) {
                                    return Container();
                                  }

                                  // If data exists, display the relevant data in subtitle
                                  final data = monthlyDataSnapshot.data!.data();
                                  double totalMilk = double.parse(data!['total_milk'].toString()) ?? 0.0;
                                  String milkData = data['summary'] ?? "xx:(0-0):xx";
                                  String receivedAmount = data['received_amount'].toString();
                                  String previousAmount = data['previous_amount'].toString();

                                  return _buildCustomerTile(
                                    customer,
                                    Text(milkData.split(":")[1].replaceAll("(", " ").replaceAll(")", " ").replaceAll("-", "--"),),
                                    Summary(
                                        totalMilk: totalMilk,
                                        previousAmount: previousAmount,
                                        receivedAmount: receivedAmount,
                                        width: width),
                                    controller,
                                    context,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              controller.isLoading.isTrue
                  ? const Positioned.fill(
                      child: LoadingIndicator(),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: appThemeColor,
        onPressed: () async => await controller.fetchAndOpenSummaryPdf(
            context, controller.selectedMonth.value),
        label: Row(
          children: [
            const Text(
              "Generate Summary",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            const Icon(
              Icons.play_arrow_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerTile(DocumentSnapshot customer, Widget subtitle, Widget trailing, MainScreenController controller, BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(
            customer['name'].toString().toUpperCase(),
          ),
          const SizedBox(width: 10,),
          IconButton(onPressed: ()=> tts.speak(customer['name'].toString()), icon: const Icon(Icons.volume_up))
        ],
      ),
      subtitle: subtitle,
      trailing: trailing,
      onLongPress: () => controller.showDeleteOptions(customer.id, context),
      onTap: () => Get.to(
        MonthlyDataInputScreen(
          customer: CustomerModel(
            id: customer.id,
            name: customer['name'],
            phoneNumber: "+92xxx",
          ),
          selectedMonth: controller.selectedMonth.value,
        ),
      ),
    );
  }
}

class Summary extends StatelessWidget {
  const Summary({
    super.key,
    required this.totalMilk,
    required this.previousAmount,
    required this.receivedAmount,
    required this.width,
  });

  final double totalMilk;
  final String previousAmount;
  final String receivedAmount;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${double.parse(totalMilk.toStringAsFixed(2))}L - ${(double.parse(previousAmount) - double.parse(receivedAmount)).toStringAsFixed(0)}",
      style: TextStyle(fontSize: width * 0.05),
    );
  }
}
