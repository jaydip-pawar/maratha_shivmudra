import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/base/base_widget/modular_state.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/member_form/bloc/form_bloc.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/animated_button.dart';
import 'package:maratha_shivmudra/src/widgets/responsive_rc.dart';
import 'package:maratha_shivmudra/src/widgets/section.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/text_field.dart';

class MemberFormView extends ModularState<MemberFormBloc> {
  const MemberFormView(super.bloc, {super.key});

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    bool isCompulsory = false,
    IconData? icon,
    VoidCallback? onTap,
    bool readOnly = false,
    bool absorbPointer = false,
    final String? Function(String?)? validator,
    String? errorMessage,
  }) {
    return CustomTextField(
      labelText: label,
      controller: controller,
      isCompulsory: isCompulsory,
      prefixIconData: icon,
      onTap: onTap,
      readOnly: readOnly,
      absorbPointer: absorbPointer,
      validator: validator ??
          (value) {
            if (isCompulsory) {
              if (value == null || value.isEmpty) {
                return errorMessage ?? '$label cannot be empty';
              }
              return null;
            }
            return null;
          },
    );
  }

  Widget _buildSection(BuildContext context, List<Widget> children) {
    return Section(
      spacing: 2,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context, MemberFormBloc model) {
    final formBloc = model;

    return Scaffold(
      backgroundColor: Colors.white10,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Form(
                key: formBloc.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16,
                  children: [
                    32.h,
                    Text(
                      context.l10n.member_form,
                      style: const TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    16.h,

                    // Personal Details Section
                    _buildSection(context, [
                      ResponsiveRC(
                        children: [
                          _buildTextField(
                            context,
                            label: context.l10n.first_name,
                            controller: formBloc.firstNameController,
                            isCompulsory: true,
                            icon: Icons.person_outline,
                            errorMessage:
                                context.l10n.please_enter_your_first_name,
                          ),
                          _buildTextField(
                            context,
                            label: context.l10n.middle_name,
                            controller: formBloc.middleNameController,
                          ),
                          _buildTextField(
                            context,
                            label: context.l10n.last_name,
                            controller: formBloc.lastNameController,
                            isCompulsory: true,
                            errorMessage:
                                context.l10n.please_enter_your_last_name,
                          ),
                        ],
                      ),
                      _buildTextField(
                        context,
                        label: context.l10n.date_of_birth,
                        controller: formBloc.dateOfBirthController,
                        isCompulsory: true,
                        icon: Icons.calendar_today_outlined,
                        readOnly: true,
                        absorbPointer: true,
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            formBloc.dateOfBirthController.text =
                                selectedDate.toLocal().toString().split(' ')[0];
                          }
                        },
                        errorMessage:
                            context.l10n.please_enter_your_date_of_birth,
                      ),
                    ]),

                    // Address Section
                    _buildSection(context, [
                      _buildTextField(
                        context,
                        label: context.l10n.address,
                        controller: formBloc.addressController,
                        isCompulsory: true,
                        errorMessage: context.l10n.please_enter_your_address,
                      ),
                      _buildTextField(
                        context,
                        label: context.l10n.room_no,
                        controller: formBloc.roomNoController,
                        isCompulsory: true,
                        errorMessage:
                            context.l10n.please_enter_your_room_number,
                      ),
                      ResponsiveRC(
                        children: [
                          _buildTextField(
                            context,
                            label: context.l10n.city,
                            controller: formBloc.cityController,
                            isCompulsory: true,
                            errorMessage: context.l10n.please_enter_your_city,
                          ),
                          _buildTextField(
                            context,
                            label: context.l10n.state,
                            controller: formBloc.stateController,
                            isCompulsory: true,
                            errorMessage: context.l10n.please_enter_your_state,
                          ),
                        ],
                      ),
                      ResponsiveRC(
                        children: [
                          _buildTextField(
                            context,
                            label: context.l10n.pincode,
                            controller: formBloc.pincodeController,
                            isCompulsory: true,
                            errorMessage:
                                context.l10n.please_enter_your_pincode,
                          ),
                          _buildTextField(
                            context,
                            label: context.l10n.country,
                            controller: formBloc.countryController,
                            isCompulsory: true,
                            errorMessage:
                                context.l10n.please_enter_your_country,
                          ),
                        ],
                      ),
                    ]),

                    // Contact Details
                    _buildSection(context, [
                      _buildTextField(
                        context,
                        label: context.l10n.mobile_no,
                        readOnly: true,
                        absorbPointer: true,
                        controller: formBloc.mobileNoController,
                        isCompulsory: true,
                        icon: Icons.phone_outlined,
                        errorMessage:
                            context.l10n.please_enter_your_mobile_number,
                      ),
                      _buildTextField(
                        context,
                        label: context.l10n.email,
                        controller: formBloc.emailController,
                        isCompulsory: true,
                        icon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.please_enter_your_email;
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return context.l10n.please_enter_a_valid_email;
                          }
                          return null;
                        },
                      ),
                    ]),
                    16.h,
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: AnimatedButton(
                        text: context.l10n.submit,
                        onTap: () async {
                          if (formBloc.formKey.currentState!.validate()) {
                            await formBloc.setFormData();
                          }
                        },
                      ),
                    ),
                    16.h,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
