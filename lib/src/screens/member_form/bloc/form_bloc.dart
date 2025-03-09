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
    mobileNoController.text =
        getData<String>('mobileNumber') ?? await ss.getMobileNumber();
    mobileNumber = mobileNoController.text;
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
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        dateOfBirthController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty &&
        districtController.text.isNotEmpty &&
        subDistrictController.text.isNotEmpty &&
        living.isNotEmpty &&
        mobileNoController.text.isNotEmpty;
  }

  Future<bool> setFormData() async {
    final db = FirebaseFirestore.instance;
    final formData = {
      'firstName': firstNameController.text,
      'middleName': middleNameController.text,
      'lastName': lastNameController.text,
      'dateOfBirth': dateOfBirthController.text,
      'address': addressController.text,
      'city': cityController.text,
      'state': stateController.text,
      'pincode': pincodeController.text,
      'district': districtController.text,
      'subDistrict': subDistrictController.text,
      'mobileNo': mobileNoController.text,
      'email': emailController.text,
      'living': living,
    };

    return await db
        .collection(mobileNumber)
        .doc('form_info')
        .set(formData)
        .then((_) {
      print('IN THEN');
      final ss = getIt<SecureStorage>();
      ss.setLoginFlag(true);
      return true;
    }).catchError((_) {
      print('IN catch');
      return false;
    });
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
