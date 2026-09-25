import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maratha_shivmudra/core/constants/district_constants.dart';
import 'package:maratha_shivmudra/core/constants/geo_constants.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';
import 'package:maratha_shivmudra/core/services/member_profile_service.dart';
import 'package:maratha_shivmudra/core/utils/bilingual_helper.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/main.dart';
import 'package:maratha_shivmudra/src/widgets/dropdown/app_searchable_dropdown.dart';
import 'package:maratha_shivmudra/src/widgets/dropdown/geo_address_fields.dart';
import 'package:maratha_shivmudra/src/widgets/id_card/member_id_card_widget.dart';
import 'package:maratha_shivmudra/src/widgets/keyboard/marathi_virtual_keyboard.dart';

class ProfileContentView extends StatefulWidget {
  final MemberProfile initialProfile;
  final bool isCompact;
  final bool isFixedHeader;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final VoidCallback? onProfileUpdated;

  const ProfileContentView({
    super.key,
    required this.initialProfile,
    this.isCompact = false,
    this.isFixedHeader = false,
    this.showCloseButton = false,
    this.onClose,
    this.onProfileUpdated,
  });

  @override
  State<ProfileContentView> createState() => _ProfileContentViewState();
}

class _ProfileContentViewState extends State<ProfileContentView> {
  late MemberProfile _profile;
  final ImagePicker _picker = ImagePicker();
  bool _isSaving = false;

  // Active section(s) currently being edited
  Set<String> _editingSectionIds = {};

  // Controllers - Personal
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameMrController = TextEditingController();
  final _middleNameMrController = TextEditingController();
  final _lastNameMrController = TextEditingController();
  final _dobController = TextEditingController();
  String _selectedGender = 'Male';
  String _selectedLiving = 'स्वतंत्र घर / स्वतःचे घर (Own House)';
  final _livingOtherController = TextEditingController();
  final _emailController = TextEditingController();

  // Controllers - Current Address
  String _selectedState = 'Maharashtra';
  String _selectedDistrict = 'Pune';
  String _selectedTaluka = '';
  final _villageController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _addressController = TextEditingController();

  // Controllers - Native Village Address
  bool _isNativeAddressSame = true;
  String _selectedNativeState = 'Maharashtra';
  String _selectedNativeDistrict = 'Satara';
  String _selectedNativeTaluka = '';
  final _nativeVillageController = TextEditingController();
  final _nativePincodeController = TextEditingController();
  final _nativeAddressController = TextEditingController();

  // Controllers - Emergency & Blood Group
  String _selectedBloodGroup = '';
  final _emergencyNameController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();

  // Controllers - Occupation
  String _selectedProfession = 'शेती (Farmer)';
  final _professionOtherController = TextEditingController();
  final _jobDesignationController = TextEditingController();
  final _jobCompanyController = TextEditingController();
  final _businessTypeController = TextEditingController();
  String? _selectedEducation;
  final _educationOtherController = TextEditingController();
  final _cropInputController = TextEditingController();
  List<String> _cropsProduced = [];
  String? _unemployedEducation;
  final _unemployedEducationOtherController = TextEditingController();
  final _unemployedPreferredSectorController = TextEditingController();
  final _unemployedSkillsController = TextEditingController();
  bool _willingToRelocate = true;

  // Controllers - Political & NGO
  bool? _isPoliticallyActive;
  final _politicalPartyController = TextEditingController();
  final _politicalRoleController = TextEditingController();
  bool? _isAssociatedWithNgo;
  final _ngoNameController = TextEditingController();
  final _ngoRoleController = TextEditingController();

  // Controllers - Organ Donation
  bool _isOrganDonorPledged = false;
  bool _hasOrganDonationConsentAnswered = false;

  final List<String> _bloodGroups = const [
    'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'
  ];

  final List<String> _professionOptions = const [
    'शेती (Farmer)',
    'नोकरी (Job)',
    'व्यवसाय (Business)',
    'विद्यार्थी (Student)',
    'बेरोजगार (Unemployed)',
    'गृहिणी (Homemaker)',
    'निवृत्त (Retired)',
    'इतर (Other)',
  ];

  final List<String> _livingOptions = const [
    'स्वतंत्र घर / स्वतःचे घर (Own House)',
    'भाड्याने (Rented)',
    'पालकांसोबत / एकत्र कुटुंब (With Family)',
    'हॉस्टेल / लॉज (Hostel/PG)',
    'इतर (Other)',
  ];

  final List<String> _educationOptions = const [
    '१० वी / १२ वी',
    'ITI / डिप्लोमा',
    'पदवी (Graduate)',
    'पदव्युत्तर (Post Graduate)',
    'इंजिनिअरिंग / मेडिकल / व्यावसायिक',
    'इतर',
  ];

  final List<String> _quickCrops = const [
    'ऊस', 'सोयाबीन', 'कांदा', 'हळद', 'कापूस', 'डाळिंब', 'गहू', 'बाजरी', 'मका'
  ];

  @override
  void initState() {
    super.initState();
    _profile = widget.initialProfile;
    _populateControllers(_profile);
  }

