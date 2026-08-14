import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/screen_size.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/input_box.dart';
import '../controllers/auth_controller.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({super.key});

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  final AuthController _authController = Get.find();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "auth.forgot_password.reset_title".tr,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          SizedBox(
            height: getScreenHeight(context) * 0.02,
          ),
          InputBoxWidget(
            inputType: InputType.password,
            label: "auth.forgot_password.new_password".tr,
            controller: _newPasswordController,
            focus: _newPasswordFocusNode,
            focusNext: _confirmPasswordFocusNode,
            showLabel: true,
          ),
          SizedBox(
            height: getScreenHeight(context) * 0.02,
          ),
          InputBoxWidget(
            inputType: InputType.confirmPass,
            label: "auth.forgot_password.confirm_password".tr,
            controller: _confirmPasswordController,
            focus: _confirmPasswordFocusNode,
            showLabel: true,
            pass: _newPasswordController,
          ),
          SizedBox(
            height: getScreenHeight(context) * 0.02,
          ),
          Obx(() => ButtonWidget(
                text: "auth.forgot_password.reset_button".tr,
                loadingText: "auth.forgot_password.reset_loading".tr,
                fontSize: 16,
                isLoading: _authController.isResettingPassword.value,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _authController
                        .resetPassword(_confirmPasswordController.text.trim());
                  }
                },
              ))
        ],
      ),
    );
  }
}
