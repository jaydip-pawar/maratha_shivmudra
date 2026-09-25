# Database & Geo Maintenance Scripts

This directory contains maintenance scripts for the **Maratha Shivmudra** project:

1. **`backup_and_analyze_firestore.js`**:
   - Downloads all Firestore collections via Google Cloud REST API.
   - Generates schema analysis and member counts.

2. **`rebuild_database.js`**:
   - Reconstructs and normalizes the Firestore `members` collection.
   - Generates standardized search tokens and timestamps.

3. **`fix_all_names.js`**:
   - Verifies and updates bilingual (English & Marathi) member names.
   - Strictly enforces Marathi orthography:
     - `i` $\rightarrow$ पहिली वेलांटी (`ि`) vs `ee` $\rightarrow$ दुसरी वेलांटी (`ी`)
     - `u` $\rightarrow$ पहिला उकार (`ु`) vs `oo` $\rightarrow$ दुसरा उकार (`ू`)

4. **`generate_geo_constants.js`**:
   - Generates `lib/core/constants/geo_constants.dart` containing comprehensive States, Districts, and Talukas.

5. **`raw_members_101.json`**:
   - Reference backup of original 101 registered member names for auditability.
