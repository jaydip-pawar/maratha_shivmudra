import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maratha_shivmudra/src/widgets/dropdown/app_searchable_dropdown.dart';
import 'package:maratha_shivmudra/src/widgets/dropdown/geo_address_fields.dart';
import 'package:maratha_shivmudra/core/base/base_widget/modular_state.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/geo_constants.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/main.dart';
import 'package:maratha_shivmudra/src/screens/member_form/bloc/form_bloc.dart';
import 'package:maratha_shivmudra/src/screens/member_form/dialogs/form_submitted_dialog.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/animated_button.dart';
import 'package:maratha_shivmudra/src/widgets/keyboard/marathi_virtual_keyboard.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/text_field.dart';

class MemberFormView extends ModularState<MemberFormBloc> {
  const MemberFormView(super.bloc, {super.key});

  @override
  Widget build(BuildContext context, MemberFormBloc model) {
    final formBloc = model;
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 900;
    final isMobile = width < 600;
    final isMarathi = appLocaleNotifier.value.languageCode == 'mr';

    if (model.stateController.text.isEmpty) {
      model.stateController.text = isMarathi
          ? model.selectedState.value.nameMr
          : model.selectedState.value.nameEn;
    }

    return Form(
      key: formBloc.formKey,
      child: Scaffold(
        backgroundColor: AppColors.darkBg,
        body: Stack(
          children: [
            // Ambient Subtle Glow Background (matching Home Page theme)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.darkBgHeroTop,
                      AppColors.darkBg,
                      AppColors.maroonLowest,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: 0,
              right: 0,
              height: 400,
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topCenter,
                    radius: 0.9,
                    colors: [
                      AppColors.saffron.withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Main Scrollable Form Body
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 24,
                  vertical: 16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 880),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Top Navigation & Action Bar
                        _buildTopBar(context, isMarathi),

                        const SizedBox(height: 20),

                        // Form Hero Header Card
                        _buildFormHeader(context, isMobile, isMarathi),

                        const SizedBox(height: 24),

                        // Form Container Card
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.cardDark,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.gold.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.5),
                                blurRadius: 25,
                                offset: const Offset(0, 8),
                              ),
                              BoxShadow(
                                color:
                                    AppColors.saffron.withValues(alpha: 0.08),
                                blurRadius: 30,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(isMobile ? 18 : 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1. Personal Details Section
                              _buildSectionTitle(
                                icon: Icons.person_rounded,
                                title: isMarathi
                                    ? 'वैयक्तिक माहिती'
                                    : 'Personal Details',
                                subtitle: isMarathi
                                    ? 'नाव आणि जन्मतारीख'
                                    : 'Name & Date of Birth',
                              ),
                              const SizedBox(height: 16),


                              if (isDesktop) ...[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: '${context.l10n.first_name} (English)',
                                        controller:
                                            formBloc.firstNameController,
                                        isCompulsory: true,
                                        icon: Icons.person_outline,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                          CapitalizeFirstLetterFormatter(),
                                        ],
                                        textCapitalization: TextCapitalization.words,
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return context.l10n.please_enter_your_first_name;
                                          }
                                          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
                                            return isMarathi
                                                ? 'फक्त इंग्रजी अक्षरे अनुमत आहेत'
                                                : 'Only English letters are allowed';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: '${context.l10n.middle_name} (English)',
                                        controller:
                                            formBloc.middleNameController,
                                        isCompulsory: true,
                                        icon: Icons.person_outline,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                          CapitalizeFirstLetterFormatter(),
                                        ],
                                        textCapitalization: TextCapitalization.words,
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return isMarathi
                                                ? 'कृपया मधले नाव इंग्रजीत प्रविष्ट करा'
                                                : 'Please enter middle name in English';
                                          }
                                          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
                                            return isMarathi
                                                ? 'फक्त इंग्रजी अक्षरे अनुमत आहेत'
                                                : 'Only English letters are allowed';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: '${context.l10n.last_name} (English)',
                                        controller: formBloc.lastNameController,
                                        isCompulsory: true,
                                        icon: Icons.person_outline,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                          CapitalizeFirstLetterFormatter(),
                                        ],
                                        textCapitalization: TextCapitalization.words,
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return context.l10n
                                                .please_enter_your_last_name;
                                          }
                                          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
                                            return isMarathi
                                                ? 'फक्त इंग्रजी अक्षरे अनुमत आहेत'
                                                : 'Only English letters are allowed';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: isMarathi ? 'पहिले नाव (मराठी)' : 'First Name (Marathi)',
                                        controller:
                                            formBloc.firstNameMrController,
                                        focusNode:
                                            formBloc.firstNameMrFocusNode,
                                        isCompulsory: true,
                                        icon: Icons.badge_outlined,
                                        suffixIcon: Icons.keyboard_alt_outlined,
                                        onSuffixTap: () => MarathiVirtualKeyboard.show(
                                          context,
                                          controller: formBloc.firstNameMrController,
                                          focusNode: formBloc.firstNameMrFocusNode,
                                          title: 'पहिले नाव (मराठी)',
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                          ],
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                        ],
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return isMarathi
                                                ? 'कृपया तुमचे पहिले नाव मराठीत तपासा'
                                                : 'Please enter first name in Marathi';
                                          }
                                          final trimmed = value.trim();
                                          if (RegExp(r'[0-9\u0966-\u096F]').hasMatch(trimmed) ||
                                              !RegExp(r'^[\u0900-\u0963\u0971-\u097F\u200C\u200D]+$').hasMatch(trimmed)) {
                                            return isMarathi
                                                ? 'फक्त मराठी अक्षरे अनुमत आहेत (संख्या किंवा चिन्हे नाहीत)'
                                                : 'Only Marathi letters are allowed (no numbers or symbols)';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: isMarathi ? 'मधले नाव (मराठी)' : 'Middle Name (Marathi)',
                                        controller:
                                            formBloc.middleNameMrController,
                                        focusNode:
                                            formBloc.middleNameMrFocusNode,
                                        isCompulsory: true,
                                        icon: Icons.badge_outlined,
                                        suffixIcon: Icons.keyboard_alt_outlined,
                                        onSuffixTap: () => MarathiVirtualKeyboard.show(
                                          context,
                                          controller: formBloc.middleNameMrController,
                                          focusNode: formBloc.middleNameMrFocusNode,
                                          title: 'मधले नाव (मराठी)',
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                          ],
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                        ],
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return isMarathi
                                                ? 'कृपया मधले नाव मराठीत तपासा'
                                                : 'Please enter middle name in Marathi';
                                          }
                                          final trimmed = value.trim();
                                          if (RegExp(r'[0-9\u0966-\u096F]').hasMatch(trimmed) ||
                                              !RegExp(r'^[\u0900-\u0963\u0971-\u097F\u200C\u200D]+$').hasMatch(trimmed)) {
                                            return isMarathi
                                                ? 'फक्त मराठी अक्षरे अनुमत आहेत (संख्या किंवा चिन्हे नाहीत)'
                                                : 'Only Marathi letters are allowed (no numbers or symbols)';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: isMarathi ? 'आडनाव (मराठी)' : 'Last Name (Marathi)',
                                        controller: formBloc.lastNameMrController,
                                        focusNode: formBloc.lastNameMrFocusNode,
                                        isCompulsory: true,
                                        icon: Icons.badge_outlined,
                                        suffixIcon: Icons.keyboard_alt_outlined,
                                        onSuffixTap: () => MarathiVirtualKeyboard.show(
                                          context,
                                          controller: formBloc.lastNameMrController,
                                          focusNode: formBloc.lastNameMrFocusNode,
                                          title: 'आडनाव (मराठी)',
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                          ],
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                        ],
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return isMarathi
                                                ? 'कृपया तुमचे आडनाव मराठीत तपासा'
                                                : 'Please enter last name in Marathi';
                                          }
                                          final trimmed = value.trim();
                                          if (RegExp(r'[0-9\u0966-\u096F]').hasMatch(trimmed) ||
                                              !RegExp(r'^[\u0900-\u0963\u0971-\u097F\u200C\u200D]+$').hasMatch(trimmed)) {
                                            return isMarathi
                                                ? 'फक्त मराठी अक्षरे अनुमत आहेत (संख्या किंवा चिन्हे नाहीत)'
                                                : 'Only Marathi letters are allowed (no numbers or symbols)';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ] else ...[
                                _buildTextField(
                                  context,
                                  label: '${context.l10n.first_name} (English)',
                                  controller: formBloc.firstNameController,
                                  isCompulsory: true,
                                  icon: Icons.person_outline,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                    CapitalizeFirstLetterFormatter(),
                                  ],
                                  textCapitalization: TextCapitalization.words,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return context.l10n.please_enter_your_first_name;
                                    }
                                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
                                      return isMarathi
                                          ? 'फक्त इंग्रजी अक्षरे अनुमत आहेत'
                                          : 'Only English letters are allowed';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  context,
                                  label: isMarathi ? 'पहिले नाव (मराठी)' : 'First Name (Marathi)',
                                  controller: formBloc.firstNameMrController,
                                  focusNode: formBloc.firstNameMrFocusNode,
                                  isCompulsory: true,
                                  icon: Icons.badge_outlined,
                                  suffixIcon: Icons.keyboard_alt_outlined,
                                  onSuffixTap: () => MarathiVirtualKeyboard.show(
                                    context,
                                    controller: formBloc.firstNameMrController,
                                    focusNode: formBloc.firstNameMrFocusNode,
                                    title: 'पहिले नाव (मराठी)',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                    ],
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return isMarathi
                                          ? 'कृपया पहिले नाव मराठीत तपासा'
                                          : 'Please enter first name in Marathi';
                                    }
                                    final trimmed = value.trim();
                                    if (RegExp(r'[0-9\u0966-\u096F]').hasMatch(trimmed) ||
                                        !RegExp(r'^[\u0900-\u0963\u0971-\u097F\u200C\u200D]+$').hasMatch(trimmed)) {
                                      return isMarathi
                                          ? 'फक्त मराठी अक्षरे अनुमत आहेत (संख्या किंवा चिन्हे नाहीत)'
                                          : 'Only Marathi letters are allowed (no numbers or symbols)';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  context,
                                  label: '${context.l10n.middle_name} (English)',
                                  controller: formBloc.middleNameController,
                                  isCompulsory: true,
                                  icon: Icons.person_outline,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                    CapitalizeFirstLetterFormatter(),
                                  ],
                                  textCapitalization: TextCapitalization.words,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return isMarathi
                                          ? 'कृपया मधले नाव इंग्रजीत प्रविष्ट करा'
                                          : 'Please enter middle name in English';
                                    }
                                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
                                      return isMarathi
                                          ? 'फक्त इंग्रजी अक्षरे अनुमत आहेत'
                                          : 'Only English letters are allowed';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  context,
                                  label: isMarathi ? 'मधले नाव (मराठी)' : 'Middle Name (Marathi)',
                                  controller: formBloc.middleNameMrController,
                                  focusNode: formBloc.middleNameMrFocusNode,
                                  isCompulsory: true,
                                  icon: Icons.badge_outlined,
                                  suffixIcon: Icons.keyboard_alt_outlined,
                                  onSuffixTap: () => MarathiVirtualKeyboard.show(
                                    context,
                                    controller: formBloc.middleNameMrController,
                                    focusNode: formBloc.middleNameMrFocusNode,
                                    title: 'मधले नाव (मराठी)',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                    ],
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return isMarathi
                                          ? 'कृपया मधले नाव मराठीत तपासा'
                                          : 'Please enter middle name in Marathi';
                                    }
                                    final trimmed = value.trim();
                                    if (RegExp(r'[0-9\u0966-\u096F]').hasMatch(trimmed) ||
                                        !RegExp(r'^[\u0900-\u0963\u0971-\u097F\u200C\u200D]+$').hasMatch(trimmed)) {
                                      return isMarathi
                                          ? 'फक्त मराठी अक्षरे अनुमत आहेत (संख्या किंवा चिन्हे नाहीत)'
                                          : 'Only Marathi letters are allowed (no numbers or symbols)';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  context,
                                  label: '${context.l10n.last_name} (English)',
                                  controller: formBloc.lastNameController,
                                  isCompulsory: true,
                                  icon: Icons.person_outline,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                    CapitalizeFirstLetterFormatter(),
                                  ],
                                  textCapitalization: TextCapitalization.words,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return context.l10n
                                          .please_enter_your_last_name;
                                    }
                                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
                                      return isMarathi
                                          ? 'फक्त इंग्रजी अक्षरे अनुमत आहेत'
                                          : 'Only English letters are allowed';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  context,
                                  label: isMarathi ? 'आडनाव (मराठी)' : 'Last Name (Marathi)',
                                  controller: formBloc.lastNameMrController,
                                  focusNode: formBloc.lastNameMrFocusNode,
                                  isCompulsory: true,
                                  icon: Icons.badge_outlined,
                                  suffixIcon: Icons.keyboard_alt_outlined,
                                  onSuffixTap: () => MarathiVirtualKeyboard.show(
                                    context,
                                    controller: formBloc.lastNameMrController,
                                    focusNode: formBloc.lastNameMrFocusNode,
                                    title: 'आडनाव (मराठी)',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                    ],
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return isMarathi
                                          ? 'कृपया आडनाव मराठीत तपासा'
                                          : 'Please enter last name in Marathi';
                                    }
                                    final trimmed = value.trim();
                                    if (RegExp(r'[0-9\u0966-\u096F]').hasMatch(trimmed) ||
                                        !RegExp(r'^[\u0900-\u0963\u0971-\u097F\u200C\u200D]+$').hasMatch(trimmed)) {
                                      return isMarathi
                                          ? 'फक्त मराठी अक्षरे अनुमत आहेत (संख्या किंवा चिन्हे नाहीत)'
                                          : 'Only Marathi letters are allowed (no numbers or symbols)';
                                    }
                                    return null;
                                  },
                                ),
                              ],

                              const SizedBox(height: 12),

                              // Date of Birth
                              _buildTextField(
                                context,
                                label: context.l10n.date_of_birth,
                                controller: formBloc.dateOfBirthController,
                                isCompulsory: true,
                                icon: Icons.calendar_today_rounded,
                                readOnly: true,
                                absorbPointer: true,
                                onTap: () async {
                                  final DateTime? selectedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2000),
                                    firstDate: DateTime(1930),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.dark(
                                            primary: AppColors.saffron,
                                            onPrimary: AppColors.white,
                                            surface: AppColors.cardDark,
                                            onSurface: AppColors.textPrimary,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (selectedDate != null) {
                                    formBloc.dateOfBirthController.text =
                                        selectedDate
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0];
                                  }
                                },
                                errorMessage: context
                                    .l10n.please_enter_your_date_of_birth,
                              ),

                              const SizedBox(height: 28),
                              _buildDivider(),
                              const SizedBox(height: 24),

                              // 2. Address & Residence Section
                              _buildSectionTitle(
                                icon: Icons.location_on_rounded,
                                title: isMarathi
                                    ? 'पत्ता व निवासस्थान'
                                    : 'Address & Residence',
                                subtitle: isMarathi
                                    ? 'राज्य, जिल्हा व तालुका'
                                    : 'State, District & Taluka',
                              ),
                              const SizedBox(height: 16),

                              if (isDesktop)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: '${isMarathi ? "पत्ता" : "Address"} (English)',
                                        hintText: isMarathi
                                            ? 'उदा. Flat 102, Shaniwar Peth'
                                            : 'e.g., Flat 102, Shaniwar Peth',
                                        controller: formBloc.addressController,
                                        isCompulsory: true,
                                        icon: Icons.home_outlined,
                                        errorMessage: isMarathi
                                            ? 'कृपया पत्ता इंग्रजीत प्रविष्ट करा'
                                            : 'Please enter address in English',
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: '${isMarathi ? "पत्ता" : "Address"} (मराठी)',
                                        hintText: isMarathi
                                            ? 'उदा. घर क्र. १२, शनिवार पेठ'
                                            : 'e.g., House No. 12, Shaniwar Peth',
                                        controller: formBloc.addressMrController,
                                        focusNode: formBloc.addressMrFocusNode,
                                        isCompulsory: true,
                                        icon: Icons.home_outlined,
                                        suffixIcon: Icons.keyboard_alt_outlined,
                                        onSuffixTap: () => MarathiVirtualKeyboard.show(
                                          context,
                                          controller: formBloc.addressMrController,
                                          focusNode: formBloc.addressMrFocusNode,
                                          title: isMarathi ? 'पत्ता (मराठी)' : 'Address (Marathi)',
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u097F\u200C\u200D0-9a-zA-Z\s,./#\-_()]')),
                                          ],
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u097F\u200C\u200D0-9a-zA-Z\s,./#\-_()]')),
                                        ],
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                             return isMarathi
                                                 ? 'कृपया पत्ता मराठीत प्रविष्ट करा'
                                                 : 'Please enter address in Marathi';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              else ...[
                                _buildTextField(
                                  context,
                                  label: '${isMarathi ? "पत्ता" : "Address"} (English)',
                                  hintText: isMarathi
                                      ? 'उदा. Flat 102, Shaniwar Peth'
                                      : 'e.g., Flat 102, Shaniwar Peth',
                                  controller: formBloc.addressController,
                                  isCompulsory: true,
                                  icon: Icons.home_outlined,
                                  errorMessage: isMarathi
                                      ? 'कृपया पत्ता इंग्रजीत प्रविष्ट करा'
                                      : 'Please enter address in English',
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  context,
                                  label: '${isMarathi ? "पत्ता" : "Address"} (मराठी)',
                                  hintText: isMarathi
                                      ? 'उदा. घर क्र. १२, शनिवार पेठ'
                                      : 'e.g., House No. 12, Shaniwar Peth',
                                  controller: formBloc.addressMrController,
                                  focusNode: formBloc.addressMrFocusNode,
                                  isCompulsory: true,
                                  icon: Icons.home_outlined,
                                  suffixIcon: Icons.keyboard_alt_outlined,
                                  onSuffixTap: () => MarathiVirtualKeyboard.show(
                                    context,
                                    controller: formBloc.addressMrController,
                                    focusNode: formBloc.addressMrFocusNode,
                                    title: isMarathi ? 'पत्ता (मराठी)' : 'Address (Marathi)',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u097F\u200C\u200D0-9a-zA-Z\s,./#\-_()]')),
                                    ],
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u097F\u200C\u200D0-9a-zA-Z\s,./#\-_()]')),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return isMarathi
                                          ? 'कृपया पत्ता मराठीत प्रविष्ट करा'
                                          : 'Please enter address in Marathi';
                                    }
                                    return null;
                                  },
                                ),
                              ],

                              const SizedBox(height: 12),

                              GeoAddressFields(
                                keyPrefix: 'reg_geo',
                                initialState: formBloc.selectedState.value.code,
                                initialDistrict: formBloc.selectedDistrict.value?.code,
                                initialTaluka: formBloc.selectedTaluka.value?.nameEn,
                                isMarathi: isMarathi,
                                isDesktop: isDesktop,
                                onChanged: (state, district, taluka) {
                                  if (formBloc.selectedState.value.code != state.code) {
                                    formBloc.onStateSelected(state, isMarathi: isMarathi);
                                  } else if (formBloc.selectedDistrict.value?.code != district?.code) {
                                    formBloc.onDistrictSelected(district, isMarathi: isMarathi);
                                  }
                                  formBloc.onTalukaSelected(taluka, isMarathi: isMarathi);
                                },
                              ),

                              const SizedBox(height: 12),

                              if (isDesktop)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: '${isMarathi ? "गाव / वाडी / परिसर" : "Village / Locality"} (English)',
                                        controller: formBloc.villageController,
                                        isCompulsory: false,
                                        icon: Icons.holiday_village_outlined,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                                          CapitalizeFirstLetterFormatter(),
                                        ],
                                        textCapitalization: TextCapitalization.words,
                                        validator: (value) {
                                          final en = value?.trim() ?? '';
                                          final mr = formBloc.villageMrController.text.trim();
                                          if (mr.isNotEmpty && en.isEmpty) {
                                            return isMarathi
                                                ? 'कृपया गाव इंग्रजीत प्रविष्ट करा'
                                                : 'Please enter village in English';
                                          }
                                          if (en.isNotEmpty && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(en)) {
                                            return isMarathi
                                                ? 'फक्त इंग्रजी अक्षरे अनुमत आहेत'
                                                : 'Only English letters are allowed';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: '${isMarathi ? "गाव / वाडी / परिसर" : "Village / Locality"} (मराठी)',
                                        controller: formBloc.villageMrController,
                                        focusNode: formBloc.villageMrFocusNode,
                                        isCompulsory: false,
                                        icon: Icons.holiday_village_outlined,
                                        suffixIcon: Icons.keyboard_alt_outlined,
                                        onSuffixTap: () => MarathiVirtualKeyboard.show(
                                          context,
                                          controller: formBloc.villageMrController,
                                          focusNode: formBloc.villageMrFocusNode,
                                          title: isMarathi ? 'गाव / वाडी / परिसर' : 'Village / Locality',
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D\s]')),
                                          ],
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D\s]')),
                                        ],
                                        validator: (value) {
                                          final mr = value?.trim() ?? '';
                                          final en = formBloc.villageController.text.trim();
                                          if (en.isNotEmpty && mr.isEmpty) {
                                            return isMarathi
                                                ? 'कृपया गाव मराठीत प्रविष्ट करा'
                                                : 'Please enter village in Marathi';
                                          }
                                          if (mr.isNotEmpty &&
                                              (RegExp(r'[0-9\u0966-\u096F]').hasMatch(mr) ||
                                                  !RegExp(r'^[\u0900-\u0963\u0971-\u097F\u200C\u200D\s]+$').hasMatch(mr))) {
                                            return isMarathi
                                                ? 'फक्त मराठी अक्षरे अनुमत आहेत (संख्या नाहीत)'
                                                : 'Only Marathi letters are allowed (no numbers)';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: isMarathi
                                            ? 'पिनकोड (६ अंक)'
                                            : 'Pincode (6 digits)',
                                        controller: formBloc.pincodeController,
                                        isCompulsory: true,
                                        icon: Icons.pin_drop_outlined,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(6),
                                        ],
                                        errorMessage: isMarathi
                                            ? 'कृपया पिनकोड प्रविष्ट करा'
                                            : 'Please enter pincode',
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return isMarathi
                                                ? 'कृपया पिनकोड प्रविष्ट करा'
                                                : 'Please enter pincode';
                                          }
                                          if (value.trim().length != 6) {
                                            return isMarathi
                                                ? 'पिनकोड ६ अंकांचा असावा'
                                                : 'Pincode must be 6 digits';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              else ...[
                                _buildTextField(
                                  context,
                                  label: '${isMarathi ? "गाव / वाडी / परिसर" : "Village / Locality"} (English)',
                                  controller: formBloc.villageController,
                                  isCompulsory: false,
                                  icon: Icons.holiday_village_outlined,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                                    CapitalizeFirstLetterFormatter(),
                                  ],
                                  textCapitalization: TextCapitalization.words,
                                  validator: (value) {
                                    final en = value?.trim() ?? '';
                                    final mr = formBloc.villageMrController.text.trim();
                                    if (mr.isNotEmpty && en.isEmpty) {
                                      return isMarathi
                                          ? 'कृपया गाव इंग्रजीत प्रविष्ट करा'
                                          : 'Please enter village in English';
                                    }
                                    if (en.isNotEmpty && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(en)) {
                                      return isMarathi
                                          ? 'फक्त इंग्रजी अक्षरे अनुमत आहेत'
                                          : 'Only English letters are allowed';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  context,
                                  label: '${isMarathi ? "गाव / वाडी / परिसर" : "Village / Locality"} (मराठी)',
                                  controller: formBloc.villageMrController,
                                  focusNode: formBloc.villageMrFocusNode,
                                  isCompulsory: false,
                                  icon: Icons.holiday_village_outlined,
                                  suffixIcon: Icons.keyboard_alt_outlined,
                                  onSuffixTap: () => MarathiVirtualKeyboard.show(
                                    context,
                                    controller: formBloc.villageMrController,
                                    focusNode: formBloc.villageMrFocusNode,
                                    title: isMarathi ? 'गाव / वाडी / परिसर' : 'Village / Locality',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D\s]')),
                                    ],
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D\s]')),
                                  ],
                                  validator: (value) {
                                    final mr = value?.trim() ?? '';
                                    final en = formBloc.villageController.text.trim();
                                    if (en.isNotEmpty && mr.isEmpty) {
                                      return isMarathi
                                          ? 'कृपया गाव मराठीत प्रविष्ट करा'
                                          : 'Please enter village in Marathi';
                                    }
                                    if (mr.isNotEmpty &&
                                        (RegExp(r'[0-9\u0966-\u096F]').hasMatch(mr) ||
                                            !RegExp(r'^[\u0900-\u0963\u0971-\u097F\u200C\u200D\s]+$').hasMatch(mr))) {
                                      return isMarathi
                                          ? 'फक्त मराठी अक्षरे अनुमत आहेत (संख्या नाहीत)'
                                          : 'Only Marathi letters are allowed (no numbers)';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  context,
                                  label: isMarathi
                                      ? 'पिनकोड (६ अंक)'
                                      : 'Pincode (6 digits)',
                                  controller: formBloc.pincodeController,
                                  isCompulsory: true,
                                  icon: Icons.pin_drop_outlined,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  errorMessage: isMarathi
                                      ? 'कृपया पिनकोड प्रविष्ट करा'
                                      : 'Please enter pincode',
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty) {
                                      return isMarathi
                                          ? 'कृपया पिनकोड प्रविष्ट करा'
                                          : 'Please enter pincode';
                                    }
                                    if (value.trim().length != 6) {
                                      return isMarathi
                                          ? 'पिनकोड ६ अंकांचा असावा'
                                          : 'Pincode must be 6 digits';
                                    }
                                    return null;
                                  },
                                ),
                              ],

                              const SizedBox(height: 28),
                              _buildDivider(),
                              const SizedBox(height: 24),

                              // 3. Contact Details Section
                              _buildSectionTitle(
                                icon: Icons.contact_phone_rounded,
                                title: isMarathi
                                    ? 'संपर्क तपशील'
                                    : 'Contact Details',
                                subtitle: isMarathi
                                    ? 'मोबाईल व ईमेल संपर्क'
                                    : 'Mobile & Email Address',
                              ),
                              const SizedBox(height: 16),

                              if (isDesktop)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: context.l10n.mobile_no,
                                        controller:
                                            formBloc.mobileNoController,
                                        isCompulsory: true,
                                        icon: Icons.phone_rounded,
                                        readOnly: true,
                                        absorbPointer: true,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        errorMessage: context.l10n
                                            .please_enter_your_mobile_number,
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return context.l10n.please_enter_your_mobile_number;
                                          }
                                          final clean = value.replaceAll(RegExp(r'[^0-9]'), '');
                                          if (clean.length != 10) {
                                            return isMarathi
                                                ? 'कृपया वैध १० अंकी मोबाईल नंबर प्रविष्ट करा'
                                                : 'Please enter valid 10-digit mobile number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: context.l10n.email,
                                        controller: formBloc.emailController,
                                        icon: Icons.email_rounded,
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return null;
                                          }
                                          final emailRegex = RegExp(
                                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                          if (!emailRegex.hasMatch(value.trim())) {
                                            return context.l10n
                                                .please_enter_a_valid_email;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              else ...[
                                _buildTextField(
                                  context,
                                  label: context.l10n.mobile_no,
                                  controller: formBloc.mobileNoController,
                                  isCompulsory: true,
                                  icon: Icons.phone_rounded,
                                  readOnly: true,
                                  absorbPointer: true,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  errorMessage: context
                                      .l10n.please_enter_your_mobile_number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return context.l10n.please_enter_your_mobile_number;
                                    }
                                    final clean = value.replaceAll(RegExp(r'[^0-9]'), '');
                                    if (clean.length != 10) {
                                      return isMarathi
                                          ? 'कृपया वैध १० अंकी मोबाईल नंबर प्रविष्ट करा'
                                          : 'Please enter valid 10-digit mobile number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  context,
                                  label: context.l10n.email,
                                  controller: formBloc.emailController,
                                  icon: Icons.email_rounded,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return null;
                                    }
                                    final emailRegex =
                                        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                    if (!emailRegex.hasMatch(value.trim())) {
                                      return context
                                          .l10n.please_enter_a_valid_email;
                                    }
                                    return null;
                                  },
                                ),
                              ],

                              const SizedBox(height: 28),
                              _buildDivider(),
                              const SizedBox(height: 24),

                              // 4. Occupation & Sector Selection
                              _buildSectionTitle(
                                icon: Icons.work_rounded,
                                title: isMarathi
                                    ? 'व्यवसाय / कार्यक्षेत्र'
                                    : 'Occupation & Sector',
                                subtitle: isMarathi
                                    ? 'आपण काय करता ?'
                                    : 'What is your occupation?',
                              ),
                              const SizedBox(height: 16),

                              // Modern Selectable Chips Grid
                              _OccupationSelector(
                                initialValue: formBloc.living,
                                isMarathi: isMarathi,
                                onChanged: (selected) {
                                  formBloc.onLivingChanged(selected);
                                  formBloc.showErrorNotifier.value = false;
                                },
                              ),

                              _buildDynamicOccupationSubForm(
                                context,
                                formBloc,
                                isMarathi,
                                isDesktop,
                              ),

                              ValueListenableBuilder<bool>(
                                valueListenable: formBloc.showErrorNotifier,
                                builder: (context, showError, _) {
                                  if (showError) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.error_outline_rounded,
                                            size: 16,
                                            color: AppColors.errorColor,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            isMarathi
                                                ? 'कृपया आपला व्यवसाय / कार्यक्षेत्र निवडा'
                                                : 'Please select an occupation',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),

                              const SizedBox(height: 36),

                              // Submit Button
                              Center(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 420),
                                  child: AnimatedButton(
                                    text: isMarathi
                                        ? 'नोंदणी पूर्ण करा'
                                        : 'Complete Registration',
                                    onTap: () async {
                                      final isLivingSelected =
                                          formBloc.living.trim().isNotEmpty;
                                      formBloc.showErrorNotifier.value =
                                          !isLivingSelected;

                                      final isFormValid = formBloc
                                              .formKey.currentState
                                              ?.validate() ??
                                          false;
                                      final isModelValid = model.validate();

                                      if (!isLivingSelected ||
                                          !isFormValid ||
                                          !isModelValid) {
                                        return;
                                      }

                                      final isSuccess =
                                          await formBloc.setFormData();
                                      if (isSuccess && context.mounted) {
                                        FormSubmittedDialog.show(context);
                                      } else if (!isSuccess && context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              isMarathi
                                                  ? 'नोंदणी करताना त्रुटी आली. कृपया सर्व माहिती तपासा.'
                                                  : 'Failed to submit form. Please verify all fields.',
                                            ),
                                            backgroundColor:
                                                AppColors.errorColor,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Privacy & Trust Badge
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Center(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        const WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 6),
                                            child: Icon(
                                              Icons.lock_outline_rounded,
                                              size: 14,
                                              color: AppColors.goldLight,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: isMarathi
                                              ? 'आपली माहिती मराठा शिवमुद्रा प्रतिष्ठानकडे सुरक्षित राहील.'
                                              : 'Your details remain secure with Maratha Shivmudra Pratishthan.',
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, bool isMarathi) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back to Home Button
        InkWell(
          onTap: () => context.router.replaceAll([const LandingRoute()]),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.gold.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_back_rounded,
                  size: 16,
                  color: AppColors.goldLight,
                ),
                const SizedBox(width: 6),
                Text(
                  isMarathi ? 'मुख्यपृष्ठ' : 'Home',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldLight,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Language Switcher
        ValueListenableBuilder<Locale>(
          valueListenable: appLocaleNotifier,
          builder: (context, currentLocale, _) {
            final isCurrentMarathi = currentLocale.languageCode == 'mr';
            return InkWell(
              onTap: () {
                appLocaleNotifier.value = isCurrentMarathi
                    ? const Locale('en', '')
                    : const Locale('mr', '');
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.language_rounded,
                      size: 15,
                      color: AppColors.gold,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isCurrentMarathi ? 'English' : 'मराठी',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldLight,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFormHeader(
      BuildContext context, bool isMobile, bool isMarathi) {
    return Column(
      children: [
        // Brand Logo Emblem
        Center(
          child: Image.asset(
            AppAssets.logo,
            width: isMobile ? 56 : 68,
            height: isMobile ? 56 : 68,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Text('🚩', style: TextStyle(fontSize: 32)),
          ),
        ),
        const SizedBox(height: 12),

        // Org Subtitle
        Text(
          context.l10n.maratha_shivmudra,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldLight,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),

        // Main Title
        Text(
          context.l10n.member_form,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: isMobile ? 26 : 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),

        // Welcome Tagline
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            isMarathi
                ? '॥ धर्मो रक्षति रक्षितः ॥ • स्वराज्य, धर्म व समाजसेवेच्या कार्यात सामील व्हा आणि अधिकृत सभासद बना.'
                : '॥ Dharmo Rakshati Rakshitah ॥ • Join the movement of Swarajya, culture, and social welfare as an official member.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.saffron.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.saffron.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Icon(icon, size: 20, color: AppColors.goldLight),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldLight,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStateField(
    BuildContext context,
    MemberFormBloc formBloc,
    bool isMarathi,
  ) {
    return ValueListenableBuilder<StateInfo>(
      valueListenable: formBloc.selectedState,
      builder: (context, state, _) {
        final stateItems = GeoConstants.states.map((s) {
          final label = isMarathi ? s.nameMr : s.nameEn;
          return AppDropdownItem<String>(
            value: s.code,
            label: label,
            searchKey: '${s.nameMr} ${s.nameEn} ${s.code}',
          );
        }).toList();

        return AppSearchableDropdown<String>(
          key: ValueKey('reg_state_${state.code}'),
          value: state.code,
          labelText: isMarathi ? 'राज्य' : 'State',
          searchHint: isMarathi ? 'राज्य शोधा...' : 'Search state...',
          isRequired: true,
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return isMarathi ? 'कृपया राज्य निवडा' : 'Please select state';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.map_outlined, color: AppColors.gold, size: 18),
          items: stateItems,
          onChanged: (code) {
            if (code != null) {
              final found = GeoConstants.states.firstWhere(
                (s) => s.code == code,
                orElse: () => GeoConstants.defaultState,
              );
              formBloc.onStateSelected(found, isMarathi: isMarathi);
            }
          },
        );
      },
    );
  }

  Widget _buildDistrictField(
    BuildContext context,
    MemberFormBloc formBloc,
    bool isMarathi,
  ) {
    return ValueListenableBuilder<StateInfo>(
      valueListenable: formBloc.selectedState,
      builder: (context, state, _) {
        return ValueListenableBuilder<DistrictInfo?>(
          valueListenable: formBloc.selectedDistrict,
          builder: (context, district, _) {
            final districtItems = state.districts.map((d) {
              final label = isMarathi ? d.nameMr : '${d.nameEn} (${d.code})';
              return AppDropdownItem<String>(
                value: d.code,
                label: label,
                searchKey: '${d.nameMr} ${d.nameEn} ${d.code}',
              );
            }).toList();

            return AppSearchableDropdown<String>(
              key: ValueKey('reg_dist_${state.code}_${district?.code}'),
              value: district?.code,
              labelText: isMarathi ? 'जिल्हा' : 'District',
              searchHint: isMarathi ? 'जिल्हा शोधा...' : 'Search district...',
              isRequired: true,
              validator: (val) {
                if (state.districts.isNotEmpty && (val == null || val.trim().isEmpty)) {
                  return isMarathi ? 'कृपया जिल्हा निवडा' : 'Please select district';
                }
                return null;
              },
              prefixIcon: const Icon(Icons.location_city_outlined, color: AppColors.gold, size: 18),
              items: districtItems,
              onChanged: (code) {
                if (code != null) {
                  final found = state.districts.firstWhere(
                    (d) => d.code == code,
                    orElse: () => state.districts.first,
                  );
                  formBloc.onDistrictSelected(found, isMarathi: isMarathi);
                }
              },
            );
          },
        );
      },
    );
  }

  Widget _buildTalukaField(
    BuildContext context,
    MemberFormBloc formBloc,
    bool isMarathi,
  ) {
    return ValueListenableBuilder<DistrictInfo?>(
      valueListenable: formBloc.selectedDistrict,
      builder: (context, district, _) {
        return ValueListenableBuilder<TalukaInfo?>(
          valueListenable: formBloc.selectedTaluka,
          builder: (context, taluka, _) {
            final talukas = district?.talukas ?? [];
            final talukaItems = talukas.map((t) {
              final label = isMarathi ? t.nameMr : t.nameEn;
              return AppDropdownItem<String>(
                value: t.nameEn,
                label: label,
                searchKey: '${t.nameMr} ${t.nameEn}',
              );
            }).toList();

            return AppSearchableDropdown<String>(
              key: ValueKey('reg_tal_${district?.code}_${taluka?.nameEn}'),
              value: taluka?.nameEn,
              labelText: isMarathi ? 'तालुका / शहर' : 'Taluka / City',
              searchHint: isMarathi ? 'तालुका शोधा...' : 'Search taluka...',
              isRequired: true,
              enabled: talukas.isNotEmpty,
              validator: (val) {
                if (talukas.isNotEmpty && (val == null || val.trim().isEmpty)) {
                  return isMarathi ? 'कृपया तालुका निवडा' : 'Please select taluka';
                }
                return null;
              },
              prefixIcon: const Icon(Icons.holiday_village_outlined, color: AppColors.gold, size: 18),
              items: talukaItems,
              onChanged: (nameEn) {
                if (nameEn != null && talukas.isNotEmpty) {
                  final found = talukas.firstWhere(
                    (t) => t.nameEn == nameEn,
                    orElse: () => talukas.first,
                  );
                  formBloc.onTalukaSelected(found, isMarathi: isMarathi);
                }
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDynamicOccupationSubForm(
    BuildContext context,
    MemberFormBloc formBloc,
    bool isMarathi,
    bool isDesktop,
  ) {
    return ValueListenableBuilder<String>(
      valueListenable: formBloc.livingNotifier,
      builder: (context, living, _) {
        if (living.trim().isEmpty) return const SizedBox.shrink();

        final l = living.toLowerCase();
        final isUnemployed = l == 'बेरोजगार' ||
            l == 'unemployed' ||
            l == 'नोकरी शोधत आहे' ||
            l == 'job-seeker';
        final isSelfEmployed = l == 'स्वयंरोजगार' || l == 'self-employed';
        final isJob = (l == 'नोकरी' || l == 'employed') || isSelfEmployed;
        final isBusiness = (l == 'व्यवसाय' || l == 'business') || isSelfEmployed;
        final isStudent = l == 'विद्यार्थी' || l == 'student' || l.contains('शिक्षण');
        final isFarmer = l == 'शेती' || l == 'farmer' || l.contains('शेतकरी');

        if (!isJob && !isBusiness && !isStudent && !isFarmer && !isUnemployed) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 18),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.35), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: AppColors.saffron.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. JOB / EMPLOYED
              if (isJob) ...[
                Row(
                  children: [
                    Icon(isSelfEmployed ? Icons.business_center_rounded : Icons.work_rounded, color: AppColors.goldLight, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      isSelfEmployed
                          ? (isMarathi ? 'स्वयंरोजगार तपशील (किमान १ माहिती आवश्यक)' : 'Self-Employment Details (At least 1 required)')
                          : (isMarathi ? 'नोकरीचा सविस्तर तपशील' : 'Job / Employment Details'),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.goldLight),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: isMarathi ? 'पद / हुद्दा' : 'Designation / Role',
                          hintText: isMarathi
                              ? 'उदा. व्यवस्थापक, पर्यवेक्षक'
                              : 'e.g., Manager, Supervisor',
                          controller: formBloc.jobDesignationController,
                          isCompulsory: !isSelfEmployed,
                          icon: Icons.badge_outlined,
                          validator: (val) {
                            if (isSelfEmployed) {
                              final hasAny = formBloc.jobDesignationController.text.trim().isNotEmpty ||
                                  formBloc.jobCompanyController.text.trim().isNotEmpty ||
                                  formBloc.businessTypeController.text.trim().isNotEmpty;
                              if (!hasAny) {
                                return isMarathi
                                    ? 'पद, कंपनी किंवा व्यवसाय यांपैकी किमान १ माहिती आवश्यक आहे'
                                    : 'At least 1 field must be filled';
                              }
                              return null;
                            }
                            if (val == null || val.trim().isEmpty) {
                              return isMarathi
                                  ? 'कृपया पद / हुद्दा प्रविष्ट करा'
                                  : 'Please enter designation / role';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: isMarathi ? 'कंपनी / आस्थापना / विभाग' : 'Company / Employer Name',
                          controller: formBloc.jobCompanyController,
                          isCompulsory: !isSelfEmployed,
                          icon: Icons.business_outlined,
                          validator: !isSelfEmployed
                              ? (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return isMarathi
                                        ? 'कृपया कंपनी / आस्थापना नाव प्रविष्ट करा'
                                        : 'Please enter company / employer name';
                                  }
                                  return null;
                                }
                              : null,
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildTextField(
                    context,
                    label: isMarathi ? 'पद / हुद्दा' : 'Designation / Role',
                    hintText: isMarathi
                        ? 'उदा. व्यवस्थापक, पर्यवेक्षक'
                        : 'e.g., Manager, Supervisor',
                    controller: formBloc.jobDesignationController,
                    isCompulsory: !isSelfEmployed,
                    icon: Icons.badge_outlined,
                    validator: (val) {
                      if (isSelfEmployed) {
                        final hasAny = formBloc.jobDesignationController.text.trim().isNotEmpty ||
                            formBloc.jobCompanyController.text.trim().isNotEmpty ||
                            formBloc.businessTypeController.text.trim().isNotEmpty;
                        if (!hasAny) {
                          return isMarathi
                              ? 'पद, कंपनी किंवा व्यवसाय यांपैकी किमान १ माहिती आवश्यक आहे'
                              : 'At least 1 field must be filled';
                        }
                        return null;
                      }
                      if (val == null || val.trim().isEmpty) {
                        return isMarathi
                            ? 'कृपया पद / हुद्दा प्रविष्ट करा'
                            : 'Please enter designation / role';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    context,
                    label: isMarathi ? 'कंपनी / आस्थापना / विभाग' : 'Company / Employer Name',
                    controller: formBloc.jobCompanyController,
                    isCompulsory: !isSelfEmployed,
                    icon: Icons.business_outlined,
                    validator: !isSelfEmployed
                        ? (val) {
                            if (val == null || val.trim().isEmpty) {
                              return isMarathi
                                  ? 'कृपया कंपनी / आस्थापना नाव प्रविष्ट करा'
                                  : 'Please enter company / employer name';
                            }
                            return null;
                          }
                        : null,
                  ),
                ],
              ],

              // Gap & Divider between Job and Business when Self-Employed
              if (isJob && isBusiness) ...[
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 20),
              ],

              // 2. BUSINESS / SELF-EMPLOYED
              if (isBusiness) ...[
                Row(
                  children: [
                    const Icon(Icons.storefront_rounded, color: AppColors.goldLight, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      isSelfEmployed
                          ? (isMarathi ? 'व्यवसायाचे स्वरूप / प्रकार' : 'Nature / Type of Business')
                          : (isMarathi ? 'व्यवसायाचे स्वरूप व प्रकार' : 'Business Details'),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.goldLight),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  context,
                  label: isMarathi
                      ? 'व्यवसायाचे स्वरूप / प्रकार'
                      : 'Nature / Type of Business',
                  hintText: isMarathi
                      ? 'उदा. किरकोळ विक्री, उत्पादन, आयटी, हॉटेल, सेवा'
                      : 'e.g., Retail, Manufacturing, IT, Service',
                  controller: formBloc.businessTypeController,
                  isCompulsory: !isSelfEmployed,
                  icon: Icons.business_center_outlined,
                  validator: !isSelfEmployed
                      ? (val) {
                          if (val == null || val.trim().isEmpty) {
                            return isMarathi
                                ? 'कृपया व्यवसायाचे स्वरूप / प्रकार प्रविष्ट करा'
                                : 'Please enter nature / type of business';
                          }
                          return null;
                        }
                      : null,
                ),
              ],

              // 3. STUDENT / EDUCATION
              if (isStudent) ...[
                Row(
                  children: [
                    const Icon(Icons.school_rounded, color: AppColors.goldLight, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      isMarathi ? 'शैक्षणिक पात्रता / शिक्षण' : 'Educational Qualification',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.goldLight),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<String?>(
                  valueListenable: formBloc.selectedEducation,
                  builder: (context, edu, _) {
                    final eduOptions = isMarathi
                        ? const [
                            '१०वी (SSC)',
                            '१२वी (HSC)',
                            'पदविका (Diploma)',
                            'पदवी (Graduate - B.A/B.Com/B.Sc/B.E/इ.)',
                            'पदव्युत्तर (Post Graduate - M.A/M.Com/M.Sc/MBA/इ.)',
                            'डॉक्टरेट (Ph.D)',
                            'वैद्यकीय (Medical - MBBS/BAMS/BHMS)',
                            'विधी / कायदा (Law - LLB/LLM)',
                            'सीए / सीएस / सीएमए (CA/CS/CMA)',
                            'आयटीआय / व्होकेशनल (ITI/Vocational)',
                            'इतर (Other)',
                          ]
                        : const [
                            '10th (SSC)',
                            '12th (HSC)',
                            'Diploma',
                            'Graduate (B.A/B.Com/B.Sc/B.E/etc.)',
                            'Post Graduate (M.A/M.Com/M.Sc/MBA/etc.)',
                            'Doctorate (Ph.D)',
                            'Medical (MBBS/BAMS/BHMS)',
                            'Law (LLB/LLM)',
                            'CA / CS / CMA',
                            'ITI / Vocational',
                            'Other',
                          ];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSearchableDropdown<String>(
                          key: ValueKey('reg_edu_${edu ?? ""}'),
                          value: edu,
                          labelText: isMarathi ? 'सर्वोच्च शिक्षण निवडा' : 'Select Qualification',
                          searchHint: isMarathi ? 'शिक्षण शोधा...' : 'Search qualification...',
                          isRequired: true,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return isMarathi ? 'कृपया सर्वोच्च शिक्षण निवडा' : 'Please select qualification';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.school_outlined, color: AppColors.gold, size: 18),
                          items: eduOptions.map((e) => AppDropdownItem<String>(value: e, label: e, searchKey: e)).toList(),
                          onChanged: (val) {
                            formBloc.selectedEducation.value = val;
                          },
                        ),
                        if (edu != null && (edu.startsWith('इतर') || edu.startsWith('Other'))) ...[
                          const SizedBox(height: 12),
                          _buildTextField(
                            context,
                            label: isMarathi ? 'आपले शिक्षण लिहा' : 'Specify Education',
                            hintText: isMarathi ? 'उदा. B.Tech, Ph.D, इत्यादी' : 'e.g., B.Tech, Ph.D, etc.',
                            controller: formBloc.educationOtherController,
                            isCompulsory: true,
                            icon: Icons.edit_note_rounded,
                            errorMessage: isMarathi ? 'कृपया शिक्षणाचा तपशील प्रविष्ट करा' : 'Please specify your education',
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],

              // 4. FARMER / CROPS PRODUCED
              if (isFarmer) ...[
                Row(
                  children: [
                    const Icon(Icons.grass_rounded, color: AppColors.goldLight, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      isMarathi ? 'शेतीत पिकवत असलेली पिके' : 'Crops Produced',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.goldLight),
                    ),
                    const SizedBox(width: 4),
                    const Text('*', style: TextStyle(color: AppColors.errorColor, fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  isMarathi
                      ? 'आपण घेत असलेली पिके लिहा किंवा खालील बटणावर क्लिक करून जोडा:'
                      : 'Enter or tap crops you cultivate:',
                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                ),
                const SizedBox(height: 10),

                // Multi-enter field with Add Button
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: formBloc.cropInputController,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: isMarathi ? 'पिकाचे नाव लिहा (उदा. हळद, आंबा)...' : 'Type crop name...',
                          hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                          filled: true,
                          fillColor: AppColors.darkBgHeroTop,
                          prefixIcon: const Icon(Icons.eco_outlined, color: AppColors.gold, size: 18),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.darkBorder)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.darkBorder)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.gold, width: 1.2)),
                        ),
                        onFieldSubmitted: (val) => formBloc.addCrop(val),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => formBloc.addCrop(formBloc.cropInputController.text),
                      icon: const Icon(Icons.add_rounded, size: 18, color: Colors.white),
                      label: Text(isMarathi ? 'जोडा' : 'Add', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.saffron,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Quick Suggestion Chips
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    'ऊस (Sugarcane)',
                    'कांदा (Onion)',
                    'सोयाबीन (Soybean)',
                    'कापूस (Cotton)',
                    'द्राक्षे (Grapes)',
                    'डाळिंब (Pomegranate)',
                    'गहू (Wheat)',
                    'बाजरी (Bajra)',
                    'मका (Maize)',
                    'हळद (Turmeric)',
                  ].map((sug) {
                    final cropName = sug.split(' ').first;
                    return ActionChip(
                      avatar: const Icon(Icons.add, size: 12, color: AppColors.goldLight),
                      label: Text(sug, style: const TextStyle(fontSize: 10, color: AppColors.goldLight)),
                      backgroundColor: AppColors.gold.withValues(alpha: 0.1),
                      side: BorderSide(color: AppColors.gold.withValues(alpha: 0.3)),
                      visualDensity: VisualDensity.compact,
                      onPressed: () => formBloc.addCrop(cropName),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),

                // Added Crops Cards / Dismissible Chips
                ValueListenableBuilder<List<String>>(
                  valueListenable: formBloc.cropsList,
                  builder: (context, crops, _) {
                    if (crops.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.darkBgHeroTop,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.darkBorder),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline, size: 14, color: AppColors.textMuted),
                            const SizedBox(width: 8),
                            Text(
                              isMarathi ? 'अद्याप कोणतेही पीक जोडलेले नाही.' : 'No crops added yet.',
                              style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                            ),
                          ],
                        ),
                      );
                    }

                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: crops.map((crop) {
                        return Chip(
                          backgroundColor: AppColors.saffron.withValues(alpha: 0.2),
                          side: const BorderSide(color: AppColors.saffron, width: 1),
                          avatar: const Icon(Icons.check_circle_rounded, size: 14, color: AppColors.goldLight),
                          label: Text(crop, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                          deleteIcon: const Icon(Icons.cancel_rounded, size: 14, color: Colors.redAccent),
                          onDeleted: () => formBloc.removeCrop(crop),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],

              // 5. UNEMPLOYED / CAREER ASSISTANCE
              if (isUnemployed) ...[
                Row(
                  children: [
                    const Icon(Icons.badge_rounded, color: AppColors.goldLight, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      isMarathi ? 'रोजगार व करिअर सहाय्य माहिती' : 'Career & Employment Assistance',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.goldLight),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  isMarathi
                      ? 'मराठा शिवमुद्रा रोजगार सेलद्वारे योग्य नोकरीच्या संधींसाठी खालील माहिती भरा:'
                      : 'Fill details for job placement and career assistance:',
                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                ),
                const SizedBox(height: 12),

                // Highest Qualification Dropdown
                ValueListenableBuilder<String?>(
                  valueListenable: formBloc.unemployedEducation,
                  builder: (context, edu, _) {
                    final eduList = isMarathi
                        ? ['१०वी', '१२वी', 'पदविका (Diploma)', 'पदवी (Graduate)', 'पदव्युत्तर (Post Graduate)', 'आयटीआय (ITI)', 'इतर']
                        : ['10th', '12th', 'Diploma', 'Graduate', 'Post Graduate', 'ITI', 'Other'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSearchableDropdown<String>(
                          key: ValueKey('reg_unemp_edu_${edu ?? ""}'),
                          value: edu,
                          labelText: isMarathi ? 'सर्वोच्च शिक्षण पात्रता' : 'Highest Qualification',
                          searchHint: isMarathi ? 'शिक्षण निवडा...' : 'Select education...',
                          isRequired: true,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return isMarathi ? 'कृपया सर्वोच्च शिक्षण पात्रता निवडा' : 'Please select highest qualification';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.school_outlined, color: AppColors.gold, size: 18),
                          items: eduList.map((e) => AppDropdownItem<String>(value: e, label: e, searchKey: e)).toList(),
                          onChanged: (val) => formBloc.unemployedEducation.value = val,
                        ),
                        if (edu != null && (edu.startsWith('इतर') || edu.startsWith('Other'))) ...[
                          const SizedBox(height: 12),
                          _buildTextField(
                            context,
                            label: isMarathi ? 'आपले शिक्षण लिहा' : 'Specify Education',
                            hintText: isMarathi ? 'उदा. B.Tech, Ph.D, इत्यादी' : 'e.g., B.Tech, Ph.D, etc.',
                            controller: formBloc.unemployedEducationOtherController,
                            isCompulsory: true,
                            icon: Icons.edit_note_rounded,
                            errorMessage: isMarathi ? 'कृपया शिक्षणाचा तपशील प्रविष्ट करा' : 'Please specify your education',
                          ),
                        ],
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),

                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: isMarathi
                              ? 'कोणत्या क्षेत्रात काम हवे आहे?'
                              : 'Preferred Job Sector',
                          hintText: isMarathi
                              ? 'उदा. आयटी, सुरक्षा, ड्रायव्हिंग, कार्यालय'
                              : 'e.g., IT, Security, Driver, Admin',
                          controller: formBloc.unemployedPreferredSectorController,
                          isCompulsory: true,
                          icon: Icons.work_outline_rounded,
                          errorMessage: isMarathi
                              ? 'कृपया पसंतीचे कार्यक्षेत्र प्रविष्ट करा'
                              : 'Please enter preferred job sector',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: isMarathi
                              ? 'विशेष कौशल्ये / परवाना'
                              : 'Skills / Licenses',
                          hintText: isMarathi
                              ? 'उदा. MS-CIT, Tally, ड्रायव्हिंग'
                              : 'e.g., MS-CIT, Tally, Driving',
                          controller: formBloc.unemployedSkillsController,
                          icon: Icons.star_outline_rounded,
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildTextField(
                    context,
                    label: isMarathi
                        ? 'कोणत्या क्षेत्रात काम हवे आहे?'
                        : 'Preferred Job Sector',
                    hintText: isMarathi
                        ? 'उदा. आयटी, सुरक्षा, ड्रायव्हिंग, कार्यालय'
                        : 'e.g., IT, Security, Driver, Admin',
                    controller: formBloc.unemployedPreferredSectorController,
                    isCompulsory: true,
                    icon: Icons.work_outline_rounded,
                    errorMessage: isMarathi
                        ? 'कृपया पसंतीचे कार्यक्षेत्र प्रविष्ट करा'
                        : 'Please enter preferred job sector',
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    context,
                    label: isMarathi
                        ? 'विशेष कौशल्ये / परवाना'
                        : 'Skills / Licenses',
                    hintText: isMarathi
                        ? 'उदा. MS-CIT, Tally, ड्रायव्हिंग'
                        : 'e.g., MS-CIT, Tally, Driving',
                    controller: formBloc.unemployedSkillsController,
                    icon: Icons.star_outline_rounded,
                  ),
                ],
                const SizedBox(height: 14),

                // Willing to relocate toggle
                if (isDesktop)
                  Row(
                    children: [
                      Text(
                        isMarathi ? 'इतर शहरात काम करण्याची तयारी:' : 'Willing to relocate:',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 12),
                      ValueListenableBuilder<bool>(
                        valueListenable: formBloc.willingToRelocate,
                        builder: (context, willing, _) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ChoiceChip(
                                label: Text(isMarathi ? 'होय (तयार आहे)' : 'Yes'),
                                selected: willing,
                                selectedColor: AppColors.saffron,
                                backgroundColor: AppColors.darkBgHeroTop,
                                labelStyle: TextStyle(color: willing ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                                onSelected: (_) => formBloc.willingToRelocate.value = true,
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(isMarathi ? 'नाही (केवळ स्थानिक)' : 'No (Local only)'),
                                selected: !willing,
                                selectedColor: AppColors.saffron,
                                backgroundColor: AppColors.darkBgHeroTop,
                                labelStyle: TextStyle(color: !willing ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                                onSelected: (_) => formBloc.willingToRelocate.value = false,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isMarathi ? 'इतर शहरात काम करण्याची तयारी:' : 'Willing to relocate:',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ValueListenableBuilder<bool>(
                        valueListenable: formBloc.willingToRelocate,
                        builder: (context, willing, _) {
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ChoiceChip(
                                label: Text(isMarathi ? 'होय (तयार आहे)' : 'Yes'),
                                selected: willing,
                                selectedColor: AppColors.saffron,
                                backgroundColor: AppColors.darkBgHeroTop,
                                labelStyle: TextStyle(color: willing ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                                onSelected: (_) => formBloc.willingToRelocate.value = true,
                              ),
                              ChoiceChip(
                                label: Text(isMarathi ? 'नाही (केवळ स्थानिक)' : 'No (Local only)'),
                                selected: !willing,
                                selectedColor: AppColors.saffron,
                                backgroundColor: AppColors.darkBgHeroTop,
                                labelStyle: TextStyle(color: !willing ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                                onSelected: (_) => formBloc.willingToRelocate.value = false,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    FocusNode? focusNode,
    bool isCompulsory = false,
    IconData? icon,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
    VoidCallback? onTap,
    bool readOnly = false,
    bool absorbPointer = false,
    String? Function(String?)? validator,
    String? errorMessage,
    String? hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    ValueChanged<String>? onChanged,
  }) {
    return CustomTextField(
      labelText: label,
      hintText: hintText,
      controller: controller,
      focusNode: focusNode,
      isCompulsory: isCompulsory,
      prefixIconData: icon,
      suffixIconData: suffixIcon,
      onSuffixTap: onSuffixTap,
      onTap: onTap,
      readOnly: readOnly,
      absorbPointer: absorbPointer,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
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

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.gold.withValues(alpha: 0.25),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

/// Modern interactive occupation selector chips
class _OccupationSelector extends StatefulWidget {
  final String initialValue;
  final bool isMarathi;
  final ValueChanged<String> onChanged;

  const _OccupationSelector({
    required this.initialValue,
    required this.isMarathi,
    required this.onChanged,
  });

  @override
  State<_OccupationSelector> createState() => _OccupationSelectorState();
}

class _OccupationSelectorState extends State<_OccupationSelector> {
  late String _selected;

  List<_OccupationOption> get _options => widget.isMarathi
      ? const [
          _OccupationOption(label: 'विद्यार्थी', icon: '🎓'),
          _OccupationOption(label: 'नोकरी', icon: '💼'),
          _OccupationOption(label: 'व्यवसाय', icon: '🏢'),
          _OccupationOption(label: 'स्वयंरोजगार', icon: '⚡'),
          _OccupationOption(label: 'शेती', icon: '🌾'),
          _OccupationOption(label: 'बेरोजगार', icon: '🔍'),
          _OccupationOption(label: 'निवृत्त', icon: '🎖️'),
          _OccupationOption(label: 'गृहपालक', icon: '🏡'),
          _OccupationOption(label: 'नोकरी शोधत आहे', icon: '🎯'),
        ]
      : const [
          _OccupationOption(label: 'Student', icon: '🎓'),
          _OccupationOption(label: 'Employed', icon: '💼'),
          _OccupationOption(label: 'Business', icon: '🏢'),
          _OccupationOption(label: 'Self-employed', icon: '⚡'),
          _OccupationOption(label: 'Farmer', icon: '🌾'),
          _OccupationOption(label: 'Unemployed', icon: '🔍'),
          _OccupationOption(label: 'Retired', icon: '🎖️'),
          _OccupationOption(label: 'Homemaker', icon: '🏡'),
          _OccupationOption(label: 'Job-seeker', icon: '🎯'),
        ];

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _options.map((opt) {
        final isSelected = _selected == opt.label;
        return InkWell(
          onTap: () {
            setState(() => _selected = opt.label);
            widget.onChanged(opt.label);
          },
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.saffron.withValues(alpha: 0.25)
                  : AppColors.darkSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.gold
                    : AppColors.gold.withValues(alpha: 0.2),
                width: isSelected ? 1.8 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.saffron.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(opt.icon, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(
                  opt.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? AppColors.goldLight
                        : AppColors.textPrimary,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 16,
                    color: AppColors.gold,
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _OccupationOption {
  final String label;
  final String icon;

  const _OccupationOption({
    required this.label,
    required this.icon,
  });
}
