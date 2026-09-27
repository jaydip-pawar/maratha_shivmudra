import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:maratha_shivmudra/core/base/bloc/bloc_base/bloc_base.dart';
import 'package:maratha_shivmudra/core/base/bloc/event/base_event.dart';
import 'package:maratha_shivmudra/core/base/bloc/state/base_state.dart';
import 'package:maratha_shivmudra/core/constants/geo_constants.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/mixins/get_it_helper_mixin.dart';
import 'package:maratha_shivmudra/core/services/referral_service.dart';
import 'package:maratha_shivmudra/core/services/user_session_service.dart';
import 'package:maratha_shivmudra/core/utils/bilingual_helper.dart';

part 'form_event.dart';
part 'form_state.dart';

@injectable
class MemberFormBloc extends BlocBase<MemberFormEvent, MemberFormState>
    with GetItHelperMixin {
  MemberFormBloc() : super(MemberFormState()) {
    stateController.text = selectedState.value.nameEn;
    _initLiveTransliteration();
    firstNameMrController.addListener(() {
      if (firstNameMrFocusNode.hasFocus) {
        isFirstNameMrManuallyEdited = true;
      }
    });
    middleNameMrController.addListener(() {
      if (middleNameMrFocusNode.hasFocus) {
        isMiddleNameMrManuallyEdited = true;
      }
    });
    lastNameMrController.addListener(() {
      if (lastNameMrFocusNode.hasFocus) {
        isLastNameMrManuallyEdited = true;
      }
    });
    villageMrController.addListener(() {
      if (villageMrFocusNode.hasFocus) {
        isVillageMrManuallyEdited = true;
      }
    });
    addressMrController.addListener(() {
      if (addressMrFocusNode.hasFocus) {
        isAddressMrManuallyEdited = true;
      }
    });
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  // User-editable Marathi Name Controllers (Gov-Form Style)
  final TextEditingController firstNameMrController = TextEditingController();
  final TextEditingController middleNameMrController = TextEditingController();
  final TextEditingController lastNameMrController = TextEditingController();

  // FocusNodes to keep fields focused when virtual keyboard is used
  final FocusNode firstNameMrFocusNode = FocusNode();
  final FocusNode middleNameMrFocusNode = FocusNode();
  final FocusNode lastNameMrFocusNode = FocusNode();

  // Village Marathi Controller & FocusNode
  final TextEditingController villageMrController = TextEditingController();
  final FocusNode villageMrFocusNode = FocusNode();

  // Address Marathi Controller & FocusNode
  final TextEditingController addressMrController = TextEditingController();
  final FocusNode addressMrFocusNode = FocusNode();

  Timer? _fNameDebounce;
  Timer? _mNameDebounce;
  Timer? _lNameDebounce;
  Timer? _villageDebounce;
  Timer? _addressDebounce;
  bool isFirstNameMrManuallyEdited = false;
  bool isMiddleNameMrManuallyEdited = false;
  bool isLastNameMrManuallyEdited = false;
  bool isVillageMrManuallyEdited = false;
  bool isAddressMrManuallyEdited = false;
  bool _isDisposed = false;

  void _initLiveTransliteration() {
    firstNameController.addListener(_onFirstNameChanged);
    middleNameController.addListener(_onMiddleNameChanged);
    lastNameController.addListener(_onLastNameChanged);
    villageController.addListener(_onVillageChanged);
    addressController.addListener(_onAddressChanged);
  }

  void _onFirstNameChanged() {
    if (isFirstNameMrManuallyEdited) return;
    _fNameDebounce?.cancel();
    _fNameDebounce = Timer(const Duration(milliseconds: 300), () async {
      final en = firstNameController.text.trim();
      if (en.isNotEmpty && !isFirstNameMrManuallyEdited) {
        final mr = await BilingualHelper.transliterateLive(en);
        if (!isFirstNameMrManuallyEdited) {
          firstNameMrController.text = mr;
        }
      } else if (en.isEmpty && !isFirstNameMrManuallyEdited) {
        firstNameMrController.clear();
      }
    });
  }

  void _onMiddleNameChanged() {
    if (isMiddleNameMrManuallyEdited) return;
    _mNameDebounce?.cancel();
    _mNameDebounce = Timer(const Duration(milliseconds: 300), () async {
      final en = middleNameController.text.trim();
      if (en.isNotEmpty && !isMiddleNameMrManuallyEdited) {
        final mr = await BilingualHelper.transliterateLive(en);
        if (!isMiddleNameMrManuallyEdited) {
          middleNameMrController.text = mr;
        }
      } else if (en.isEmpty && !isMiddleNameMrManuallyEdited) {
        middleNameMrController.clear();
      }
    });
  }

  void _onLastNameChanged() {
    if (isLastNameMrManuallyEdited) return;
    _lNameDebounce?.cancel();
    _lNameDebounce = Timer(const Duration(milliseconds: 300), () async {
      final en = lastNameController.text.trim();
      if (en.isNotEmpty && !isLastNameMrManuallyEdited) {
        final mr = await BilingualHelper.transliterateLive(en);
        if (!isLastNameMrManuallyEdited) {
          lastNameMrController.text = mr;
        }
      } else if (en.isEmpty && !isLastNameMrManuallyEdited) {
        lastNameMrController.clear();
      }
    });
  }

  void _onVillageChanged() {
    if (isVillageMrManuallyEdited) return;
    _villageDebounce?.cancel();
    _villageDebounce = Timer(const Duration(milliseconds: 300), () async {
      final en = villageController.text.trim();
      if (en.isNotEmpty && !isVillageMrManuallyEdited) {
        final mr = await BilingualHelper.transliterateLive(en);
        if (!isVillageMrManuallyEdited) {
          villageMrController.text = mr;
        }
      } else if (en.isEmpty && !isVillageMrManuallyEdited) {
        villageMrController.clear();
      }
    });
  }

  void _onAddressChanged() {
    if (isAddressMrManuallyEdited) return;
    _addressDebounce?.cancel();
    _addressDebounce = Timer(const Duration(milliseconds: 300), () async {
      final en = addressController.text.trim();
      if (en.isNotEmpty && !isAddressMrManuallyEdited) {
        final mr = await BilingualHelper.transliterateLive(en);
        if (!isAddressMrManuallyEdited) {
          addressMrController.text = mr;
        }
      } else if (en.isEmpty && !isAddressMrManuallyEdited) {
        addressMrController.clear();
      }
    });
  }

  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController subDistrictController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Cascading Location Notifiers
  final ValueNotifier<StateInfo> selectedState =
      ValueNotifier<StateInfo>(GeoConstants.defaultState);
  final ValueNotifier<DistrictInfo?> selectedDistrict =
      ValueNotifier<DistrictInfo?>(null);
  final ValueNotifier<TalukaInfo?> selectedTaluka =
      ValueNotifier<TalukaInfo?>(null);

  // Occupation Specific Controllers & Notifiers
  // 1. Job (नोकरी)
  final TextEditingController jobDesignationController = TextEditingController();
  final TextEditingController jobCompanyController = TextEditingController();

  // 2. Business (व्यवसाय)
  final TextEditingController businessTypeController = TextEditingController();

  // 3. Education (विद्यार्थी / शिक्षण)
  final ValueNotifier<String?> selectedEducation = ValueNotifier<String?>(null);
  final TextEditingController educationOtherController = TextEditingController();

  // 4. Farmer (शेती)
  final TextEditingController cropInputController = TextEditingController();
  final ValueNotifier<List<String>> cropsList = ValueNotifier<List<String>>([]);

  void addCrop(String crop) {
    final c = crop.trim();
    if (c.isEmpty) return;
    if (!cropsList.value.contains(c)) {
      cropsList.value = [...cropsList.value, c];
    }
    cropInputController.clear();
  }

  void removeCrop(String crop) {
    cropsList.value = cropsList.value.where((item) => item != crop).toList();
  }

  // 5. Unemployed (बेरोजगार)
  final ValueNotifier<String?> unemployedEducation = ValueNotifier<String?>(null);
  final TextEditingController unemployedEducationOtherController = TextEditingController();
  final TextEditingController unemployedPreferredSectorController = TextEditingController();
  final TextEditingController unemployedSkillsController = TextEditingController();
  final ValueNotifier<bool> willingToRelocate = ValueNotifier<bool>(true);

  final ValueNotifier<bool> showDropDown = ValueNotifier(true);
  final ValueNotifier<bool> showErrorNotifier = ValueNotifier(false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<String> livingNotifier = ValueNotifier<String>('');
  String living = '';
  String mobileNumber = '';

  void onLivingChanged(String val) {
    living = val;
    livingNotifier.value = val;
  }

  void onStateSelected(StateInfo state, {bool isMarathi = false}) {
    selectedState.value = state;
    selectedDistrict.value = null;
    selectedTaluka.value = null;
    stateController.text = isMarathi ? state.nameMr : state.nameEn;
    districtController.clear();
    subDistrictController.clear();
  }

  void onDistrictSelected(DistrictInfo? district, {bool isMarathi = false}) {
    selectedDistrict.value = district;
    selectedTaluka.value = null;
    if (district != null) {
      districtController.text = isMarathi ? district.nameMr : district.nameEn;
    } else {
      districtController.clear();
    }
    subDistrictController.clear();
  }

  void onTalukaSelected(TalukaInfo? taluka, {bool isMarathi = false}) {
    selectedTaluka.value = taluka;
    if (taluka != null) {
      subDistrictController.text = isMarathi ? taluka.nameMr : taluka.nameEn;
      if (cityController.text.trim().isEmpty) {
        cityController.text = isMarathi ? taluka.nameMr : taluka.nameEn;
      }
    } else {
      subDistrictController.clear();
    }
  }

  Future<void> setMobileNumber() async {
    final ss = getIt<SecureStorage>();
    final storedNumber =
        getData<String>('mobileNumber') ?? await ss.getMobileNumber();
    if (_isDisposed || isClosed) return;
    if (storedNumber.trim().isNotEmpty) {
      mobileNoController.text = storedNumber.trim();
      mobileNumber = storedNumber.trim();
    }
  }

  @override
  void init() {
    super.init();
    setMobileNumber();
    jobCompanyController.addListener(_onSelfEmployedFieldChanged);
    businessTypeController.addListener(_onSelfEmployedFieldChanged);
  }

  void _onSelfEmployedFieldChanged() {
    jobDesignationController.notifyListeners();
  }

  @override
  void mapEventToState() {
    on<GetArticlesEvent>((event, emit) {
      emit(state.copyWith(list: event.list));
    });
  }

  bool validate() {
    final fName = firstNameController.text.trim();
    final mName = middleNameController.text.trim();
    final lName = lastNameController.text.trim();
    final fNameMr = firstNameMrController.text.trim();
    final mNameMr = middleNameMrController.text.trim();
    final lNameMr = lastNameMrController.text.trim();

    final basicValid = fName.isNotEmpty &&
        mName.isNotEmpty &&
        lName.isNotEmpty &&
        fNameMr.isNotEmpty &&
        mNameMr.isNotEmpty &&
        lNameMr.isNotEmpty &&
        dateOfBirthController.text.trim().isNotEmpty &&
        addressController.text.trim().isNotEmpty &&
        addressMrController.text.trim().isNotEmpty &&
        (selectedState.value.districts.isEmpty || selectedDistrict.value != null) &&
        ((selectedDistrict.value?.talukas.isEmpty ?? true) || selectedTaluka.value != null) &&
        pincodeController.text.trim().isNotEmpty &&
        living.trim().isNotEmpty &&
        mobileNoController.text.trim().isNotEmpty;

    if (!basicValid) return false;

    // Name character checks (English characters only for EN, Marathi letters only for MR, no numbers, spaces or symbols)
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(fName) ||
        !RegExp(r'^[a-zA-Z]+$').hasMatch(mName) ||
        !RegExp(r'^[a-zA-Z]+$').hasMatch(lName)) {
      return false;
    }
    final mrNamePattern = RegExp(r'^[\u0900-\u0963\u0971-\u097F\u200C\u200D]+$');
    final digitPattern = RegExp(r'[0-9\u0966-\u096F]');
    if (!mrNamePattern.hasMatch(fNameMr) || digitPattern.hasMatch(fNameMr) ||
        !mrNamePattern.hasMatch(mNameMr) || digitPattern.hasMatch(mNameMr) ||
        !mrNamePattern.hasMatch(lNameMr) || digitPattern.hasMatch(lNameMr)) {
      return false;
    }

    // Pincode: 6 digits only
    final cleanPin = _normalizeDigits(pincodeController.text);
    if (cleanPin.length != 6 || !RegExp(r'^\d{6}$').hasMatch(cleanPin)) {
      return false;
    }

    // Village locality mutual presence & characters only
    final vEn = villageController.text.trim();
    final vMr = villageMrController.text.trim();
    if ((vEn.isNotEmpty && vMr.isEmpty) || (vMr.isNotEmpty && vEn.isEmpty)) {
      return false;
    }
    if (vEn.isNotEmpty && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(vEn)) {
      return false;
    }
    final mrVillagePattern = RegExp(r'^[\u0900-\u0963\u0971-\u097F\u200C\u200D\s]+$');
    if (vMr.isNotEmpty && (!mrVillagePattern.hasMatch(vMr) || digitPattern.hasMatch(vMr))) {
      return false;
    }

    // Mobile: 10 digits
    final cleanMobile = mobileNoController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanMobile.length != 10) {
      return false;
    }

    // Email: valid email regex if provided
    final email = emailController.text.trim();
    if (email.isNotEmpty &&
        !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      return false;
    }

    // Occupation subfields compulsory validation
    final l = living.toLowerCase();
    final isUnemployed = l == 'बेरोजगार' ||
        l == 'unemployed' ||
        l == 'नोकरी शोधत आहे' ||
        l == 'job-seeker';
    final isSelfEmployed = l == 'स्वयंरोजगार' || l == 'self-employed';
    final isJobOnly = (l == 'नोकरी' || l == 'employed') && !isSelfEmployed;
    final isBusinessOnly = (l == 'व्यवसाय' || l == 'business') && !isSelfEmployed;
    final isStudent = l == 'विद्यार्थी' || l == 'student' || l.contains('शिक्षण');
    final isFarmer = l == 'शेती' || l == 'farmer' || l.contains('शेतकरी');

    if (isJobOnly) {
      if (jobDesignationController.text.trim().isEmpty ||
          jobCompanyController.text.trim().isEmpty) {
        return false;
      }
    }
    if (isBusinessOnly) {
      if (businessTypeController.text.trim().isEmpty) {
        return false;
      }
    }
    if (isSelfEmployed) {
      final hasDesignation = jobDesignationController.text.trim().isNotEmpty;
      final hasCompany = jobCompanyController.text.trim().isNotEmpty;
      final hasBusinessType = businessTypeController.text.trim().isNotEmpty;
      if (!hasDesignation && !hasCompany && !hasBusinessType) {
        return false;
      }
    }
    if (isStudent) {
      if (selectedEducation.value == null || selectedEducation.value!.trim().isEmpty) {
        return false;
      }
      final edu = selectedEducation.value!;
      if ((edu.startsWith('इतर') || edu.startsWith('Other')) &&
          educationOtherController.text.trim().isEmpty) {
        return false;
      }
    }
    if (isFarmer) {
      if (cropsList.value.isEmpty && cropInputController.text.trim().isEmpty) {
        return false;
      }
    }
    if (isUnemployed) {
      if (unemployedEducation.value == null || unemployedEducation.value!.trim().isEmpty) {
        return false;
      }
      final uEdu = unemployedEducation.value!;
      if ((uEdu.startsWith('इतर') || uEdu.startsWith('Other')) &&
          unemployedEducationOtherController.text.trim().isEmpty) {
        return false;
      }
      if (unemployedPreferredSectorController.text.trim().isEmpty) {
        return false;
      }
    }

    return true;
  }

  static String _normalizeDigits(String input) {
    const devanagari = ['०', '१', '२', '३', '४', '५', '६', '७', '८', '९'];
    String res = input;
    for (int i = 0; i < 10; i++) {
      res = res.replaceAll(devanagari[i], i.toString());
    }
    return res.trim();
  }

  Future<bool> setFormData() async {
    final phone = mobileNoController.text.trim().isNotEmpty
        ? mobileNoController.text.trim()
        : mobileNumber.trim();

    if (phone.isEmpty) {
      debugPrint('Error: Mobile number is empty');
      return false;
    }

    final rawStateInfo = selectedState.value;
    final rawDistrictInfo = selectedDistrict.value;
    final rawTalukaInfo = selectedTaluka.value;

    if (rawDistrictInfo == null || rawTalukaInfo == null) {
      debugPrint('Error: District or Taluka is not selected');
      return false;
    }

    // Canonical Geo Resolution to guarantee 100% correct bilingual hierarchy
    final canonicalState = GeoConstants.findState(rawStateInfo.code) ??
        GeoConstants.findState(rawStateInfo.nameEn) ??
        GeoConstants.defaultState;

    final canonicalDistrict = canonicalState.districts.firstWhere(
      (d) =>
          d.code.toLowerCase() == rawDistrictInfo.code.toLowerCase() ||
          d.nameEn.toLowerCase() == rawDistrictInfo.nameEn.toLowerCase() ||
          d.nameMr == rawDistrictInfo.nameMr,
      orElse: () => rawDistrictInfo,
    );

    final canonicalTaluka = canonicalDistrict.talukas.firstWhere(
      (t) =>
          t.nameEn.toLowerCase() == rawTalukaInfo.nameEn.toLowerCase() ||
          t.nameMr == rawTalukaInfo.nameMr ||
          t.nameMr == rawTalukaInfo.nameEn,
      orElse: () => rawTalukaInfo,
    );

    // Safeguard: Ensure state_mr is never district name
    final stateMrSafe = (canonicalState.nameMr.isNotEmpty &&
            canonicalState.nameMr != canonicalDistrict.nameMr)
        ? canonicalState.nameMr
        : 'महाराष्ट्र';

    // Safeguard: Ensure taluka_mr is never district name (unless taluka actually equals district, e.g. Pune/Thane)
    final talukaMrSafe = (canonicalTaluka.nameMr.isNotEmpty &&
            (canonicalTaluka.nameMr != canonicalDistrict.nameMr ||
                canonicalTaluka.nameEn.toLowerCase() == canonicalDistrict.nameEn.toLowerCase()))
        ? canonicalTaluka.nameMr
        : (canonicalDistrict.talukas.firstWhere(
            (t) => t.nameEn.toLowerCase() == canonicalTaluka.nameEn.toLowerCase(),
            orElse: () => canonicalTaluka,
          ).nameMr);

    final fName = firstNameController.text.trim();
    final mName = middleNameController.text.trim();
    final lName = lastNameController.text.trim();
    final fullName = '$fName ${mName.isNotEmpty ? "$mName " : ""}$lName'.trim();

    // User-verified Marathi names (Gov-Form Style)
    final fNameMr = firstNameMrController.text.trim().isNotEmpty
        ? firstNameMrController.text.trim()
        : BilingualHelper.transliterateToMarathi(fName);
    final mNameMr = middleNameMrController.text.trim().isNotEmpty
        ? middleNameMrController.text.trim()
        : BilingualHelper.transliterateToMarathi(mName);
    final lNameMr = lastNameMrController.text.trim().isNotEmpty
        ? lastNameMrController.text.trim()
        : BilingualHelper.transliterateToMarathi(lName);
    final fullNameMr =
        [fNameMr, mNameMr, lNameMr].where((s) => s.isNotEmpty).join(' ');

    final referralId = Uri.base.queryParameters['ref'] ?? 'NONE';

    // Verify referral quota if a referral link is active
    if (referralId.isNotEmpty && referralId.toUpperCase() != 'NONE') {
      final validation =
          await ReferralService.instance.validateReferral(referralId);
      if (validation == ReferralValidationResult.limitExhausted ||
          validation == ReferralValidationResult.inactive) {
        debugPrint('Referral link invalid or quota exhausted: $referralId');
      }
    }

    final normalizedPin = _normalizeDigits(pincodeController.text);
    final village = villageController.text.trim();
    final villageMr = villageMrController.text.trim().isNotEmpty
        ? villageMrController.text.trim()
        : BilingualHelper.transliterateToMarathi(village);
    final address = addressController.text.trim();
    final addressMr = addressMrController.text.trim().isNotEmpty
        ? addressMrController.text.trim()
        : BilingualHelper.transliterateToMarathi(address);

    final searchTokens = BilingualHelper.generateSearchTokens(
      nameEn: fullName,
      nameMr: fullNameMr,
      phone: phone,
      memberId: 'PENDING',
      district: canonicalDistrict.nameEn,
      taluka: canonicalTaluka.nameEn,
      village: '$village $villageMr'.trim(),
    );

    final db = FirebaseFirestore.instance;
    final memberRef = db.collection('members').doc(phone);
    final memberSnap = await memberRef.get();

    final occRaw = living.trim();
    final occLower = occRaw.toLowerCase();

    final isUnemployed = occLower == 'बेरोजगार' ||
        occLower == 'unemployed' ||
        occLower == 'नोकरी शोधत आहे' ||
        occLower == 'job-seeker';
    final isSelfEmployed = occLower == 'स्वयंरोजगार' || occLower == 'self-employed';
    final isJob = (occLower == 'नोकरी' || occLower == 'employed') || isSelfEmployed;
    final isBusiness = (occLower == 'व्यवसाय' || occLower == 'business') || isSelfEmployed;
    final isStudent = occLower == 'विद्यार्थी' || occLower == 'student' || occLower.contains('शिक्षण');
    final isFarmer = occLower == 'शेती' || occLower == 'farmer' || occLower.contains('शेतकरी');
    final isRetired = occLower == 'निवृत्त' || occLower == 'retired';
    final isHomemaker = occLower == 'गृहपालक' || occLower == 'homemaker';

    String occCategory = 'other';
    if (isSelfEmployed) {
      occCategory = 'self_employed';
    } else if (isJob) {
      occCategory = 'job';
    } else if (isBusiness) {
      occCategory = 'business';
    } else if (isStudent) {
      occCategory = 'student';
    } else if (isFarmer) {
      occCategory = 'farmer';
    } else if (isUnemployed) {
      occCategory = 'unemployed';
    } else if (isRetired) {
      occCategory = 'retired';
    } else if (isHomemaker) {
      occCategory = 'homemaker';
    }

    final Map<String, dynamic> occMap = {
      'category': occCategory,
      'category_mr': occRaw,
    };

    if (isJob) {
      if (jobDesignationController.text.trim().isNotEmpty || jobCompanyController.text.trim().isNotEmpty || !isSelfEmployed) {
        occMap['job_details'] = {
          'designation': jobDesignationController.text.trim(),
          'company': jobCompanyController.text.trim(),
        };
      }
    }
    if (isBusiness) {
      if (businessTypeController.text.trim().isNotEmpty || !isSelfEmployed) {
        occMap['business_details'] = {
          'business_type': businessTypeController.text.trim(),
        };
      }
    }
    if (isStudent) {
      occMap['student_details'] = {
        'qualification': (selectedEducation.value == 'Other' || selectedEducation.value == 'इतर')
            ? educationOtherController.text.trim()
            : (selectedEducation.value ?? ''),
        'qualification_other': educationOtherController.text.trim(),
      };
    }
    if (isFarmer) {
      occMap['farming_details'] = {
        'crops_produced': cropsList.value,
      };
    }
    if (isUnemployed) {
      final unempEdu = unemployedEducation.value ?? '';
      occMap['unemployed_details'] = {
        'highest_qualification': unempEdu,
        if (unempEdu.startsWith('Other') || unempEdu.startsWith('इतर'))
          'qualification_other': unemployedEducationOtherController.text.trim(),
        'preferred_sector': unemployedPreferredSectorController.text.trim(),
        'skills_and_licenses': unemployedSkillsController.text.trim(),
        'willing_to_relocate': willingToRelocate.value,
      };
    }

    final memberData = {
      'personal': {
        'first_name_en': fName,
        'first_name_mr': fNameMr,
        'middle_name_en': mName,
        'middle_name_mr': mNameMr,
        'last_name_en': lName,
        'last_name_mr': lNameMr,
        'full_name_en': fullName,
        'full_name_mr': fullNameMr,
        'date_of_birth': dateOfBirthController.text.trim(),
        'email': emailController.text.trim(),
        'gender': null,
        'living_status': null,
      },
      'residence': {
        'address_en': address,
        'address_mr': addressMr,
        'village_en': village,
        'village_mr': villageMr,
        'taluka_en': canonicalTaluka.nameEn,
        'taluka_mr': talukaMrSafe,
        'district_en': canonicalDistrict.nameEn,
        'district_mr': canonicalDistrict.nameMr,
        'district_code': canonicalDistrict.code,
        'state_en': canonicalState.nameEn,
        'state_mr': stateMrSafe,
        'state_code': canonicalState.code,
        'pincode': normalizedPin,
      },
      'native_place': {
        'is_same_as_current': false,
      },
      'occupation': occMap,
      'emergency': {
        'blood_group': null,
        'contact_name': null,
        'contact_phone': null,
      },
      'affiliations': {
        'is_politically_active': null,
        'political_party': null,
        'political_role': null,
        'is_associated_with_ngo': null,
        'ngo_name': null,
        'ngo_role': null,
      },
      'pledges': {
        'has_answered_organ_donation': false,
        'is_organ_donor_pledged': false,
      },
      'official': {
        'is_official': false,
      },
      'media': {
        'photo_base64': null,
        'photo_url': null,
      },
      'membership': {
        'phone': phone,
        'member_id': 'PENDING',
        'referral_id': referralId,
        'role_type': 'member',
        'designation': '',
        'is_registered': true,
        'is_profile_complete': false,
        'is_card_issued': false,
        'is_valid': true,
      },
      'search_tokens': searchTokens,
      'updated_at': FieldValue.serverTimestamp(),
      if (!memberSnap.exists) 'created_at': FieldValue.serverTimestamp(),
    };

    try {
      await memberRef.set(memberData, SetOptions(merge: true));

      // Atomically track referral campaign usage
      if (referralId.isNotEmpty && referralId.toUpperCase() != 'NONE') {
        await ReferralService.instance.recordReferralUse(
          rawCode: referralId,
          userPhone: phone,
        );
      }

      await UserSessionService.instance.onFormSubmitted();
      return true;
    } catch (e) {
      debugPrint('Firestore setFormData error: $e');
      return false;
    }
  }

  @override
  Future<void> close() {
    _isDisposed = true;
    _fNameDebounce?.cancel();
    _mNameDebounce?.cancel();
    _lNameDebounce?.cancel();
    _villageDebounce?.cancel();
    _addressDebounce?.cancel();
    addressController.removeListener(_onAddressChanged);
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    firstNameMrController.dispose();
    middleNameMrController.dispose();
    lastNameMrController.dispose();
    firstNameMrFocusNode.dispose();
    middleNameMrFocusNode.dispose();
    lastNameMrFocusNode.dispose();
    dateOfBirthController.dispose();
    addressController.dispose();
    addressMrController.dispose();
    addressMrFocusNode.dispose();
    villageController.dispose();
    villageMrController.dispose();
    villageMrFocusNode.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    districtController.dispose();
    subDistrictController.dispose();
    mobileNoController.dispose();
    emailController.dispose();
    jobCompanyController.removeListener(_onSelfEmployedFieldChanged);
    businessTypeController.removeListener(_onSelfEmployedFieldChanged);
    jobDesignationController.dispose();
    jobCompanyController.dispose();
    businessTypeController.dispose();
    selectedEducation.dispose();
    educationOtherController.dispose();
    cropInputController.dispose();
    cropsList.dispose();
    unemployedEducation.dispose();
    unemployedEducationOtherController.dispose();
    unemployedPreferredSectorController.dispose();
    unemployedSkillsController.dispose();
    willingToRelocate.dispose();
    livingNotifier.dispose();
    selectedState.dispose();
    selectedDistrict.dispose();
    selectedTaluka.dispose();
    showDropDown.dispose();
    showErrorNotifier.dispose();
    return super.close();
  }
}
