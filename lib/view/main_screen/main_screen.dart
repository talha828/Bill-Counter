import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/loading_indicator.dart';
import 'package:book_bank/model/main_screen_controller.dart';
import 'package:book_bank/view/create_customer_screen/create_cusomer_screen.dart';
import 'package:book_bank/view/monthly_data_input_screen/monthly_data_input_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.put(MainScreenController());
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
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
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.white),
            onPressed: () async => controller.isLoading.value
                ? {}
                : await controller.copyCustomerNamesForNewMonth(context),
          ),
          IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () => controller.isLoading.value
                  ? {}
                  : Get.to(const AddCustomerScreen()))
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
              child: ListView.separated(
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
                          return _buildCustomerTile(
                              customer,
                              Text(
                                  'No data for ${controller.selectedMonth.value}'),
                              Text(
                                  'No data for ${controller.selectedMonth.value}'),
                              controller);
                        }
              
                        // If data exists, display the relevant data in subtitle
                        final data = monthlyDataSnapshot.data!.data();
                        double totalMilk = data?['total_milk'] ?? 0.0;
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
                            controller);
                      });
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildCustomerTile(DocumentSnapshot customer, Widget subtitle,
      Widget trailing, MainScreenController controller) {
    return ListTile(
      title: Text(customer['name'].toString().toUpperCase()),
      subtitle: subtitle,
      trailing: trailing,
      onTap: () => Get.to(MonthlyDataInputScreen(
          customerId: customer.id,
          selectedMonth: controller.selectedMonth.value,
          customerName: customer['name'])),
    );
  }
}