  @override
  void didUpdateWidget(covariant ProfileContentView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialProfile != widget.initialProfile) {
      _profile = widget.initialProfile;
      if (_editingSectionIds.isEmpty) {
        _populateControllers(_profile);
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _firstNameMrController.dispose();
    _middleNameMrController.dispose();
    _lastNameMrController.dispose();
    _dobController.dispose();
    _livingOtherController.dispose();
    _emailController.dispose();

    _villageController.dispose();
    _pincodeController.dispose();
    _addressController.dispose();

    _nativeVillageController.dispose();
    _nativePincodeController.dispose();
    _nativeAddressController.dispose();

    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();

    _professionOtherController.dispose();
    _jobDesignationController.dispose();
    _jobCompanyController.dispose();
    _businessTypeController.dispose();
    _educationOtherController.dispose();
    _cropInputController.dispose();
    _unemployedEducationOtherController.dispose();
    _unemployedPreferredSectorController.dispose();
    _unemployedSkillsController.dispose();

    _politicalPartyController.dispose();
    _politicalRoleController.dispose();
    _ngoNameController.dispose();
    _ngoRoleController.dispose();
    super.dispose();
  }

  void _populateControllers(MemberProfile p) {
    // 1. Personal
    _firstNameController.text = p.firstName;
    _middleNameController.text = p.middleName;
    _lastNameController.text = p.lastName;
    _firstNameMrController.text = p.firstNameMr;
    _middleNameMrController.text = p.middleNameMr;
    _lastNameMrController.text = p.lastNameMr;
    _dobController.text = p.dateOfBirth;
    _selectedGender = const ['Male', 'Female', 'Other'].contains(p.gender) ? p.gender : 'Male';
    if (_livingOptions.contains(p.living) && p.living != 'इतर (Other)') {
      _selectedLiving = p.living;
      _livingOtherController.text = '';
    } else if (p.living.isNotEmpty) {
      _selectedLiving = 'इतर (Other)';
      _livingOtherController.text = p.living == 'इतर (Other)' ? '' : p.living;
    } else {
      _selectedLiving = 'स्वतंत्र घर / स्वतःचे घर (Own House)';
      _livingOtherController.text = '';
    }
    _emailController.text = p.email;

    // 2. Current Address
    _selectedState = p.state.isNotEmpty ? p.state : 'Maharashtra';
    _selectedDistrict = p.districtEn.isNotEmpty ? p.districtEn : 'Pune';
    final talukas = _getTalukas(_selectedDistrict);
    _selectedTaluka = talukas.any((t) => t.nameEn == p.subDistrict)
        ? p.subDistrict
        : (talukas.isNotEmpty ? talukas.first.nameEn : '');
    _villageController.text = p.village.isNotEmpty ? p.village : p.city;
    _pincodeController.text = p.pincode;
    _addressController.text = p.address;

    // 3. Native Village Address
    _isNativeAddressSame = p.isNativeAddressSameAsCurrent;
    _selectedNativeState = p.nativeState.isNotEmpty ? p.nativeState : 'Maharashtra';
    _selectedNativeDistrict = p.nativeDistrict.isNotEmpty ? p.nativeDistrict : 'Satara';
    final talukasNative = _getTalukas(_selectedNativeDistrict);
    _selectedNativeTaluka = talukasNative.any((t) => t.nameEn == p.nativeTaluka)
        ? p.nativeTaluka
        : (talukasNative.isNotEmpty ? talukasNative.first.nameEn : '');
    _nativeVillageController.text = p.nativeVillage;
    _nativePincodeController.text = p.nativePincode;
    _nativeAddressController.text = p.nativeAddress;

    // 4. Emergency & Blood
    _selectedBloodGroup = p.bloodGroup;
    _emergencyNameController.text = p.emergencyContactName;
    _emergencyPhoneController.text = p.emergencyContactPhone;

    // 5. Occupation
    final matchedProf = _professionOptions.firstWhere(
      (opt) => opt != 'इतर (Other)' && (opt.toLowerCase().contains(p.profession.toLowerCase()) || p.profession.toLowerCase().contains(opt.toLowerCase())),
      orElse: () => '',
    );
    if (matchedProf.isNotEmpty) {
      _selectedProfession = matchedProf;
      _professionOtherController.text = '';
    } else if (p.profession.isNotEmpty) {
      _selectedProfession = 'इतर (Other)';
      _professionOtherController.text = p.profession == 'इतर (Other)' ? '' : p.profession;
    } else {
      _selectedProfession = 'शेती (Farmer)';
      _professionOtherController.text = '';
    }
    _jobDesignationController.text = p.jobDesignation;
    _jobCompanyController.text = p.jobCompany;
    _businessTypeController.text = p.businessType;
    final eduVal = p.educationLevel.isNotEmpty ? p.educationLevel : (p.education.isNotEmpty ? p.education : null);
    if (eduVal != null && _educationOptions.contains(eduVal) && eduVal != 'इतर') {
      _selectedEducation = eduVal;
      _educationOtherController.text = p.educationOther;
    } else if (eduVal != null && eduVal.isNotEmpty) {
      _selectedEducation = 'इतर';
      _educationOtherController.text = p.educationOther.isNotEmpty ? p.educationOther : (eduVal == 'इतर' ? '' : eduVal);
    } else {
      _selectedEducation = null;
      _educationOtherController.text = '';
    }
    _cropsProduced = List<String>.from(p.cropsProduced);
    if (_educationOptions.contains(p.unemployedEducation) && p.unemployedEducation != 'इतर') {
      _unemployedEducation = p.unemployedEducation;
      _unemployedEducationOtherController.text = '';
    } else if (p.unemployedEducation.isNotEmpty) {
      _unemployedEducation = 'इतर';
      _unemployedEducationOtherController.text = p.unemployedEducation == 'इतर' ? '' : p.unemployedEducation;
    } else {
      _unemployedEducation = null;
      _unemployedEducationOtherController.text = '';
    }
    _unemployedPreferredSectorController.text = p.unemployedPreferredSector;
    _unemployedSkillsController.text = p.unemployedSkills;
    _willingToRelocate = p.willingToRelocate ?? true;

    // 6. Political & NGO
    _isPoliticallyActive = p.isPoliticallyActive;
    _politicalPartyController.text = p.politicalParty;
    _politicalRoleController.text = p.politicalRole;
    _isAssociatedWithNgo = p.isAssociatedWithNgo;
    _ngoNameController.text = p.ngoName;
    _ngoRoleController.text = p.ngoRole;

    // 7. Organ Donation
    _isOrganDonorPledged = p.isOrganDonorPledged;
    _hasOrganDonationConsentAnswered = p.hasOrganDonationConsentAnswered;
  }

  List<TalukaInfo> _getTalukas(String districtEn) {
    final dist = DistrictConstants.districts.firstWhere(
      (d) => d.nameEn == districtEn,
      orElse: () => DistrictConstants.districts.first,
    );
    return dist.talukas;
  }

  Future<void> _pickPhoto() async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'फोटो निवडा / Choose Photo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: AppColors.saffron),
                title: const Text(
                  'गॅलरीतून निवडा (Gallery)',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                onTap: () => Navigator.of(ctx).pop(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: AppColors.saffron),
                title: const Text(
                  'कॅमेऱ्याने फोटो काढा (Camera)',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                onTap: () => Navigator.of(ctx).pop(ImageSource.camera),
              ),
            ],
          ),
        ),
      ),
    );
    if (source == null) return;

    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );
      if (file == null) return;

      final bytes = await file.readAsBytes();
      setState(() => _isSaving = true);
      final success = await MemberProfileService.instance.uploadProfilePhoto(_profile.phone, bytes);

      final updated = await MemberProfileService.instance.getProfile(_profile.phone);
      if (mounted) {
        setState(() {
          if (updated != null) _profile = updated;
          _isSaving = false;
        });
        widget.onProfileUpdated?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'फोटो यशस्वीरित्या सेव्ह झाला!' : 'फोटो सेव्ह करताना अडचण आली.'),
            backgroundColor: success ? AppColors.saffron : Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _addCrop(String crop) {
    final trimmed = crop.trim();
    if (trimmed.isNotEmpty && !_cropsProduced.contains(trimmed)) {
      setState(() => _cropsProduced.add(trimmed));
    }
    _cropInputController.clear();
  }

  void _removeCrop(String crop) {
    setState(() => _cropsProduced.remove(crop));
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    DateTime initial = DateTime(2000, 1, 1);
    if (_dobController.text.isNotEmpty) {
      try {
        final parts = _dobController.text.split('-');
        if (parts.length == 3) {
          initial = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
        } else {
          final slashParts = _dobController.text.split('/');
          if (slashParts.length == 3) {
            initial = DateTime(int.parse(slashParts[2]), int.parse(slashParts[1]), int.parse(slashParts[0]));
          }
        }
      } catch (_) {}
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.saffron,
              onPrimary: Colors.white,
              surface: AppColors.darkSurface,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  void _openPendingSectionsForEdit() {
    _populateControllers(_profile);
    final pending = <String>{};

    // 1. Personal
    if ((_profile.fullNameMr.isEmpty && _profile.fullNameEn.isEmpty && _profile.firstName.isEmpty && _profile.firstNameMr.isEmpty) || _profile.dateOfBirth.isEmpty) {
      pending.add('personal');
    }
    // 2. Current Address
    if (_profile.district.isEmpty || _profile.subDistrict.isEmpty || _profile.address.isEmpty || _profile.pincode.isEmpty) {
      pending.add('current_address');
    }
    // 3. Native Address
    if (!_profile.isNativeAddressSameAsCurrent && (_profile.nativeDistrict.isEmpty || _profile.nativeTaluka.isEmpty)) {
      pending.add('native_address');
    }
    // 4. Occupation
    final occ = (_profile.profession.isNotEmpty ? _profile.profession : _profile.living).toLowerCase().trim();
    if (occ.isEmpty ||
        (occ.contains('farm') && _profile.cropsProduced.isEmpty) ||
        (occ.contains('job') && _profile.jobDesignation.isEmpty && _profile.jobCompany.isEmpty) ||
        (occ.contains('business') && _profile.businessType.isEmpty) ||
        (occ.contains('student') && _profile.educationLevel.isEmpty && _profile.education.isEmpty) ||
        (occ.contains('बेरोजगार') && _profile.unemployedEducation.isEmpty && _profile.unemployedPreferredSector.isEmpty)) {
      pending.add('occupation');
    }
    // 5. Emergency & Blood Group
    if (_profile.bloodGroup.isEmpty || _profile.emergencyContactName.trim().isEmpty || _profile.emergencyContactPhone.trim().isEmpty) {
      pending.add('emergency');
    }
    // 6. Social / Political
    if (_profile.isPoliticallyActive == null || (_profile.isPoliticallyActive! && (_profile.politicalParty.trim().isEmpty || _profile.politicalRole.trim().isEmpty)) ||
        _profile.isAssociatedWithNgo == null || (_profile.isAssociatedWithNgo! && (_profile.ngoName.trim().isEmpty || _profile.ngoRole.trim().isEmpty))) {
      pending.add('social');
    }
    // 7. Organ
    if (!_profile.hasOrganDonationConsentAnswered && !_profile.isOrganDonorPledged) {
      pending.add('organ');
    }

    if (pending.isEmpty) {
      pending.add('personal');
    }

    setState(() {
      _editingSectionIds = pending;
    });
  }

  MemberProfile _buildUpdatedProfile() {
    final stateObj = GeoConstants.states.firstWhere(
      (s) =>
          s.nameEn.toLowerCase() == _selectedState.toLowerCase() ||
          s.code.toLowerCase() == _selectedState.toLowerCase() ||
          s.nameMr == _selectedState,
      orElse: () => GeoConstants.defaultState,
    );

    final distObj = stateObj.districts.firstWhere(
      (d) =>
          d.nameEn.toLowerCase() == _selectedDistrict.toLowerCase() ||
          d.code.toLowerCase() == _selectedDistrict.toLowerCase() ||
          d.nameMr == _selectedDistrict,
      orElse: () => stateObj.districts.isNotEmpty
          ? stateObj.districts.first
          : GeoConstants.defaultState.districts.first,
    );

    final nativeStateObj = GeoConstants.states.firstWhere(
      (s) =>
          s.nameEn.toLowerCase() == _selectedNativeState.toLowerCase() ||
          s.code.toLowerCase() == _selectedNativeState.toLowerCase() ||
          s.nameMr == _selectedNativeState,
      orElse: () => GeoConstants.defaultState,
    );

    final nativeDistObj = nativeStateObj.districts.firstWhere(
      (d) =>
          d.nameEn.toLowerCase() == _selectedNativeDistrict.toLowerCase() ||
          d.code.toLowerCase() == _selectedNativeDistrict.toLowerCase() ||
          d.nameMr == _selectedNativeDistrict,
      orElse: () => nativeStateObj.districts.isNotEmpty
          ? nativeStateObj.districts.first
          : GeoConstants.defaultState.districts.first,
    );

    return _profile.copyWith(
      firstName: _firstNameController.text.trim(),
      middleName: _middleNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      firstNameMr: _firstNameMrController.text.trim(),
      middleNameMr: _middleNameMrController.text.trim(),
      lastNameMr: _lastNameMrController.text.trim(),
      fullNameEnOverride: '${_firstNameController.text.trim()} ${_middleNameController.text.trim()} ${_lastNameController.text.trim()}'.trim(),
      fullNameMrOverride: '${_firstNameMrController.text.trim()} ${_middleNameMrController.text.trim()} ${_lastNameMrController.text.trim()}'.trim(),
      dateOfBirth: _dobController.text.trim(),
      gender: _selectedGender,
      living: (_selectedLiving == 'इतर (Other)' && _livingOtherController.text.trim().isNotEmpty)
          ? _livingOtherController.text.trim()
          : _selectedLiving,
      email: _emailController.text.trim(),

      state: stateObj.nameEn,
      stateCode: stateObj.code,
      district: distObj.nameEn,
      districtEn: distObj.nameEn,
      districtMr: distObj.nameMr,
      districtCode: distObj.code,
      subDistrict: _selectedTaluka,
      village: _villageController.text.trim(),
      city: _villageController.text.trim(),
      pincode: _pincodeController.text.trim(),
      address: _addressController.text.trim(),

      isNativeAddressSameAsCurrent: _isNativeAddressSame,
      nativeState: nativeStateObj.nameEn,
      nativeStateCode: nativeStateObj.code,
      nativeDistrict: nativeDistObj.nameEn,
      nativeTaluka: _selectedNativeTaluka,
      nativeVillage: _nativeVillageController.text.trim(),
      nativePincode: _nativePincodeController.text.trim(),
      nativeAddress: _nativeAddressController.text.trim(),

      bloodGroup: _selectedBloodGroup,
      emergencyContactName: _emergencyNameController.text.trim(),
      emergencyContactPhone: _emergencyPhoneController.text.trim(),

      profession: (_selectedProfession.contains('इतर') && _professionOtherController.text.trim().isNotEmpty)
          ? _professionOtherController.text.trim()
          : _selectedProfession,
      jobDesignation: _jobDesignationController.text.trim(),
      jobCompany: _jobCompanyController.text.trim(),
      businessType: _businessTypeController.text.trim(),
      educationLevel: _selectedEducation ?? '',
      educationOther: _educationOtherController.text.trim(),
      education: (_selectedEducation == 'इतर' && _educationOtherController.text.trim().isNotEmpty)
          ? _educationOtherController.text.trim()
          : (_selectedEducation ?? ''),
      cropsProduced: _cropsProduced,
      unemployedEducation: (_unemployedEducation == 'इतर' && _unemployedEducationOtherController.text.trim().isNotEmpty)
          ? _unemployedEducationOtherController.text.trim()
          : (_unemployedEducation ?? ''),
      unemployedPreferredSector: _unemployedPreferredSectorController.text.trim(),
      unemployedSkills: _unemployedSkillsController.text.trim(),
      willingToRelocate: _willingToRelocate,

      isPoliticallyActive: _isPoliticallyActive,
      politicalParty: _politicalPartyController.text.trim(),
      politicalRole: _politicalRoleController.text.trim(),
      isAssociatedWithNgo: _isAssociatedWithNgo,
      ngoName: _ngoNameController.text.trim(),
      ngoRole: _ngoRoleController.text.trim(),

      isOrganDonorPledged: _isOrganDonorPledged,
      hasOrganDonationConsentAnswered: _hasOrganDonationConsentAnswered,
    );
  }

  String? _validateSection(String sectionId, bool isMarathi) {
    switch (sectionId) {
      case 'personal':
        if (_firstNameController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया पहिले नाव (इंग्रजी) प्रविष्ट करा.' : 'Please enter First Name (English).';
        }
        if (_middleNameController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया मधले नाव (इंग्रजी) प्रविष्ट करा.' : 'Please enter Middle Name (English).';
        }
        if (_lastNameController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया आडनाव (इंग्रजी) प्रविष्ट करा.' : 'Please enter Last Name (English).';
        }
        if (_firstNameMrController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया पहिले नाव (मराठी) प्रविष्ट करा.' : 'Please enter First Name (Marathi).';
        }
        if (_middleNameMrController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया मधले नाव (मराठी) प्रविष्ट करा.' : 'Please enter Middle Name (Marathi).';
        }
        if (_lastNameMrController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया आडनाव (मराठी) प्रविष्ट करा.' : 'Please enter Last Name (Marathi).';
        }
        if (_dobController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया जन्मतारीख निवडा.' : 'Please select Date of Birth.';
        }
        if (_selectedLiving == 'इतर (Other)' && _livingOtherController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया आपला निवास प्रकार लिहा.' : 'Please specify your residence/living type.';
        }
        return null;

      case 'current_address':
        if (_selectedTaluka.trim().isEmpty) {
          return isMarathi ? 'कृपया तालुका निवडा.' : 'Please select Taluka.';
        }
        if (_villageController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया गाव किंवा शहराचे नाव प्रविष्ट करा.' : 'Please enter Village or City.';
        }
        if (_pincodeController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया पिनकोड प्रविष्ट करा.' : 'Please enter Pincode.';
        }
        if (_addressController.text.trim().isEmpty) {
          return isMarathi ? 'कृपया संपूर्ण पत्ता प्रविष्ट करा.' : 'Please enter Full Address.';
        }
        return null;

      case 'native_address':
        if (!_isNativeAddressSame) {
          if (_nativeVillageController.text.trim().isEmpty) {
            return isMarathi ? 'कृपया मूळ गावाचे नाव प्रविष्ट करा.' : 'Please enter Native Village Name.';
          }
        }
        return null;

      case 'occupation':
        if (_selectedProfession.contains('नोकरी')) {
          if (_jobDesignationController.text.trim().isEmpty) {
            return isMarathi ? 'कृपया नोकरीतील पद / हुद्दा प्रविष्ट करा.' : 'Please enter Job Designation.';
          }
          if (_jobCompanyController.text.trim().isEmpty) {
            return isMarathi ? 'कृपया कंपनी / आस्थापनेचे नाव प्रविष्ट करा.' : 'Please enter Company / Employer Name.';
          }
        } else if (_selectedProfession.contains('व्यवसाय')) {
          if (_businessTypeController.text.trim().isEmpty) {
            return isMarathi ? 'कृपया व्यवसायाचे स्वरूप प्रविष्ट करा.' : 'Please enter Business Nature / Sector.';
          }
        } else if (_selectedProfession.contains('विद्यार्थी')) {
          if (_selectedEducation == 'इतर' && _educationOtherController.text.trim().isEmpty) {
            return isMarathi ? 'कृपया शिक्षणाचा तपशील प्रविष्ट करा.' : 'Please specify your Education details.';
          }
        } else if (_selectedProfession.contains('शेती')) {
          if (_cropsProduced.isEmpty) {
            return isMarathi ? 'कृपया किमान एक पीक जोडा.' : 'Please add at least one crop produced.';
          }
        } else if (_selectedProfession.contains('बेरोजगार')) {
          if (_unemployedEducation == 'इतर' && _unemployedEducationOtherController.text.trim().isEmpty) {
            return isMarathi ? 'कृपया शिक्षणाचा तपशील प्रविष्ट करा.' : 'Please specify your Education details.';
          }
        } else if (_selectedProfession.contains('इतर') || _selectedProfession.contains('Other')) {
          if (_professionOtherController.text.trim().isEmpty) {
            return isMarathi ? 'कृपया आपला व्यवसाय / कार्यक्षेत्र प्रविष्ट करा.' : 'Please specify your Profession / Occupation.';
          }
        }
        return null;

      case 'emergency':
        final phone = _emergencyPhoneController.text.trim();
        if (phone.isNotEmpty && phone.length != 10) {
          return isMarathi ? 'कृपया वैध १० अंकी आपत्कालीन मोबाईल क्रमांक प्रविष्ट करा.' : 'Please enter a valid 10-digit emergency contact phone.';
        }
        return null;

      default:
        return null;
    }
  }

  Future<void> _saveSection(String sectionId) async {
    final isMarathi = Localizations.localeOf(context).languageCode == 'mr';
    final error = _validateSection(sectionId, isMarathi);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.errorColor,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);
    final updatedProfile = _buildUpdatedProfile();

    final result = await MemberProfileService.instance.updateProfile(updatedProfile);

    if (mounted) {
      setState(() {
        _isSaving = false;
        if (result != null) {
          _profile = result;
          _editingSectionIds.remove(sectionId);
          _populateControllers(_profile);
        }
      });
      widget.onProfileUpdated?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isMarathi ? 'माहिती यशस्वीरित्या जतन झाली!' : 'Information updated successfully!'),
          backgroundColor: AppColors.saffron,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _saveAllSections() async {
    final isMarathi = Localizations.localeOf(context).languageCode == 'mr';
    for (final sec in _editingSectionIds) {
      final error = _validateSection(sec, isMarathi);
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: AppColors.errorColor,
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }
    }

    setState(() => _isSaving = true);
    final updatedProfile = _buildUpdatedProfile();

    final result = await MemberProfileService.instance.updateProfile(updatedProfile);

    if (mounted) {
      setState(() {
        _isSaving = false;
        if (result != null) {
          _profile = result;
          _editingSectionIds.clear();
          _populateControllers(_profile);
        }
      });
      widget.onProfileUpdated?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isMarathi ? 'सर्व माहिती यशस्वीरित्या जतन झाली!' : 'All information updated successfully!'),
          backgroundColor: AppColors.saffron,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isDesktop = constraints.maxWidth > 580 && screenWidth > 640;
        final isCompact = constraints.maxWidth < 450 || screenWidth < 450;

        return ValueListenableBuilder<Locale>(
          valueListenable: appLocaleNotifier,
          builder: (context, locale, _) {
            final isMarathi = locale.languageCode == 'mr';
            final progress = _profile.completionProgress;
            final isComplete = _profile.isProfileComplete;

            final fixedHeader = _buildFixedIdentityCard(isMarathi, isCompact: isCompact);

            final bodyContent = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Meter (Only shown when profile is not 100% complete)
                if (!isComplete) ...[
                  _buildProgressMeter(progress, isMarathi),
                  const SizedBox(height: 16),
                ],

                  // SECTION 1: Personal Details
                  _buildSectionWrapper(
                    sectionId: 'personal',
                    title: isMarathi ? '१. वैयक्तिक व मूलभूत माहिती' : '1. Personal Details',
                    icon: Icons.person_rounded,
                    isMarathi: isMarathi,
                    isCompact: isCompact,
                    viewChild: _buildPersonalView(isMarathi, isCompact: isCompact),
                    editChild: _buildPersonalEdit(isMarathi, isDesktop: isDesktop),
                  ),
                  const SizedBox(height: 14),

                  // SECTION 2: Current Address
                  _buildSectionWrapper(
                    sectionId: 'current_address',
                    title: isMarathi ? '२. सध्याचा पत्ता' : '2. Current Address',
                    icon: Icons.location_on_rounded,
                    isMarathi: isMarathi,
                    isCompact: isCompact,
                    viewChild: _buildCurrentAddressView(isMarathi, isCompact: isCompact),
                    editChild: _buildCurrentAddressEdit(isMarathi, isDesktop: isDesktop),
                  ),
                  const SizedBox(height: 14),

                  // SECTION 3: Native Village Address
                  _buildSectionWrapper(
                    sectionId: 'native_address',
                    title: isMarathi ? '३. मूळ गाव पत्ता' : '3. Native Village Address',
                    icon: Icons.home_work_rounded,
                    isMarathi: isMarathi,
                    isCompact: isCompact,
                    viewChild: _buildNativeAddressView(isMarathi, isCompact: isCompact),
                    editChild: _buildNativeAddressEdit(isMarathi, isDesktop: isDesktop),
                  ),
                  const SizedBox(height: 14),

                  // SECTION 4: Occupation & Sector
                  _buildSectionWrapper(
                    sectionId: 'occupation',
                    title: isMarathi ? '४. व्यवसाय व कार्यक्षेत्र' : '4. Occupation & Sector Details',
                    icon: Icons.work_rounded,
                    isMarathi: isMarathi,
                    isCompact: isCompact,
                    viewChild: _buildOccupationView(isMarathi, isCompact: isCompact),
                    editChild: _buildOccupationEdit(isMarathi, isDesktop: isDesktop),
                  ),
                  const SizedBox(height: 14),

                  // SECTION 5: Emergency & Blood Group
                  _buildSectionWrapper(
                    sectionId: 'emergency',
                    title: isMarathi ? '५. आपत्कालीन संपर्क व रक्तगट' : '5. Emergency Contact & Blood Group',
                    icon: Icons.bloodtype_rounded,
                    isMarathi: isMarathi,
                    isCompact: isCompact,
                    viewChild: _buildEmergencyView(isMarathi, isCompact: isCompact),
                    editChild: _buildEmergencyEdit(isMarathi, isDesktop: isDesktop),
                  ),
                  const SizedBox(height: 14),

                  // SECTION 6: Political & NGO Affiliations
                  _buildSectionWrapper(
                    sectionId: 'social',
                    title: isMarathi ? '६. राजकीय व सामाजिक सहभाग' : '6. Political & Social Affiliations',
                    icon: Icons.groups_rounded,
                    isMarathi: isMarathi,
                    isCompact: isCompact,
                    viewChild: _buildSocialView(isMarathi, isCompact: isCompact),
                    editChild: _buildSocialEdit(isMarathi, isDesktop: isDesktop),
                  ),
                  const SizedBox(height: 14),

                  // SECTION 7: Organ Donation Pledge
                  _buildSectionWrapper(
                    sectionId: 'organ',
                    title: isMarathi ? '७. मरणोत्तर अवयवदान संकल्प' : '7. Organ Donation Pledge',
                    icon: Icons.favorite_rounded,
                    isMarathi: isMarathi,
                    isCompact: isCompact,
                    viewChild: _buildOrganView(isMarathi, isCompact: isCompact),
                    editChild: _buildOrganEdit(isMarathi),
                  ),

                  // Save all pending button when multiple sections open
                  if (_editingSectionIds.length > 1) ...[
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _isSaving ? null : _saveAllSections,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.saffron,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: _isSaving
                            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                        label: Text(
                          isMarathi ? 'सर्व माहिती जतन करा (Save All)' : 'Save All Changes',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],

                  // Official ID Card (ONLY if 100% complete)
                  if (isComplete) ...[
                    const SizedBox(height: 24),
                    _buildIdCardSection(isMarathi),
                  ],
                  const SizedBox(height: 30),
                ],
              );

            // Responsive bounded vs unbounded handling
            if (constraints.hasBoundedHeight) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(isCompact ? 10 : 16, 12, isCompact ? 10 : 16, 0),
                    child: fixedHeader,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: isCompact ? 10 : 16,
                        vertical: 12,
                      ),
                      child: bodyContent,
                    ),
                  ),
                ],
              );
            }

            // Unbounded parent (e.g. inside an outer SingleChildScrollView):
            // Lay out sequentially so the parent scrollable handles scrolling cleanly
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isCompact ? 10 : 16,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fixedHeader,
                  const SizedBox(height: 14),
                  bodyContent,
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ====================================================================
  // FIXED IDENTITY HEADER CARD (Avatar, Name, Mobile, ID)
  // ====================================================================
  Widget _buildFixedIdentityCard(bool isMarathi, {bool isCompact = false}) {
    final compact = isCompact || widget.isCompact;
    final displayName = isMarathi
        ? (_profile.fullNameMr.isNotEmpty ? _profile.fullNameMr : _profile.fullNameEn)
        : (_profile.fullNameEn.isNotEmpty ? _profile.fullNameEn : _profile.fullNameMr);

    final isIssued = _profile.isCardIssued || (_profile.memberId != null && _profile.memberId != 'PENDING');

    ImageProvider? avatarImage;
    if (_profile.photoUrl != null && _profile.photoUrl!.isNotEmpty) {
      avatarImage = NetworkImage(_profile.photoUrl!);
    } else if (_profile.photoBase64 != null && _profile.photoBase64!.isNotEmpty) {
      try {
        final clean = _profile.photoBase64!.contains(',')
            ? _profile.photoBase64!.split(',').last
            : _profile.photoBase64!;
        avatarImage = MemoryImage(base64Decode(clean));
      } catch (_) {}
    }

    return Container(
      padding: EdgeInsets.all(compact ? 12 : 16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.saffron.withValues(alpha: 0.12),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with Camera Badge
          GestureDetector(
            onTap: _pickPhoto,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: compact ? 28 : 34,
                  backgroundColor: AppColors.darkBgHeroTop,
                  backgroundImage: avatarImage,
                  child: avatarImage == null
                      ? Icon(Icons.person_rounded, color: AppColors.goldLight, size: compact ? 28 : 34)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.saffron,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, size: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  displayName.isNotEmpty ? displayName : (isMarathi ? 'सभासद प्रोफाइल' : 'Member Profile'),
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: compact ? 15 : 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.phone_rounded, size: 12, color: AppColors.goldLight),
                    const SizedBox(width: 4),
                    Text(
                      _profile.phone,
                      style: const TextStyle(fontSize: 12, color: AppColors.goldLight, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: isIssued
                            ? Colors.green.withValues(alpha: 0.15)
                            : Colors.orangeAccent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isIssued ? Colors.greenAccent : Colors.orangeAccent,
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        isIssued ? 'ID: ${_profile.memberId}' : (isMarathi ? 'नोंदणी: प्रलंबित' : 'Pending'),
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: isIssued ? Colors.greenAccent : Colors.orangeAccent,
                        ),
                      ),
                    ),
                    if (_profile.isOfficial && (_profile.officialFullTitleMr != null || _profile.officialRoleMr != null))
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.goldLight, width: 0.8),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: compact ? 150 : 250),
                          child: Text(
                            _profile.officialFullTitleMr ?? _profile.officialRoleMr!,
                            style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.goldLight),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.showCloseButton && widget.onClose != null) ...[
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.close_rounded, color: AppColors.goldLight, size: 22),
              onPressed: widget.onClose,
              tooltip: isMarathi ? 'बंद करा' : 'Close',
              splashRadius: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          ],
        ],
      ),
    );
  }

  // ====================================================================
  // PROGRESS METER
  // ====================================================================
  Widget _buildProgressMeter(double progress, bool isMarathi) {
    final percent = (progress * 100).toInt();
    final isComplete = progress >= 1.0;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isComplete ? Colors.green : AppColors.gold.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  isMarathi ? 'प्रोफाइल पूर्णता: $percent%' : 'Profile Completion: $percent%',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isComplete
                    ? (isMarathi ? '✓ १००% पूर्ण' : '✓ 100% Complete')
                    : (isMarathi ? 'प्रलंबित ($percent%)' : 'Pending ($percent%)'),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isComplete ? Colors.greenAccent : Colors.orangeAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.darkBorder,
              valueColor: AlwaysStoppedAnimation<Color>(
                isComplete ? Colors.green : AppColors.saffron,
              ),
            ),
          ),
          if (_profile.missingItems.isNotEmpty) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    isMarathi ? 'अपूर्ण माहिती:' : 'Missing items:',
                    style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                  ),
                ),
                TextButton.icon(
                  onPressed: _openPendingSectionsForEdit,
                  icon: const Icon(Icons.edit_note_rounded, size: 16, color: AppColors.saffronLight),
                  label: Text(
                    isMarathi ? 'माहिती पूर्ण भरा' : 'Complete Profile',
                    style: const TextStyle(fontSize: 11, color: AppColors.saffronLight, fontWeight: FontWeight.bold),
                  ),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, visualDensity: VisualDensity.compact),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: _profile.missingItems.map((item) {
                return Chip(
                  backgroundColor: AppColors.darkBgHeroTop,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                  visualDensity: VisualDensity.compact,
                  avatar: const Icon(Icons.circle_outlined, size: 10, color: AppColors.saffron),
                  label: Text(item, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  // ====================================================================
  // MODULAR SECTION WRAPPER WITH INDEPENDENT EDIT/VIEW TOGGLE
  // ====================================================================
  Widget _buildSectionWrapper({
    required String sectionId,
    required String title,
    required IconData icon,
    required bool isMarathi,
    required Widget viewChild,
    required Widget editChild,
    bool isCompact = false,
  }) {
    final isEditing = _editingSectionIds.contains(sectionId);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isEditing ? AppColors.gold : AppColors.darkBorder,
          width: isEditing ? 1.2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isEditing ? AppColors.darkBgHeroTop : Colors.transparent,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              border: Border(bottom: BorderSide(color: AppColors.darkBorder.withValues(alpha: 0.6))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(icon, size: 16, color: AppColors.goldLight),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: isCompact ? 12 : 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (!isEditing)
                  InkWell(
                    onTap: () {
                      _populateControllers(_profile);
                      setState(() => _editingSectionIds.add(sectionId));
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.edit_outlined, size: 12, color: AppColors.goldLight),
                          const SizedBox(width: 4),
                          Text(
                            isMarathi ? 'संपादित करा' : 'Edit',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.goldLight),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Text(
                    isMarathi ? 'संपादन सुरू आहे' : 'Editing',
                    style: const TextStyle(fontSize: 11, color: AppColors.saffronLight, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(14),
            child: isEditing
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      editChild,
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _populateControllers(_profile);
                              setState(() => _editingSectionIds.remove(sectionId));
                            },
                            child: Text(isMarathi ? 'रद्द करा' : 'Cancel', style: const TextStyle(color: AppColors.textMuted)),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _isSaving ? null : () => _saveSection(sectionId),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.saffron,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            ),
                            icon: const Icon(Icons.check, size: 15, color: Colors.white),
                            label: Text(
                              isMarathi ? 'जतन करा' : 'Save',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : viewChild,
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // RESPONSIVE LAYOUT HELPERS (ROW on desktop, COLUMN on mobile)
  // ====================================================================
  Widget _buildResponsivePair({
    required bool isDesktop,
    required Widget child1,
    required Widget child2,
    double spacing = 10,
  }) {
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: child1),
          SizedBox(width: spacing),
          Expanded(child: child2),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        child1,
        SizedBox(height: spacing),
        child2,
      ],
    );
  }

  Widget _buildResponsiveTriple({
    required bool isDesktop,
    required Widget child1,
    required Widget child2,
    required Widget child3,
    double spacing = 8,
  }) {
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: child1),
          SizedBox(width: spacing),
          Expanded(child: child2),
          SizedBox(width: spacing),
          Expanded(child: child3),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        child1,
        SizedBox(height: spacing),
        child2,
        SizedBox(height: spacing),
        child3,
      ],
    );
  }

  // ====================================================================
  // 1. PERSONAL DETAILS: VIEW & EDIT
  // ====================================================================
  Widget _buildPersonalView(bool isMarathi, {bool isCompact = false}) {
    return Column(
      children: [
        _buildDetailRow(
          isMarathi ? 'पूर्ण नाव (इंग्रजी)' : 'Full Name (En)',
          _profile.fullNameEn.isNotEmpty ? _profile.fullNameEn : '${_profile.firstName} ${_profile.middleName} ${_profile.lastName}'.trim(),
          isCompact: isCompact,
        ),
        _buildDetailRow(
          isMarathi ? 'पूर्ण नाव (मराठी)' : 'Full Name (Mr)',
          _profile.fullNameMr.isNotEmpty ? _profile.fullNameMr : '${_profile.firstNameMr} ${_profile.middleNameMr} ${_profile.lastNameMr}'.trim(),
          isCompact: isCompact,
        ),
        _buildDetailRow(isMarathi ? 'जन्मतारीख (DOB)' : 'Date of Birth', _profile.dateOfBirth.isNotEmpty ? _profile.dateOfBirth : '-', isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'लिंग (Gender)' : 'Gender', _profile.gender.isNotEmpty ? _profile.gender : '-', isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'मोबाईल नंबर' : 'Mobile Number', _profile.phone, isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'ईमेल (Email)' : 'Email', _profile.email.isNotEmpty ? _profile.email : '-', isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'सद्यस्थिती (Living)' : 'Residence', _profile.living.isNotEmpty ? _profile.living : '-', isCompact: isCompact),
      ],
    );
  }

  Widget _buildPersonalEdit(bool isMarathi, {bool isDesktop = false}) {
    return Column(
      children: [
        // English Names
        _buildResponsiveTriple(
          isDesktop: isDesktop,
          child1: _buildInput(
            isMarathi ? 'पहिले नाव (इंग्रजी)' : 'First Name (En)',
            _firstNameController,
            isCompulsory: true,
            onChanged: (val) async {
              _firstNameMrController.text = BilingualHelper.transliterateToMarathi(val);
              final live = await BilingualHelper.transliterateLive(val);
              if (mounted && _firstNameController.text.trim() == val.trim()) {
                _firstNameMrController.text = live;
              }
            },
          ),
          child2: _buildInput(
            isMarathi ? 'मधले नाव (इंग्रजी)' : 'Middle Name (En)',
            _middleNameController,
            isCompulsory: true,
            onChanged: (val) async {
              _middleNameMrController.text = BilingualHelper.transliterateToMarathi(val);
              final live = await BilingualHelper.transliterateLive(val);
              if (mounted && _middleNameController.text.trim() == val.trim()) {
                _middleNameMrController.text = live;
              }
            },
          ),
          child3: _buildInput(
            isMarathi ? 'आडनाव (इंग्रजी)' : 'Last Name (En)',
            _lastNameController,
            isCompulsory: true,
            onChanged: (val) async {
              _lastNameMrController.text = BilingualHelper.transliterateToMarathi(val);
              final live = await BilingualHelper.transliterateLive(val);
              if (mounted && _lastNameController.text.trim() == val.trim()) {
                _lastNameMrController.text = live;
              }
            },
          ),
        ),
        const SizedBox(height: 10),

        // Marathi Names
        _buildResponsiveTriple(
          isDesktop: isDesktop,
          child1: _buildInput(
            isMarathi ? 'पहिले नाव (मराठी)' : 'First Name (Mr)',
            _firstNameMrController,
            isCompulsory: true,
            keyboardTitle: 'पहिले नाव',
          ),
          child2: _buildInput(
            isMarathi ? 'मधले नाव (मराठी)' : 'Middle Name (Mr)',
            _middleNameMrController,
            isCompulsory: true,
            keyboardTitle: 'मधले नाव',
          ),
          child3: _buildInput(
            isMarathi ? 'आडनाव (मराठी)' : 'Last Name (Mr)',
            _lastNameMrController,
            isCompulsory: true,
            keyboardTitle: 'आडनाव',
          ),
        ),
        const SizedBox(height: 10),

        // DOB with DatePicker & Gender Dropdown
        _buildResponsivePair(
          isDesktop: isDesktop,
          child1: _buildInput(
            isMarathi ? 'जन्मतारीख (दि/महि/वर्ष)' : 'Date of Birth',
            _dobController,
            isCompulsory: true,
            readOnly: true,
            onTap: () => _selectDateOfBirth(context),
            customSuffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today_rounded, size: 16, color: AppColors.goldLight),
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              padding: const EdgeInsets.all(6),
              visualDensity: VisualDensity.compact,
              onPressed: () => _selectDateOfBirth(context),
            ),
          ),
          child2: AppSearchableDropdown<String>(
            key: ValueKey('gender_$_selectedGender'),
            value: const ['Male', 'Female', 'Other'].contains(_selectedGender) ? _selectedGender : 'Male',
            labelText: isMarathi ? 'लिंग *' : 'Gender *',
            searchHint: isMarathi ? 'लिंग निवडा...' : 'Select gender...',
            prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.gold, size: 18),
            items: [
              AppDropdownItem(value: 'Male', label: isMarathi ? 'पुरुष (Male)' : 'Male', searchKey: 'Male पुरुष'),
              AppDropdownItem(value: 'Female', label: isMarathi ? 'स्त्री (Female)' : 'Female', searchKey: 'Female स्त्री'),
              AppDropdownItem(value: 'Other', label: isMarathi ? 'इतर (Other)' : 'Other', searchKey: 'Other इतर'),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _selectedGender = val);
            },
          ),
        ),
        const SizedBox(height: 10),

        // Living & Email
        _buildResponsivePair(
          isDesktop: isDesktop,
          child1: AppSearchableDropdown<String>(
            key: ValueKey('living_$_selectedLiving'),
            value: _livingOptions.contains(_selectedLiving) ? _selectedLiving : _livingOptions.first,
            labelText: isMarathi ? 'सद्यस्थिती (निवास प्रकार) *' : 'Residence / Living *',
            searchHint: isMarathi ? 'निवास प्रकार शोधा...' : 'Search living type...',
            prefixIcon: const Icon(Icons.home_outlined, color: AppColors.gold, size: 18),
            items: _livingOptions.map((opt) {
              return AppDropdownItem<String>(
                value: opt,
                label: opt,
                searchKey: opt,
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedLiving = val);
            },
          ),
          child2: _buildInput(
            isMarathi ? 'ईमेल पत्ता' : 'Email Address',
            _emailController,
            showKeyboardIcon: false,
          ),
        ),
        if (_selectedLiving == 'इतर (Other)') ...[
          const SizedBox(height: 10),
          _buildInput(
            isMarathi ? 'आपला निवास प्रकार लिहा *' : 'Specify Residence / Living Type *',
            _livingOtherController,
            isCompulsory: true,
            keyboardTitle: 'निवास प्रकार',
          ),
        ],
      ],
    );
  }

  // ====================================================================
  // 2. CURRENT ADDRESS: VIEW & EDIT
  // ====================================================================
  Widget _buildCurrentAddressView(bool isMarathi, {bool isCompact = false}) {
    final stateInfo = GeoConstants.findState(_profile.state.isNotEmpty ? _profile.state : _profile.stateCode);
    final stateDisplay = stateInfo != null
        ? (isMarathi ? stateInfo.nameMr : stateInfo.nameEn)
        : (_profile.state.isNotEmpty ? _profile.state : (isMarathi ? 'महाराष्ट्र' : 'Maharashtra'));

    final distName = _profile.districtMr.isNotEmpty && isMarathi
        ? _profile.districtMr
        : (_profile.districtEn.isNotEmpty ? _profile.districtEn : (_profile.district.isNotEmpty ? _profile.district : '-'));

    return Column(
      children: [
        _buildDetailRow(isMarathi ? 'राज्य' : 'State', stateDisplay, isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'जिल्हा' : 'District', distName, isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'तालुका' : 'Taluka', _profile.subDistrict.isNotEmpty ? _profile.subDistrict : '-', isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'गाव / शहर' : 'Village/City', _profile.village.isNotEmpty ? _profile.village : (_profile.city.isNotEmpty ? _profile.city : '-'), isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'पिनकोड' : 'Pincode', _profile.pincode.isNotEmpty ? _profile.pincode : '-', isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'संपूर्ण पत्ता' : 'Full Address', _profile.address.isNotEmpty ? _profile.address : '-', isCompact: isCompact),
      ],
    );
  }

  Widget _buildCurrentAddressEdit(bool isMarathi, {bool isDesktop = false}) {
    return Column(
      children: [
        GeoAddressFields(
          keyPrefix: 'cur_geo',
          isMarathi: isMarathi,
          isDesktop: isDesktop,
          initialState: _selectedState,
          initialDistrict: _selectedDistrict,
          initialTaluka: _selectedTaluka,
          onChanged: (state, district, taluka) {
            setState(() {
              _selectedState = state.code;
              _selectedDistrict = district?.code ?? '';
              _selectedTaluka = taluka?.nameEn ?? '';
            });
          },
        ),
        const SizedBox(height: 10),
        _buildResponsivePair(
          isDesktop: isDesktop,
          child1: _buildInput(
            isMarathi ? 'गाव / शहर नाव' : 'Village / City',
            _villageController,
            keyboardTitle: 'गाव/शहर',
          ),
          child2: _buildInput(
            isMarathi ? 'पिनकोड' : 'Pincode',
            _pincodeController,
            keyboardTitle: 'पिनकोड',
          ),
        ),
        const SizedBox(height: 10),
        _buildInput(
          isMarathi ? 'संपूर्ण पत्ता (घर क्र., गल्ली, परिसर)' : 'Full Address Line',
          _addressController,
          keyboardTitle: 'पत्ता',
        ),
      ],
    );
  }

  // ====================================================================
  // 3. NATIVE VILLAGE ADDRESS: VIEW & EDIT
  // ====================================================================
  Widget _buildNativeAddressView(bool isMarathi, {bool isCompact = false}) {
    if (_profile.isNativeAddressSameAsCurrent) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                isMarathi ? 'सध्याचा पत्ता हाच मूळ गाव पत्ता आहे.' : 'Current address is same as native village address.',
                style: const TextStyle(fontSize: 12, color: Colors.greenAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }

    final nativeStateInfo = GeoConstants.findState(_profile.nativeState.isNotEmpty ? _profile.nativeState : _profile.nativeStateCode);
    final nativeStateDisplay = nativeStateInfo != null
        ? (isMarathi ? nativeStateInfo.nameMr : nativeStateInfo.nameEn)
        : (_profile.nativeState.isNotEmpty ? _profile.nativeState : '-');

    final nativeDist = _profile.nativeDistrict.isNotEmpty
        ? (isMarathi ? (DistrictConstants.getNameMr(_profile.nativeDistrict).isNotEmpty ? DistrictConstants.getNameMr(_profile.nativeDistrict) : _profile.nativeDistrict) : _profile.nativeDistrict)
        : '-';

    return Column(
      children: [
        _buildDetailRow(isMarathi ? 'मूळ राज्य' : 'Native State', nativeStateDisplay, isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'मूळ जिल्हा' : 'Native District', nativeDist, isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'मूळ तालुका' : 'Native Taluka', _profile.nativeTaluka.isNotEmpty ? _profile.nativeTaluka : '-', isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'मूळ गाव' : 'Native Village', _profile.nativeVillage.isNotEmpty ? _profile.nativeVillage : '-', isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'मूळ पिनकोड' : 'Native Pincode', _profile.nativePincode.isNotEmpty ? _profile.nativePincode : '-', isCompact: isCompact),
        _buildDetailRow(isMarathi ? 'मूळ संपूर्ण पत्ता' : 'Native Address', _profile.nativeAddress.isNotEmpty ? _profile.nativeAddress : '-', isCompact: isCompact),
      ],
    );
  }

  Widget _buildNativeAddressEdit(bool isMarathi, {bool isDesktop = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          value: _isNativeAddressSame,
          contentPadding: EdgeInsets.zero,
          activeColor: AppColors.saffron,
          title: Text(
            isMarathi ? 'सध्याचा पत्ता हाच मूळ गाव पत्ता आहे' : 'Current address is same as native address',
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          onChanged: (val) => setState(() => _isNativeAddressSame = val ?? true),
        ),
        if (!_isNativeAddressSame) ...[
          const SizedBox(height: 10),
          GeoAddressFields(
            keyPrefix: 'nat_geo',
            isMarathi: isMarathi,
            isDesktop: isDesktop,
            initialState: _selectedNativeState,
            initialDistrict: _selectedNativeDistrict,
            initialTaluka: _selectedNativeTaluka,
            stateLabel: isMarathi ? 'मूळ राज्य' : 'Native State',
            districtLabel: isMarathi ? 'मूळ जिल्हा' : 'Native District',
            talukaLabel: isMarathi ? 'मूळ तालुका / शहर' : 'Native Taluka / City',
            onChanged: (state, district, taluka) {
              setState(() {
                _selectedNativeState = state.code;
                _selectedNativeDistrict = district?.code ?? '';
                _selectedNativeTaluka = taluka?.nameEn ?? '';
              });
            },
          ),
          const SizedBox(height: 10),
          _buildResponsivePair(
            isDesktop: isDesktop,
            child1: _buildInput(
              isMarathi ? 'मूळ गाव / वाडी नाव' : 'Native Village Name',
              _nativeVillageController,
              keyboardTitle: 'मूळ गाव',
            ),
            child2: _buildInput(
              isMarathi ? 'पिनकोड' : 'Pincode',
              _nativePincodeController,
              keyboardTitle: 'पिनकोड',
            ),
          ),
          const SizedBox(height: 10),
          _buildInput(
            isMarathi ? 'मूळ संपूर्ण पत्ता' : 'Native Full Address',
            _nativeAddressController,
            keyboardTitle: 'मूळ पत्ता',
          ),
        ],
      ],
    );
  }

  // ====================================================================
  // 4. OCCUPATION & SECTOR: VIEW & EDIT
  // ====================================================================
  Widget _buildOccupationView(bool isMarathi, {bool isCompact = false}) {
    return Column(
      children: [
        _buildDetailRow(isMarathi ? 'व्यवसाय / कार्यक्षेत्र' : 'Profession / Sector', _profile.profession.isNotEmpty ? _profile.profession : '-', isCompact: isCompact),
        if (_profile.jobDesignation.isNotEmpty || _profile.jobCompany.isNotEmpty) ...[
          _buildDetailRow(isMarathi ? 'नोकरी पद / हुद्दा' : 'Designation', _profile.jobDesignation, isCompact: isCompact),
          _buildDetailRow(isMarathi ? 'कंपनी / आस्थापना' : 'Company Name', _profile.jobCompany, isCompact: isCompact),
        ],
        if (_profile.businessType.isNotEmpty)
          _buildDetailRow(isMarathi ? 'व्यवसायाचे स्वरूप' : 'Business Nature', _profile.businessType, isCompact: isCompact),
        if (_profile.educationLevel.isNotEmpty || _profile.education.isNotEmpty)
          _buildDetailRow(
            isMarathi ? 'शिक्षण शाखा' : 'Education Level',
            _profile.educationLevel == 'इतर' && _profile.educationOther.isNotEmpty
                ? 'इतर (${_profile.educationOther})'
                : (_profile.educationLevel.isNotEmpty ? _profile.educationLevel : _profile.education),
            isCompact: isCompact,
          ),
        if (_profile.cropsProduced.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: isCompact ? 105 : 135,
                  child: Text(
                    isMarathi ? 'पिकवणारी पिके' : 'Crops Produced',
                    style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ),
                const Text(': ', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: _profile.cropsProduced.map((c) => Chip(
                      visualDensity: VisualDensity.compact,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                      backgroundColor: AppColors.saffron.withValues(alpha: 0.15),
                      side: const BorderSide(color: AppColors.saffron, width: 0.8),
                      label: Text(c, style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
        if (_profile.unemployedEducation.isNotEmpty || _profile.unemployedPreferredSector.isNotEmpty) ...[
          _buildDetailRow(isMarathi ? 'सर्वोच्च शिक्षण' : 'Highest Education', _profile.unemployedEducation.isNotEmpty ? _profile.unemployedEducation : '-', isCompact: isCompact),
          _buildDetailRow(isMarathi ? 'इच्छित क्षेत्र' : 'Preferred Sector', _profile.unemployedPreferredSector.isNotEmpty ? _profile.unemployedPreferredSector : '-', isCompact: isCompact),
          _buildDetailRow(isMarathi ? 'कौशल्ये/लायसन्स' : 'Skills / License', _profile.unemployedSkills.isNotEmpty ? _profile.unemployedSkills : '-', isCompact: isCompact),
          _buildDetailRow(isMarathi ? 'स्थलांतरास तयारी' : 'Relocate Readiness', _profile.willingToRelocate == true ? (isMarathi ? 'होय (Yes)' : 'Yes') : (isMarathi ? 'नाही (No)' : 'No'), isCompact: isCompact),
        ],
      ],
    );
  }

  Widget _buildOccupationEdit(bool isMarathi, {bool isDesktop = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profession Dropdown
        AppSearchableDropdown<String>(
          key: ValueKey('prof_$_selectedProfession'),
          value: _selectedProfession,
          labelText: isMarathi ? 'व्यवसाय / कार्यक्षेत्र निवडा' : 'Select Profession / Occupation',
          searchHint: isMarathi ? 'व्यवसाय शोधा...' : 'Search profession...',
          prefixIcon: const Icon(Icons.work_outline_rounded, color: AppColors.gold, size: 18),
          items: _professionOptions.map((opt) {
            return AppDropdownItem<String>(
              value: opt,
              label: opt,
              searchKey: opt,
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) setState(() => _selectedProfession = val);
          },
        ),
        const SizedBox(height: 12),

        // Subfields based on selection
        if (_selectedProfession.contains('नोकरी')) ...[
          _buildResponsivePair(
            isDesktop: isDesktop,
            child1: _buildInput(
              isMarathi ? 'नोकरीतील पद / हुद्दा *' : 'Job Designation *',
              _jobDesignationController,
              keyboardTitle: 'पद/हुद्दा',
            ),
            child2: _buildInput(
              isMarathi ? 'कंपनी / आस्थापना नाव *' : 'Company / Employer Name *',
              _jobCompanyController,
              keyboardTitle: 'कंपनी नाव',
            ),
          ),
        ] else if (_selectedProfession.contains('व्यवसाय')) ...[
          _buildInput(
            isMarathi ? 'व्यवसायाचे स्वरूप (उदा. किराणा, ऑटोमोबाईल, आयटी, हॉटेल) *' : 'Nature / Sector of Business *',
            _businessTypeController,
            keyboardTitle: 'व्यवसायाचे स्वरूप',
          ),
        ] else if (_selectedProfession.contains('विद्यार्थी')) ...[
          AppSearchableDropdown<String>(
            key: ValueKey('edu_$_selectedEducation'),
            value: _educationOptions.contains(_selectedEducation) ? _selectedEducation : _educationOptions.first,
            labelText: isMarathi ? 'शिक्षण स्तर / शाखा निवडा *' : 'Select Education Level *',
            searchHint: isMarathi ? 'शिक्षण शोधा...' : 'Search education...',
            prefixIcon: const Icon(Icons.school_outlined, color: AppColors.gold, size: 18),
            items: _educationOptions.map((e) => AppDropdownItem<String>(value: e, label: e, searchKey: e)).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedEducation = val);
            },
          ),
          if (_selectedEducation == 'इतर') ...[
            const SizedBox(height: 8),
            _buildInput(
              isMarathi ? 'शिक्षणाचा तपशील लिहा *' : 'Specify education *',
              _educationOtherController,
              isCompulsory: true,
              keyboardTitle: 'शिक्षण तपशील',
            ),
          ],
        ] else if (_selectedProfession.contains('शेती')) ...[
          Text(
            isMarathi ? 'पिकवत असलेली पिके (उदा. ऊस, सोयाबीन, कांदा) *' : 'Crops Produced *',
            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _cropInputController,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: isMarathi ? 'पिकाचे नाव लिहा...' : 'Type crop name...',
                    hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                    filled: true,
                    fillColor: AppColors.darkBgHeroTop,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.darkBorder)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.darkBorder)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.keyboard_alt_outlined, size: 16, color: AppColors.goldLight),
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      padding: const EdgeInsets.all(6),
                      visualDensity: VisualDensity.compact,
                      onPressed: () => MarathiVirtualKeyboard.show(context, controller: _cropInputController, title: 'पिकाचे नाव'),
                    ),
                  ),
                  onTap: () {
                    if (MarathiVirtualKeyboard.isOpen) {
                      MarathiVirtualKeyboard.dismiss();
                      SystemChannels.textInput.invokeMethod('TextInput.show');
                    } else {
                      SystemChannels.textInput.invokeMethod('TextInput.show');
                    }
                  },
                  onFieldSubmitted: (val) => _addCrop(val),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _addCrop(_cropInputController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.saffron,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(isMarathi ? 'जोडा' : 'Add', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Quick Crop Suggestion Chips
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: _quickCrops.map((crop) {
              return ActionChip(
                backgroundColor: AppColors.darkBgHeroTop,
                side: const BorderSide(color: AppColors.darkBorder, width: 0.6),
                label: Text('+ $crop', style: const TextStyle(fontSize: 10, color: AppColors.goldLight)),
                onPressed: () => _addCrop(crop),
              );
            }).toList(),
          ),
          if (_cropsProduced.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _cropsProduced.map((crop) => Chip(
                backgroundColor: AppColors.saffron.withValues(alpha: 0.2),
                side: const BorderSide(color: AppColors.saffron, width: 0.8),
                label: Text(crop, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                deleteIcon: const Icon(Icons.cancel_rounded, size: 14, color: Colors.redAccent),
                onDeleted: () => _removeCrop(crop),
              )).toList(),
            ),
          ],
        ] else if (_selectedProfession.contains('बेरोजगार')) ...[
          AppSearchableDropdown<String>(
            key: ValueKey('unemp_edu_$_unemployedEducation'),
            value: _educationOptions.contains(_unemployedEducation) ? _unemployedEducation : _educationOptions.first,
            labelText: isMarathi ? 'सर्वोच्च शिक्षण निवडा *' : 'Select Highest Education *',
            searchHint: isMarathi ? 'शिक्षण शोधा...' : 'Search education...',
            prefixIcon: const Icon(Icons.school_outlined, color: AppColors.gold, size: 18),
            items: _educationOptions.map((e) => AppDropdownItem<String>(value: e, label: e, searchKey: e)).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _unemployedEducation = val);
            },
          ),
          if (_unemployedEducation == 'इतर') ...[
            const SizedBox(height: 8),
            _buildInput(
              isMarathi ? 'शिक्षणाचा तपशील लिहा *' : 'Specify Education *',
              _unemployedEducationOtherController,
              isCompulsory: true,
              keyboardTitle: 'शिक्षण तपशील',
            ),
          ],
          const SizedBox(height: 8),
          _buildInput(
            isMarathi ? 'आवडीचे / इच्छित कार्यक्षेत्र' : 'Preferred Sector',
            _unemployedPreferredSectorController,
            keyboardTitle: 'इच्छित क्षेत्र',
          ),
          const SizedBox(height: 8),
          _buildInput(
            isMarathi ? 'विशेष कौशल्ये / संगणक / ड्रायव्हिंग इ.' : 'Skills & Licenses',
            _unemployedSkillsController,
            keyboardTitle: 'कौशल्ये',
          ),
          const SizedBox(height: 4),
          CheckboxListTile(
            value: _willingToRelocate,
            contentPadding: EdgeInsets.zero,
            activeColor: AppColors.saffron,
            title: Text(
              isMarathi ? 'कामासाठी दुसऱ्या शहरात स्थलांतरास तयार आहात का?' : 'Willing to relocate for work?',
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
            onChanged: (val) => setState(() => _willingToRelocate = val ?? true),
          ),
        ] else if (_selectedProfession.contains('इतर') || _selectedProfession.contains('Other')) ...[
          _buildInput(
            isMarathi ? 'आपला व्यवसाय / कार्यक्षेत्र लिहा *' : 'Specify Profession / Occupation *',
            _professionOtherController,
            isCompulsory: true,
            keyboardTitle: 'व्यवसाय/कार्यक्षेत्र',
          ),
        ],
      ],
    );
  }

  // ====================================================================
  // 5. EMERGENCY CONTACT & BLOOD GROUP: VIEW & EDIT
  // ====================================================================
  Widget _buildEmergencyView(bool isMarathi, {bool isCompact = false}) {
    return Column(
      children: [
        _buildDetailRow(
          isMarathi ? 'रक्तगट (Blood Group)' : 'Blood Group',
          _profile.bloodGroup.isNotEmpty ? _profile.bloodGroup : '-',
          valueColor: Colors.redAccent,
          isCompact: isCompact,
        ),
        _buildDetailRow(
          isMarathi ? 'आपत्कालीन संपर्क व्यक्ती' : 'Emergency Contact Name',
          _profile.emergencyContactName.isNotEmpty ? _profile.emergencyContactName : '-',
          isCompact: isCompact,
        ),
        _buildDetailRow(
          isMarathi ? 'आपत्कालीन संपर्क नंबर' : 'Emergency Phone',
          _profile.emergencyContactPhone.isNotEmpty ? _profile.emergencyContactPhone : '-',
          valueColor: AppColors.goldLight,
          isCompact: isCompact,
        ),
      ],
    );
  }

  Widget _buildEmergencyEdit(bool isMarathi, {bool isDesktop = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isMarathi ? 'रक्तगट निवडा *' : 'Select Blood Group *',
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: _bloodGroups.map((bg) {
            final isSelected = _selectedBloodGroup == bg;
            return ChoiceChip(
              label: Text(bg, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: isSelected ? Colors.white : AppColors.textSecondary)),
              selected: isSelected,
              selectedColor: Colors.redAccent.shade700,
              backgroundColor: AppColors.darkBgHeroTop,
              side: BorderSide(color: isSelected ? Colors.redAccent : AppColors.darkBorder),
              onSelected: (val) => setState(() => _selectedBloodGroup = val ? bg : ''),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        _buildResponsivePair(
          isDesktop: isDesktop,
          child1: _buildInput(
            isMarathi ? 'आपत्कालीन व्यक्ती नाव *' : 'Emergency Contact Name *',
            _emergencyNameController,
            keyboardTitle: 'आपत्कालीन व्यक्ती नाव',
          ),
          child2: _buildInput(
            isMarathi ? 'आपत्कालीन मोबाईल (१० अंक) *' : 'Emergency Phone (10 digits) *',
            _emergencyPhoneController,
            keyboardTitle: 'मोबाईल क्रमांक',
          ),
        ),
      ],
    );
  }

  // ====================================================================
  // 6. POLITICAL & NGO AFFILIATIONS: VIEW & EDIT
  // ====================================================================
  Widget _buildSocialView(bool isMarathi, {bool isCompact = false}) {
    return Column(
      children: [
        _buildDetailRow(
          isMarathi ? 'राजकीय सहभाग' : 'Politically Active',
          _profile.isPoliticallyActive == true
              ? '${_profile.politicalParty} (${_profile.politicalRole})'
              : (_profile.isPoliticallyActive == false ? (isMarathi ? 'नाही' : 'No') : '-'),
          isCompact: isCompact,
        ),
        _buildDetailRow(
          isMarathi ? 'सामाजिक संस्था / NGO सहभाग' : 'NGO Association',
          _profile.isAssociatedWithNgo == true
              ? '${_profile.ngoName} (${_profile.ngoRole})'
              : (_profile.isAssociatedWithNgo == false ? (isMarathi ? 'नाही' : 'No') : '-'),
          isCompact: isCompact,
        ),
      ],
    );
  }

  Widget _buildSocialEdit(bool isMarathi, {bool isDesktop = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Political Active
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 6,
          children: [
            Text(
              isMarathi ? 'राजकीय क्षेत्रात सक्रिय आहात का?' : 'Are you politically active?',
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChoiceChip(
                  label: Text(isMarathi ? 'होय (Yes)' : 'Yes'),
                  selected: _isPoliticallyActive == true,
                  selectedColor: AppColors.saffron,
                  backgroundColor: AppColors.darkBgHeroTop,
                  labelStyle: TextStyle(color: _isPoliticallyActive == true ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                  onSelected: (_) => setState(() => _isPoliticallyActive = true),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(isMarathi ? 'नाही (No)' : 'No'),
                  selected: _isPoliticallyActive == false,
                  selectedColor: AppColors.saffron,
                  backgroundColor: AppColors.darkBgHeroTop,
                  labelStyle: TextStyle(color: _isPoliticallyActive == false ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                  onSelected: (_) => setState(() => _isPoliticallyActive = false),
                ),
              ],
            ),
          ],
        ),
        if (_isPoliticallyActive == true) ...[
          const SizedBox(height: 8),
          _buildResponsivePair(
            isDesktop: isDesktop,
            child1: _buildInput(
              isMarathi ? 'राजकीय पक्ष / संघटना नाव' : 'Party / Organization Name',
              _politicalPartyController,
              keyboardTitle: 'पक्ष नाव',
            ),
            child2: _buildInput(
              isMarathi ? 'सध्याचे पद / जबाबदारी' : 'Post / Designation',
              _politicalRoleController,
              keyboardTitle: 'पद / जबाबदारी',
            ),
          ),
        ],
        const SizedBox(height: 14),

        // NGO Active
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 6,
          children: [
            Text(
              isMarathi ? 'इतर सामाजिक / अशासकीय संस्थेत कार्यरत आहात का?' : 'Working for any social / NGO organization?',
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChoiceChip(
                  label: Text(isMarathi ? 'होय (Yes)' : 'Yes'),
                  selected: _isAssociatedWithNgo == true,
                  selectedColor: AppColors.saffron,
                  backgroundColor: AppColors.darkBgHeroTop,
                  labelStyle: TextStyle(color: _isAssociatedWithNgo == true ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                  onSelected: (_) => setState(() => _isAssociatedWithNgo = true),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(isMarathi ? 'नाही (No)' : 'No'),
                  selected: _isAssociatedWithNgo == false,
                  selectedColor: AppColors.saffron,
                  backgroundColor: AppColors.darkBgHeroTop,
                  labelStyle: TextStyle(color: _isAssociatedWithNgo == false ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                  onSelected: (_) => setState(() => _isAssociatedWithNgo = false),
                ),
              ],
            ),
          ],
        ),
        if (_isAssociatedWithNgo == true) ...[
          const SizedBox(height: 8),
          _buildResponsivePair(
            isDesktop: isDesktop,
            child1: _buildInput(
              isMarathi ? 'सामाजिक संस्थेचे नाव' : 'NGO / Organization Name',
              _ngoNameController,
              keyboardTitle: 'संस्थेचे नाव',
            ),
            child2: _buildInput(
              isMarathi ? 'संस्थेतील पद / कार्य' : 'Designation / Role',
              _ngoRoleController,
              keyboardTitle: 'पद / कार्य',
            ),
          ),
        ],
      ],
    );
  }

  // ====================================================================
  // 7. ORGAN DONATION PLEDGE: VIEW & EDIT
  // ====================================================================
  Widget _buildOrganView(bool isMarathi, {bool isCompact = false}) {
    if (_profile.isOrganDonorPledged) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink.shade900.withValues(alpha: 0.3),
              AppColors.saffron.withValues(alpha: 0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.pinkAccent.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            const Icon(Icons.volunteer_activism_rounded, color: Colors.pinkAccent, size: 26),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMarathi ? '🏅 मरणोत्तर अवयवदान संकल्पित सदस्य' : '🏅 Pledged Organ Donor',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.pinkAccent),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    isMarathi
                        ? 'दुसऱ्याला जीवनदान देण्याचा उदात्त संकल्प आपण स्वीकारला आहे.'
                        : 'You have pledged to give the gift of life by donating organs.',
                    style: const TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return _buildDetailRow(
      isMarathi ? 'संकल्प स्थिती' : 'Pledge Status',
      _profile.hasOrganDonationConsentAnswered ? (isMarathi ? 'नाही' : 'No') : (isMarathi ? 'नोंद नाही' : 'Not recorded'),
      isCompact: isCompact,
    );
  }

  Widget _buildOrganEdit(bool isMarathi) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkBgHeroTop,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.pink.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite_rounded, color: Colors.pinkAccent, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isMarathi ? 'मरणोत्तर अवयवदान संकल्प' : 'Organ Donation Pledge',
                  style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            isMarathi
                ? '"अवयवदान हेच जीवनदान" — आपल्या मरणोत्तर डोळे, मूत्रपिंड, यकृत व इतर अवयव गरजवंतांना नवे आयुष्य देऊ शकतात. आपण मरणोत्तर अवयवदानाचा संकल्प करू इच्छिता का?'
                : '"Organ donation is the ultimate gift of life." Would you like to pledge your organs after death to save someone\'s life?',
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, height: 1.4),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: Text(isMarathi ? 'होय, मी संकल्प करतो (Yes)' : 'Yes, I Pledge'),
                selected: _isOrganDonorPledged,
                selectedColor: Colors.pinkAccent.shade700,
                backgroundColor: AppColors.darkSurface,
                labelStyle: TextStyle(color: _isOrganDonorPledged ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                onSelected: (val) {
                  setState(() {
                    _isOrganDonorPledged = val;
                    _hasOrganDonationConsentAnswered = true;
                  });
                },
              ),
              ChoiceChip(
                label: Text(isMarathi ? 'नाही (No)' : 'No'),
                selected: !_isOrganDonorPledged && _hasOrganDonationConsentAnswered,
                selectedColor: AppColors.saffron,
                backgroundColor: AppColors.darkSurface,
                labelStyle: TextStyle(color: (!_isOrganDonorPledged && _hasOrganDonationConsentAnswered) ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                onSelected: (_) {
                  setState(() {
                    _isOrganDonorPledged = false;
                    _hasOrganDonationConsentAnswered = true;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // OFFICIAL ID CARD PREVIEW
  // ====================================================================
  Widget _buildIdCardSection(bool isMarathi) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goldLight.withValues(alpha: 0.5), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.12),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.badge_rounded, color: AppColors.goldLight, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    isMarathi ? 'आपले डिजिटल ओळखपत्र' : 'Your Digital ID Card',
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldLight,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.greenAccent, width: 0.8),
                ),
                child: Text(
                  isMarathi ? '✓ सक्रिय' : '✓ Active',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.greenAccent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: MemberIdCardWidget(profile: _profile),
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // HELPER WIDGETS
  // ====================================================================
  Widget _buildDetailRow(String label, String value, {Color? valueColor, bool isCompact = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: isCompact ? 105 : 135,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
          ),
          const Text(': ', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          Expanded(
            child: SelectableText(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(
    String label,
    TextEditingController controller, {
    ValueChanged<String>? onChanged,
    bool showKeyboardIcon = true,
    String? keyboardTitle,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? customSuffixIcon,
    int maxLines = 1,
    bool isCompulsory = false,
    String? Function(String?)? validator,
    String? errorMessage,
  }) {
    final cleanLabel = label.replaceAll('*', '').trim();
    final requiresStar = isCompulsory || label.contains('*');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(cleanLabel, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            if (requiresStar) ...[
              const SizedBox(width: 4),
              const Text(
                '*',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.errorColor,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: () {
            if (MarathiVirtualKeyboard.isOpen) {
              MarathiVirtualKeyboard.dismiss();
              SystemChannels.textInput.invokeMethod('TextInput.show');
            } else {
              SystemChannels.textInput.invokeMethod('TextInput.show');
            }
            onTap?.call();
          },
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          validator: validator ??
              (requiresStar
                  ? (val) {
                      if (val == null || val.trim().isEmpty) {
                        return errorMessage ?? '$cleanLabel required';
                      }
                      return null;
                    }
                  : null),
          decoration: _inputDecoration(
            suffixIcon: customSuffixIcon ??
                (showKeyboardIcon
                    ? IconButton(
                        icon: const Icon(Icons.keyboard_alt_outlined, size: 16, color: AppColors.goldLight),
                        tooltip: 'मराठी कीबोर्ड',
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        padding: const EdgeInsets.all(6),
                        visualDensity: VisualDensity.compact,
                        splashRadius: 18,
                        onPressed: () {
                          MarathiVirtualKeyboard.show(
                            context,
                            controller: controller,
                            title: keyboardTitle ?? cleanLabel,
                          );
                        },
                      )
                    : null),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({Widget? suffixIcon, Widget? prefixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.darkBgHeroTop,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.darkBorder)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.darkBorder)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.gold, width: 1.2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.errorColor, width: 1.2)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.errorColor, width: 1.4)),
      errorStyle: const TextStyle(fontSize: 10, color: AppColors.errorColor),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
    );
  }
}
