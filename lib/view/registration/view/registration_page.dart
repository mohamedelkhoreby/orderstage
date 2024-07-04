import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/style_manager.dart';
import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../cubit/registration_cubit.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit()..fetchCountries(),
      child: Scaffold(
        backgroundColor: ColorManager.appbar,
        body: _registrationbody(),
      ),
    );
  }

  // Widget to build the registration body with BlocBuilder
  BlocBuilder<RegistrationCubit, List<String>> _registrationbody() {
    return BlocBuilder<RegistrationCubit, List<String>>(
      builder: (context, countries) {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: ColorManager.homebackground,
              ),
              child: const Image(
                  image: AssetImage(ImageAssets.homebackground),
                  fit: BoxFit.scaleDown),
            ),
            Container(
              height: 270,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: ColorManager.appbar,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      child: Text(
                        'تسجيل جديد',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: blodTajawalStyle(
                            fontSize: FontSize.s15,
                            color: ColorManager.homebackground),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Icon(
                          Icons.arrow_forward,
                          color: ColorManager.homebackground,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Main registration form container
            Padding(
              padding: const EdgeInsets.only(
                  top: 100, bottom: 15, left: 20, right: 20),
              child: _registrationForm(context, countries),
            ),
          ],
        );
      },
    );
  }

// Method to Registration form
  Container _registrationForm(BuildContext context, List<String> countries) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: ColorManager.background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Center(
                child: Image.asset(
                  ImageAssets.logo,
                  width: 180,
                ),
              ),
              const SizedBox(height: 16),
              if (countries.isEmpty)
                const Center(
                    child: CircularProgressIndicator(
                  color: ColorManager.homebackground,
                )),
              if (countries.isNotEmpty)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorManager.white,
                      hintText: 'الرجاء اختيار الدولة',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: semiBlodTajawal(
                          fontSize: FontSize.s10, color: ColorManager.gray),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.arrow_drop_down,
                          color: ColorManager.gray),
                      suffixIcon: const Icon(Icons.flag_outlined,
                          color: ColorManager.gray)),
                  icon: Container(),
                  menuMaxHeight: MediaQuery.of(context).size.height / 2,
                  items: countries.map((country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(
                        country,
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              const SizedBox(height: 16),
              _buildTextField('إسم المنشأة', Icons.business),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorManager.white,
                        hintTextDirection: TextDirection.rtl,
                        hintText: 'عدد الفروع',
                        hintStyle: semiBlodTajawal(
                            fontSize: FontSize.s10, color: ColorManager.gray),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorManager.white,
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'عددالعلامات التجارية',
                          hintStyle: semiBlodTajawal(
                              fontSize: FontSize.s10, color: ColorManager.gray),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorManager.white,
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'رقم السجل التجاري أو رقم التسجيل في معروف',
                    hintStyle: semiBlodTajawal(
                        fontSize: FontSize.s10, color: ColorManager.gray),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 5),
                child: Text(
                  'بيانات مقدم الطلب',
                  textDirection: TextDirection.rtl,
                  style: blodTajawalStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.homebackground),
                ),
              ),
              _buildTextField('الاسم الثلاثي', Icons.person),
              _buildTextField('الصفة', Icons.business_center_outlined,
                  Icons.arrow_drop_down, true),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: ColorManager.background,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 4,
                      child: _buildTextField('رقم الجوال', Icons.phone)),
                ],
              ),
              _buildTextField('البريد الإلكتروني', Icons.email),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      ' الشروط والاحكام',
                      textHeightBehavior: TextHeightBehavior(),
                      textDirection: TextDirection.rtl,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: FontConstants.tajawal,
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.regular,
                          decoration: TextDecoration.underline,
                          color: Colors.green),
                    ),
                    Text(
                      'أوافق على كافة',
                      textDirection: TextDirection.rtl,
                      maxLines: 1,
                      style: blodTajawalStyle(
                          fontSize: FontSize.s11,
                          color: ColorManager.homebackground),
                    ),
                  ],
                ),
                value: true,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: Text(
                  'أقر أن كافة المعلومات التي اسجلها صحيحة, وانى صاحب الصلاحية المفوض في تسحيل البيانات الخاصة بالمطعم التي اقوم بتسجيلها',
                  textDirection: TextDirection.rtl,
                  style: blodTajawalStyle(
                      fontSize: FontSize.s11,
                      color: ColorManager.homebackground),
                ),
                value: true,
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorManager.appbar,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _goNext();
                    },
                    child: Text(
                      'التالي',
                      style: blodTajawalStyle(
                          fontSize: FontSize.s18,
                          color: ColorManager.homebackground),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

// Method to navigate to the next screen
  _goNext() async {
    await push(NamedRoutes.main);
  }

// Method to build a text field with optional parameters
  _buildTextField(
      [String? label, IconData? icon, IconData? prefix, bool? read]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: read ?? false,
        decoration: InputDecoration(
          filled: true,
          fillColor:
              read == true ? ColorManager.background : ColorManager.white,
          prefixIcon: Icon(prefix, color: ColorManager.gray),
          hintTextDirection: TextDirection.rtl,
          hintText: label,
          hintStyle:
              semiBlodTajawal(fontSize: FontSize.s10, color: ColorManager.gray),
          suffixIcon: Icon(icon, color: ColorManager.gray),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
