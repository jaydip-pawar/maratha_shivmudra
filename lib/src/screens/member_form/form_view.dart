import 'package:flutter/material.dart' hide FormState;
import 'package:maratha_shivmudra/core/base/base_widget/modular_state.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/member_form/bloc/form_bloc.dart';
import 'package:maratha_shivmudra/src/widgets/responsive_rc.dart';
import 'package:maratha_shivmudra/src/widgets/section.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/text_field.dart';

class FormView extends ModularState<FormBloc> {
  const FormView(super.bloc, {super.key});

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    bool isCompulsory = false,
    IconData? icon,
    VoidCallback? onTap,
    bool readOnly = false,
    bool absorbPointer = false,
  }) {
    return CustomTextField(
      labelText: label,
      controller: controller,
      isCompulsory: isCompulsory,
      prefixIconData: icon,
      onTap: onTap,
      readOnly: readOnly,
      absorbPointer: absorbPointer,
    );
  }

  Widget _buildSection(BuildContext context, List<Widget> children) {
    return Section(
      spacing: 16,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context, FormBloc model) {
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  32.h,

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
                    ),
                  ]),

                  // Address Section
                  _buildSection(context, [
                    _buildTextField(
                      context,
                      label: context.l10n.address,
                      controller: formBloc.addressController,
                      isCompulsory: true,
                    ),
                    _buildTextField(
                      context,
                      label: context.l10n.room_no,
                      controller: formBloc.roomNoController,
                      isCompulsory: true,
                    ),
                    ResponsiveRC(
                      children: [
                        _buildTextField(
                          context,
                          label: context.l10n.city,
                          controller: formBloc.cityController,
                          isCompulsory: true,
                        ),
                        _buildTextField(
                          context,
                          label: context.l10n.state,
                          controller: formBloc.stateController,
                          isCompulsory: true,
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
                        ),
                        _buildTextField(
                          context,
                          label: context.l10n.country,
                          controller: formBloc.countryController,
                          isCompulsory: true,
                        ),
                      ],
                    ),
                  ]),

                  // Contact Details
                  _buildSection(context, [
                    _buildTextField(
                      context,
                      label: context.l10n.mobile_no,
                      controller: formBloc.mobileNoController,
                      isCompulsory: true,
                      icon: Icons.phone_outlined,
                    ),
                    _buildTextField(
                      context,
                      label: context.l10n.email,
                      controller: formBloc.emailController,
                      isCompulsory: true,
                      icon: Icons.email_outlined,
                    ),
                  ]),

                  16.h,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
