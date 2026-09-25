import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AdminUser {
  final String uid;
  final String email;
  final String name;
  final String role; // 'super_admin' | 'district_admin'
  final List<String> allowedDistricts;
  final bool isActive;

  const AdminUser({
    required this.uid,
    required this.email,
    required this.name,
    this.role = 'super_admin',
    this.allowedDistricts = const ['ALL'],
    this.isActive = true,
  });

  bool get isSuperAdmin => role == 'super_admin';

  factory AdminUser.fromFirestore(String uid, Map<String, dynamic> data) {
    return AdminUser(
      uid: uid,
      email: data['email'] as String? ?? '',
      name: data['name'] as String? ?? 'Admin',
      role: data['role'] as String? ?? 'super_admin',
      allowedDistricts: (data['allowed_districts'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const ['ALL'],
      isActive: data['is_active'] as bool? ?? true,
    );
  }
}

class AdminAuthService {
  static final AdminAuthService _instance = AdminAuthService._internal();
  static AdminAuthService get instance => _instance;
  AdminAuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final ValueNotifier<AdminUser?> currentAdminNotifier = ValueNotifier(null);

  bool get isAdminLoggedIn => currentAdminNotifier.value != null;

  /// Sign in with Admin Email & Password
  Future<AdminUser?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;
      if (user == null) return null;

      // Check admins collection in Firestore
      final adminDoc = await _db.collection('admins').doc(user.uid).get();
      AdminUser adminUser;

      if (adminDoc.exists && adminDoc.data() != null) {
        adminUser = AdminUser.fromFirestore(user.uid, adminDoc.data()!);
        if (!adminUser.isActive) {
          await _auth.signOut();
          return null;
        }
      } else {
        // Bootstrap super admin entry if first admin login
        adminUser = AdminUser(
          uid: user.uid,
          email: user.email ?? email,
          name: 'Super Admin',
          role: 'super_admin',
          allowedDistricts: const ['ALL'],
          isActive: true,
        );
        await _db.collection('admins').doc(user.uid).set({
          'email': user.email ?? email,
          'name': 'Super Admin',
          'role': 'super_admin',
          'allowed_districts': ['ALL'],
          'is_active': true,
          'created_at': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      currentAdminNotifier.value = adminUser;
      return adminUser;
    } catch (e) {
      debugPrint('Admin sign in error: $e');
      return null;
    }
  }

  /// Sign out admin
  Future<void> signOut() async {
    await _auth.signOut();
    currentAdminNotifier.value = null;
  }
}
