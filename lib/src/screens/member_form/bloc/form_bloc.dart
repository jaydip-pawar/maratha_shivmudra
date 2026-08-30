import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:maratha_shivmudra/core/base/bloc/bloc_base/bloc_base.dart';
import 'package:maratha_shivmudra/core/base/bloc/event/base_event.dart';
import 'package:maratha_shivmudra/core/base/bloc/state/base_state.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/mixins/get_it_helper_mixin.dart';

part 'form_event.dart';
part 'form_state.dart';

@injectable
class MemberFormBloc extends BlocBase<MemberFormEvent, MemberFormState>
    with GetItHelperMixin {
  MemberFormBloc() : super(MemberFormState()) {
    stateController.addListener(_onStateChanged);
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController subDistrictController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ValueNotifier<bool> showDropDown = ValueNotifier(true);
  final ValueNotifier<bool> showErrorNotifier = ValueNotifier(false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String living = '';
  String mobileNumber = '';

  void _onStateChanged() {
    final state = stateController.text.toLowerCase();
    showDropDown.value = state == 'maharashtra' || state == 'महाराष्ट्र';
  }

  Future<void> setMobileNumber() async {
    final ss = getIt<SecureStorage>();
    final storedNumber =
        getData<String>('mobileNumber') ?? await ss.getMobileNumber();
    if (storedNumber != null && storedNumber.trim().isNotEmpty) {
      mobileNoController.text = storedNumber.trim();
      mobileNumber = storedNumber.trim();
    }
  }

  @override
  void init() {
    super.init();
    setMobileNumber();
  }

  @override
  void mapEventToState() {
    on<GetArticlesEvent>((event, emit) {
      emit(state.copyWith(list: event.list));
    });
  }

  bool validate() {
    return firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty &&
        dateOfBirthController.text.trim().isNotEmpty &&
        addressController.text.trim().isNotEmpty &&
        cityController.text.trim().isNotEmpty &&
        stateController.text.trim().isNotEmpty &&
        pincodeController.text.trim().isNotEmpty &&
        districtController.text.trim().isNotEmpty &&
        subDistrictController.text.trim().isNotEmpty &&
        living.trim().isNotEmpty &&
        mobileNoController.text.trim().isNotEmpty;
  }

  Future<bool> setFormData() async {
    final phone = mobileNoController.text.trim().isNotEmpty
        ? mobileNoController.text.trim()
        : mobileNumber.trim();

    if (phone.isEmpty) {
      debugPrint('Error: Mobile number is empty');
      return false;
    }

    final db = FirebaseFirestore.instance;
    final formData = {
      'firstName': firstNameController.text.trim(),
      'middleName': middleNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'dateOfBirth': dateOfBirthController.text.trim(),
      'address': addressController.text.trim(),
      'city': cityController.text.trim(),
      'state': stateController.text.trim(),
      'pincode': pincodeController.text.trim(),
      'district': districtController.text.trim(),
      'subDistrict': subDistrictController.text.trim(),
      'mobileNo': phone,
      'email': emailController.text.trim(),
      'living': living.trim(),
    };

    try {
      await db.collection(phone).doc('form_info').set(formData);
      final ss = getIt<SecureStorage>();
      await ss.setLoginFlag(true);
      await ss.setMobileNumber(phone);
      return true;
    } catch (e) {
      debugPrint('Firestore setFormData error: $e');
      return false;
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.removeListener(_onStateChanged);
    stateController.dispose();
    pincodeController.dispose();
    districtController.dispose();
    subDistrictController.dispose();
    mobileNoController.dispose();
    emailController.dispose();
    showDropDown.dispose();
    showErrorNotifier.dispose();
    return super.close();
  }
}
