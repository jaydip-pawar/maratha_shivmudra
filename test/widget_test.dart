import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/constants/organization_roles.dart';

void main() {
  group('OrganizationRoles Tests', () {
    test('Maharashtra has 6 administrative vibhags', () {
      expect(OrganizationRoles.maharashtraVibhags.length, 6);
    });

    test('Core committee has 19 roles', () {
      final coreRoles = OrganizationRoles.getRolesForLevel(OrganizationLevel.core);
      expect(coreRoles.length, 19);
    });

    test('Division committee has 5 roles', () {
      final vibhagRoles = OrganizationRoles.getRolesForLevel(OrganizationLevel.vibhag);
      expect(vibhagRoles.length, 5);
    });

    test('District committee has 11 roles', () {
      final jilhaRoles = OrganizationRoles.getRolesForLevel(OrganizationLevel.jilha);
      expect(jilhaRoles.length, 11);
    });

    test('Taluka committee has 5 roles', () {
      final talukaRoles = OrganizationRoles.getRolesForLevel(OrganizationLevel.taluka);
      expect(talukaRoles.length, 5);
    });

    test('getVibhagForDistrict correctly resolves Pune and Mumbai', () {
      final puneVibhag = OrganizationRoles.getVibhagForDistrict('Pune');
      expect(puneVibhag, isNotNull);
      expect(puneVibhag!.code, 'PUNE');

      final sataraVibhag = OrganizationRoles.getVibhagForDistrict('Satara');
      expect(sataraVibhag, isNotNull);
      expect(sataraVibhag!.code, 'PUNE');

      final thaneVibhag = OrganizationRoles.getVibhagForDistrict('Thane');
      expect(thaneVibhag, isNotNull);
      expect(thaneVibhag!.code, 'KONKAN');
    });
  });
}
