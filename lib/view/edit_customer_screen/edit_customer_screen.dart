import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/bbutton.dart';
import 'package:book_bank/components/widgets/btextfield.dart';
import 'package:book_bank/components/widgets/loading_indicator.dart';
import 'package:book_bank/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditCustomerScreen extends StatefulWidget {
  final CustomerModel customer;

  const EditCustomerScreen({
    super.key,
    required this.customer,
  });

  @override
  _EditCustomerScreenState createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    fetchCustomerById(widget.customer.id);
  }

  void updateCustomer() async {
    isLoading.value = true;
    String name = nameController.text;
    String number = phoneNumberController.text;

    try {
      // Update customer data in Firestore
      await FirebaseFirestore.instance
          .collection(email)
          .doc(widget.customer.id)
          .update({
        'name': name,
        'number': number.isEmpty ? null : number, // Save as null if empty
      });

      Get.snackbar("Success", "Customer updated successfully!");
      Get.back(); // Close the screen after saving
    } catch (e) {
      Get.snackbar("Error", "Failed to update customer data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCustomerById(String customerId) async {
    try {
      // Get the document snapshot for the given customer ID
      DocumentSnapshot customerDoc = await FirebaseFirestore.instance
          .collection(email)
          .doc(customerId)
          .get();

      if (customerDoc.exists) {
        Map<String, dynamic> data = customerDoc.data() as Map<String, dynamic>;

        // Safely access the 'number' field
        String number =
            data.containsKey('number') ? data['number'] as String : "+92301xxx";

        // You can also handle other fields similarly if needed

        // Return the data with 'number' safely accessed

        setState(() {
          nameController.text = data['name'] as String? ?? '';
          phoneNumberController.text = number;
        });
        // Include other fields as necessary
      }
    } catch (e) {
      print("Error fetching customer: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appThemeColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Edit Customer",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body:Stack(
          children: [
            Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BTextField(
                            controller: nameController,
                            hintText: "Hamza",
                            labelText: "Name",
                            obscureText: false,
                          ),
                          SizedBox(height: width * 0.04),
                          BTextField(
                            controller: phoneNumberController,
                            hintText: "+92301xxx",
                            keyboardType: TextInputType.number,
                            labelText: "Phone Number",
                            obscureText: false,
                          ),
                          const Spacer(),
                          SizedBox(height: width * 0.4),

                          BButton(
                              onTap: updateCustomer,
                              width: width,
                              title: "Save Customer"),
                        ],
                      ),
                    ),
            Obx(() {
              if (isLoading.value) {
                return const Positioned.fill(child: LoadingIndicator());
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        )
        );
  }
}
