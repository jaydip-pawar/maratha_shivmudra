import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/base/base_widget/modular_state.dart';
import 'package:maratha_shivmudra/core/constants/state_constant.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/member_form/bloc/form_bloc.dart';
import 'package:maratha_shivmudra/src/screens/member_form/dialogs/form_submitted_dialog.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/animated_button.dart';
import 'package:maratha_shivmudra/src/widgets/customRadioGroup.dart';
import 'package:maratha_shivmudra/src/widgets/responsive_rc.dart';
import 'package:maratha_shivmudra/src/widgets/section.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/text_field.dart';

class MemberFormView extends ModularState<MemberFormBloc> {
  MemberFormView(super.bloc, {super.key});

  final List<SelectedListItem<String>> districts = [];

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
    if (districts.isEmpty) {
      final districtList =
          StateConstant.locationHierarchy(context)[context.l10n.maharashtra]!
              .keys
              .toList();

      districts.addAll(
        districtList
            .map(
              (String district) => SelectedListItem<String>(
                data: district,
              ),
            )
            .toList(),
      );
    }
    if (model.stateController.text.isEmpty) {
      model.stateController.text = context.l10n.maharashtra;
      // model.countryController.text = context.l10n.india;
    }

    return Form(
      key: formBloc.formKey,
      child: Scaffold(
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
                      ResponsiveRC(
                        children: [
                          _buildTextField(
                            context,
                            label: context.l10n.state,
                            controller: formBloc.stateController,
                            isCompulsory: true,
                            errorMessage: context.l10n.please_enter_your_state,
                          ),
                          ValueListenableBuilder(
                            valueListenable: formBloc.showDropDown,
                            builder: (context, value, _) {
                              return _buildTextField(
                                context,
                                label: context.l10n.district,
                                controller: formBloc.districtController,
                                isCompulsory: true,
                                readOnly: value,
                                absorbPointer: value,
                                errorMessage:
                                    context.l10n.please_enter_your_district,
                                onTap: value
                                    ? () {
                                        DropDownState<String>(
                                          dropDown: DropDown<String>(
                                            data: districts,
                                            onSelected: (selectedItems) {
                                              model.districtController.text =
                                                  selectedItems.first.data;
                                            },
                                          ),
                                        ).showModal(context);
                                      }
                                    : null,
                              );
                            },
                          ),
                          _buildTextField(
                            context,
                            label: context.l10n.sub_district,
                            controller: formBloc.subDistrictController,
                            isCompulsory: true,
                            errorMessage:
                                context.l10n.please_enter_your_sub_district,
                          ),
                        ],
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
                            label: context.l10n.pincode,
                            controller: formBloc.pincodeController,
                            isCompulsory: true,
                            errorMessage:
                                context.l10n.please_enter_your_pincode,
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
                        icon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) return null;
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return context.l10n.please_enter_a_valid_email;
                          }
                          return null;
                        },
                      ),
                    ]),

                    // Work Details
                    _buildSection(context, [
                      Row(
                        spacing: 2,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'आपण काय करता ?',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.fieldTextColor,
                            ),
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.errorColor,
                            ),
                          ),
                        ],
                      ),
                      8.h,
                      CustomRadioGroup(
                        alignment: Axis.vertical,
                        labels: [
                          context.l10n.student,
                          context.l10n.employed,
                          context.l10n.business,
                          context.l10n.self_employed,
                          context.l10n.unemployed,
                          context.l10n.retired,
                          context.l10n.homemaker,
                          context.l10n.job_seeker,
                          context.l10n.farmer,
                        ],
                        onChanged: (val) => formBloc.living = val,
                      ),
                      ValueListenableBuilder(
                        valueListenable: formBloc.showErrorNotifier,
                        builder: (context, showError, _) {
                          if (showError)
                            return Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                context.l10n.select_an_option_to_continue,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.errorColor,
                                ),
                              ),
                            );
                          else
                            return SizedBox.shrink();
                        },
                      ),
                    ]),
                    16.h,
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: AnimatedButton(
                        text: context.l10n.submit,
                        onTap: () async {
                          if (formBloc.living.isEmpty) {
                            formBloc.showErrorNotifier.value = true;
                          } else {
                            formBloc.showErrorNotifier.value = false;
                          }
                          formBloc.formKey.currentState!.validate();
                          if (model.validate()) {
                            final isSuccess = await formBloc.setFormData();
                            if (isSuccess) {
                              FormSubmittedDialog.show(context);
                            }
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
