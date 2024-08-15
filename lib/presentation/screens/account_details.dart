import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/widgets/error_message.dart';
import 'package:golden_wave/provider/fetch_data_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});
  static String id = 'AccountDetails';

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  PhoneNumber? phoneNumber;

  @override
  void initState() {
    super.initState();
    Provider.of<FetchDataProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffC9C9C9),
                MyColors.myYellow,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            const Spacer(flex: 1),
            Text(
              S.of(context).accountDetails,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 23.sp,
                color: Colors.black,
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
      backgroundColor: MyColors.myWhite,
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(20.0.r),
            child: ListView(
              children: [
                Gap(70.h),
                Consumer<FetchDataProvider>(
                  builder: (context, value, child) {
                    return SizedBox(
                      height: 50.h,
                      child: TextField(
                        controller: fullNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            size: 25.r,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.r)),
                          labelText: S.of(context).labelName,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: value.fullName,
                          hintStyle: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Gap(20.h),
                Consumer<FetchDataProvider>(
                  builder: (context, value, child) {
                    return InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        phoneNumber = number;
                      },
                      onInputValidated: (bool value) {
                        // Handle input validation if needed
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        showFlags: true,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      textFieldController: phoneNumberController,
                      formatInput: false,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputDecoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 15.sp,
                          color: MyColors.myGrey,
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.blueAccent,
                          size: 25.r,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        labelText: S.of(context).labelPhone,
                        hintText: value
                            .phoneNumber, // Set hintText to display the phone number
                        hintStyle: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).emptyPhone;
                        }
                        return null;
                      },
                    );
                  },
                ),
                Gap(30.h),
                GestureDetector(
                  onTap: () async {
                    var fetchDataProvider =
                        Provider.of<FetchDataProvider>(context, listen: false);

                    bool isFullNameUpdated = false;
                    bool isPhoneNumberUpdated = false;

                    // Check if full name is not empty and update
                    if (fullNameController.text.isNotEmpty) {
                      await fetchDataProvider
                          .updateFullname(fullNameController.text);
                      isFullNameUpdated = true;
                    }

                    // Check if phone number is not empty and update
                    if (phoneNumberController.text.isNotEmpty) {
                      await fetchDataProvider
                          .updatePhoneNumber(phoneNumberController.text);
                      isPhoneNumberUpdated = true;
                    }

                    // Show a single success message if at least one field is updated
                    if (isFullNameUpdated || isPhoneNumberUpdated) {
                      showMessage(
                        context,
                        title: S.of(context).Success,
                        desText: S.of(context).changesDone,
                        icon: Icons.done_all_sharp,
                        iconColor: Colors.green,
                        backgroundColor: MyColors.myYellow,
                        textColor: Colors.black,
                        titelColor: Colors.black,
                        alignment: Alignment.topLeft,
                      );

                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: MyColors.myYellow,
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).save,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'inter',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
