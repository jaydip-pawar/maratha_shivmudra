import 'package:auto_route/auto_route.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/base/base_widget/modular_state.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/state_constant.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/main.dart';
import 'package:maratha_shivmudra/src/screens/member_form/bloc/form_bloc.dart';
import 'package:maratha_shivmudra/src/screens/member_form/dialogs/form_submitted_dialog.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/animated_button.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/text_field.dart';

class MemberFormView extends ModularState<MemberFormBloc> {
  MemberFormView(super.bloc, {super.key});

  final List<SelectedListItem<String>> districts = [];

  @override
  Widget build(BuildContext context, MemberFormBloc model) {
    final formBloc = model;
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 900;
    final isMobile = width < 600;
    final isMarathi = appLocaleNotifier.value.languageCode == 'mr';

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

                              if (isDesktop)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: context.l10n.first_name,
                                        controller:
                                            formBloc.firstNameController,
                                        isCompulsory: true,
                                        icon: Icons.person_outline,
                                        errorMessage: context.l10n
                                            .please_enter_your_first_name,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: context.l10n.middle_name,
                                        controller:
                                            formBloc.middleNameController,
                                        icon: Icons.person_outline,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: context.l10n.last_name,
                                        controller: formBloc.lastNameController,
                                        isCompulsory: true,
                                        icon: Icons.person_outline,
                                        errorMessage: context.l10n
                                            .please_enter_your_last_name,
                                      ),
                                    ),
                                  ],
                                )
                              else ...[
                                _buildTextField(
                                  context,
                                  label: context.l10n.first_name,
                                  controller: formBloc.firstNameController,
                                  isCompulsory: true,
                                  icon: Icons.person_outline,
                                  errorMessage: context
                                      .l10n.please_enter_your_first_name,
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  context,
                                  label: context.l10n.middle_name,
                                  controller: formBloc.middleNameController,
                                  icon: Icons.person_outline,
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  context,
                                  label: context.l10n.last_name,
                                  controller: formBloc.lastNameController,
                                  isCompulsory: true,
                                  icon: Icons.person_outline,
                                  errorMessage:
                                      context.l10n.please_enter_your_last_name,
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

                              _buildTextField(
                                context,
                                label: context.l10n.address,
                                controller: formBloc.addressController,
                                isCompulsory: true,
                                icon: Icons.home_outlined,
                                errorMessage:
                                    context.l10n.please_enter_your_address,
                              ),

                              const SizedBox(height: 12),

                              if (isDesktop)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: context.l10n.state,
                                        controller: formBloc.stateController,
                                        isCompulsory: true,
                                        icon: Icons.map_outlined,
                                        errorMessage: context
                                            .l10n.please_enter_your_state,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildDistrictField(
                                          context, formBloc),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: context.l10n.sub_district,
                                        controller:
                                            formBloc.subDistrictController,
                                        isCompulsory: true,
                                        icon: Icons.holiday_village_outlined,
                                        errorMessage: context.l10n
                                            .please_enter_your_sub_district,
                                      ),
                                    ),
                                  ],
                                )
                              else ...[
                                _buildTextField(
                                  context,
                                  label: context.l10n.state,
                                  controller: formBloc.stateController,
                                  isCompulsory: true,
                                  icon: Icons.map_outlined,
                                  errorMessage:
                                      context.l10n.please_enter_your_state,
                                ),
                                const SizedBox(height: 12),
                                _buildDistrictField(context, formBloc),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  context,
                                  label: context.l10n.sub_district,
                                  controller: formBloc.subDistrictController,
                                  isCompulsory: true,
                                  icon: Icons.holiday_village_outlined,
                                  errorMessage: context
                                      .l10n.please_enter_your_sub_district,
                                ),
                              ],

                              const SizedBox(height: 12),

                              if (isDesktop)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: context.l10n.city,
                                        controller: formBloc.cityController,
                                        isCompulsory: true,
                                        icon: Icons.location_city_rounded,
                                        errorMessage: context
                                            .l10n.please_enter_your_city,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: context.l10n.pincode,
                                        controller: formBloc.pincodeController,
                                        isCompulsory: true,
                                        icon: Icons.pin_drop_outlined,
                                        errorMessage: context
                                            .l10n.please_enter_your_pincode,
                                      ),
                                    ),
                                  ],
                                )
                              else ...[
                                _buildTextField(
                                  context,
                                  label: context.l10n.city,
                                  controller: formBloc.cityController,
                                  isCompulsory: true,
                                  icon: Icons.location_city_rounded,
                                  errorMessage:
                                      context.l10n.please_enter_your_city,
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  context,
                                  label: context.l10n.pincode,
                                  controller: formBloc.pincodeController,
                                  isCompulsory: true,
                                  icon: Icons.pin_drop_outlined,
                                  errorMessage:
                                      context.l10n.please_enter_your_pincode,
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
                                        errorMessage: context.l10n
                                            .please_enter_your_mobile_number,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildTextField(
                                        context,
                                        label: context.l10n.email,
                                        controller: formBloc.emailController,
                                        icon: Icons.email_rounded,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return null;
                                          }
                                          final emailRegex = RegExp(
                                              r'^[^@]+@[^@]+\.[^@]+');
                                          if (!emailRegex.hasMatch(value)) {
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
                                  errorMessage: context
                                      .l10n.please_enter_your_mobile_number,
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  context,
                                  label: context.l10n.email,
                                  controller: formBloc.emailController,
                                  icon: Icons.email_rounded,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }
                                    final emailRegex =
                                        RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                    if (!emailRegex.hasMatch(value)) {
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
                                  formBloc.living = selected;
                                  formBloc.showErrorNotifier.value = false;
                                },
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
                              Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.lock_outline_rounded,
                                      size: 14,
                                      color: AppColors.goldLight,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      isMarathi
                                          ? 'आपली माहिती मराठा शिवमुद्रा प्रतिष्ठानकडे सुरक्षित राहील.'
                                          : 'Your details remain secure with Maratha Shivmudra Pratishthan.',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
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

  Widget _buildDistrictField(BuildContext context, MemberFormBloc formBloc) {
    return ValueListenableBuilder(
      valueListenable: formBloc.showDropDown,
      builder: (context, value, _) {
        return _buildTextField(
          context,
          label: context.l10n.district,
          controller: formBloc.districtController,
          isCompulsory: true,
          icon: Icons.location_city_outlined,
          readOnly: value,
          absorbPointer: value,
          errorMessage: context.l10n.please_enter_your_district,
          onTap: value
              ? () {
                  DropDownState<String>(
                    dropDown: DropDown<String>(
                      data: districts,
                      onSelected: (selectedItems) {
                        formBloc.districtController.text =
                            selectedItems.first.data;
                      },
                    ),
                  ).showModal(context);
                }
              : null,
        );
      },
    );
  }

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
