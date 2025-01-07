import 'dart:developer';

import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/customer_model.dart';
import 'package:aseel/services/api_service.dart';
import 'package:aseel/utils/form_helper.dart';
import 'package:aseel/utils/progress_hud.dart';
import 'package:aseel/utils/validator_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late APIService apiService;
  CustomerModel model = CustomerModel();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiService = APIService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: false,
      opacity: 3.0,
      child: _uiSetup(),
    );
  }

  Widget _uiSetup() {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Theme.of(context).primaryColor, boxShadow: [
                    BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.2), offset: const Offset(0, 10), blurRadius: 20),
                  ]),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Text("Register", style: Theme.of(context).textTheme.displayMedium),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(color: AppColors.accentColor),
                          keyboardType: TextInputType.text,
                          onSaved: (input) => model.firstName = input ?? "",
                          validator: (value) {
                            if (value.toString().isEmpty) return "Please enter your first name";
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "First Name..",
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor.withOpacity(0.2))),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(color: AppColors.accentColor),
                          keyboardType: TextInputType.text,
                          onSaved: (input) => model.lastName = input ?? "",
                          validator: (value) {
                            if (value.toString().isEmpty) return "Please enter your last name";
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Last Name..",
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor.withOpacity(0.2))),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(color: AppColors.accentColor),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => model.email = input ?? "",
                          validator: (value) {
                            if (value.toString().isEmpty) return "Please enter your email";
                            if (!value.toString().isValidEmail()) return "Please enter a valid email";
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Email address..",
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor.withOpacity(0.2))),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(color: AppColors.accentColor),
                          keyboardType: TextInputType.text,
                          obscureText: hidePassword,
                          onSaved: (input) => model.password = input ?? "",
                          validator: (value) => (value.toString().length < 6) ? "Password should be more than 6 character" : null,
                          decoration: InputDecoration(
                              hintText: "password..",
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor.withOpacity(0.2))),
                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor)),
                              suffixIcon: IconButton(
                                icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,
                                    color: AppColors.accentColor.withOpacity(0.2)),
                                onPressed: () => setState(() => hidePassword = !hidePassword),
                              )),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: FormHelper.saveButton("Register", () {
                            if (validateAndSave()) {
                              log(model.toJson());
                              setState(() => isApiCallProcess = true);

                              apiService.createCustomer(model).then((ret) {
                                setState(() => isApiCallProcess = false);

                                FormHelper.showMessage(
                                  context,
                                  title: "Al Aseel",
                                  message: ret ? "Registered Successfully" : "Email Already Registered",
                                  buttonText: "Ok",
                                  onPressed: () => Navigator.of(context).pop(),
                                );
                              });
                            }
                          }),
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
    );
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
