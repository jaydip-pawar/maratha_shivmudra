import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/geo_constants.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/src/widgets/dropdown/app_searchable_dropdown.dart';

/// Common cascading State -> District -> Taluka dropdown widget.
/// Used across Registration Form, Profile Screen (Current & Native Address),
/// and Admin Dashboard with responsive Desktop (Row) / Mobile (Column) support.
class GeoAddressFields extends StatefulWidget {
  final String? initialState;
  final String? initialDistrict;
  final String? initialTaluka;
  final bool isMarathi;
  final bool? isDesktop;
  final String? stateLabel;
  final String? districtLabel;
  final String? talukaLabel;
  final bool isRequired;
  final String keyPrefix;
  final void Function(StateInfo state, DistrictInfo? district, TalukaInfo? taluka)? onChanged;

  const GeoAddressFields({
    super.key,
    this.initialState,
    this.initialDistrict,
    this.initialTaluka,
    this.isMarathi = true,
    this.isDesktop,
    this.stateLabel,
    this.districtLabel,
    this.talukaLabel,
    this.isRequired = true,
    this.keyPrefix = 'geo',
    this.onChanged,
  });

  @override
  State<GeoAddressFields> createState() => _GeoAddressFieldsState();
}

class _GeoAddressFieldsState extends State<GeoAddressFields> {
  late StateInfo _selectedState;
  DistrictInfo? _selectedDistrict;
  TalukaInfo? _selectedTaluka;

  @override
  void initState() {
    super.initState();
    _initFromProps();
  }

  @override
  void didUpdateWidget(covariant GeoAddressFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialState != widget.initialState ||
        oldWidget.initialDistrict != widget.initialDistrict ||
        oldWidget.initialTaluka != widget.initialTaluka) {
      _initFromProps();
    }
  }

  void _initFromProps() {
    _selectedState = _matchState(widget.initialState);
    _selectedDistrict = _matchDistrict(_selectedState, widget.initialDistrict);
    _selectedTaluka = _matchTaluka(_selectedDistrict, widget.initialTaluka);
  }

  StateInfo _matchState(String? val) {
    if (val == null || val.trim().isEmpty) return GeoConstants.defaultState;
    final clean = val.trim().toLowerCase();
    return GeoConstants.states.firstWhere(
      (s) =>
          s.code.toLowerCase() == clean ||
          s.nameEn.toLowerCase() == clean ||
          s.nameMr == val.trim(),
      orElse: () => GeoConstants.defaultState,
    );
  }

  DistrictInfo? _matchDistrict(StateInfo state, String? val) {
    if (state.districts.isEmpty) return null;
    if (val == null || val.trim().isEmpty) return null;
    final clean = val.trim().toLowerCase();
    for (final d in state.districts) {
      if (d.code.toLowerCase() == clean ||
          d.nameEn.toLowerCase() == clean ||
          d.nameMr == val.trim()) {
        return d;
      }
    }
    return null;
  }

  TalukaInfo? _matchTaluka(DistrictInfo? district, String? val) {
    if (district == null || district.talukas.isEmpty) return null;
    if (val == null || val.trim().isEmpty) return null;
    final clean = val.trim().toLowerCase();
    for (final t in district.talukas) {
      if (t.nameEn.toLowerCase() == clean || t.nameMr == val.trim()) {
        return t;
      }
    }
    return null;
  }

  void _onStateSelected(String? stateCode) {
    if (stateCode == null) return;
    final newState = GeoConstants.states.firstWhere(
      (s) => s.code == stateCode,
      orElse: () => GeoConstants.defaultState,
    );
    const DistrictInfo? newDist = null;
    const TalukaInfo? newTal = null;

    setState(() {
      _selectedState = newState;
      _selectedDistrict = newDist;
      _selectedTaluka = newTal;
    });

    widget.onChanged?.call(newState, newDist, newTal);
  }

  void _onDistrictSelected(String? distCode) {
    if (distCode == null || _selectedState.districts.isEmpty) return;
    final newDist = _selectedState.districts.firstWhere(
      (d) => d.code == distCode,
      orElse: () => _selectedState.districts.first,
    );
    const TalukaInfo? newTal = null;

    setState(() {
      _selectedDistrict = newDist;
      _selectedTaluka = newTal;
    });

    widget.onChanged?.call(_selectedState, newDist, newTal);
  }

  void _onTalukaSelected(String? talukaNameEn) {
    if (talukaNameEn == null || _selectedDistrict == null) return;
    final talukas = _selectedDistrict!.talukas;
    final newTal = talukas.firstWhere(
      (t) => t.nameEn == talukaNameEn,
      orElse: () => talukas.first,
    );

    setState(() {
      _selectedTaluka = newTal;
    });

    widget.onChanged?.call(_selectedState, _selectedDistrict, newTal);
  }

  @override
  Widget build(BuildContext context) {
    final isMr = widget.isMarathi;

    // 1. State Dropdown
    final stateItems = GeoConstants.states.map((s) {
      final label = isMr ? s.nameMr : s.nameEn;
      return AppDropdownItem<String>(
        value: s.code,
        label: label,
        searchKey: '${s.nameMr} ${s.nameEn} ${s.code}',
      );
    }).toList();

    final stateWidget = AppSearchableDropdown<String>(
      key: ValueKey('${widget.keyPrefix}_state_${_selectedState.code}'),
      value: _selectedState.code,
      labelText: widget.stateLabel ?? (isMr ? 'राज्य' : 'State'),
      hintText: isMr ? 'राज्य निवडा...' : 'Select state...',
      searchHint: isMr ? 'राज्य शोधा...' : 'Search state...',
      isRequired: widget.isRequired,
      validator: (val) {
        if (!widget.isRequired) return null;
        if (val == null || val.trim().isEmpty) {
          return isMr ? 'कृपया राज्य निवडा' : 'Please select state';
        }
        return null;
      },
      prefixIcon: const Icon(Icons.map_outlined, color: AppColors.gold, size: 18),
      items: stateItems,
      onChanged: _onStateSelected,
    );

    // 2. District Dropdown
    final districts = _selectedState.districts;
    final districtItems = districts.map((d) {
      final label = isMr ? d.nameMr : '${d.nameEn} (${d.code})';
      return AppDropdownItem<String>(
        value: d.code,
        label: label,
        searchKey: '${d.nameMr} ${d.nameEn} ${d.code}',
      );
    }).toList();

    final distWidget = AppSearchableDropdown<String>(
      key: ValueKey('${widget.keyPrefix}_dist_${_selectedState.code}_${_selectedDistrict?.code}'),
      value: _selectedDistrict?.code,
      labelText: widget.districtLabel ?? (isMr ? 'जिल्हा' : 'District'),
      hintText: isMr ? 'जिल्हा निवडा...' : 'Select district...',
      searchHint: isMr ? 'जिल्हा शोधा...' : 'Search district...',
      isRequired: widget.isRequired,
      enabled: districts.isNotEmpty,
      validator: (val) {
        if (!widget.isRequired || _selectedState.districts.isEmpty) return null;
        if (val == null || val.trim().isEmpty) {
          return isMr ? 'कृपया जिल्हा निवडा' : 'Please select district';
        }
        return null;
      },
      prefixIcon: const Icon(Icons.location_city_outlined, color: AppColors.gold, size: 18),
      items: districtItems,
      onChanged: _onDistrictSelected,
    );

    // 3. Taluka Dropdown
    final talukas = _selectedDistrict?.talukas ?? [];
    final talukaItems = talukas.map((t) {
      final label = isMr ? t.nameMr : t.nameEn;
      return AppDropdownItem<String>(
        value: t.nameEn,
        label: label,
        searchKey: '${t.nameMr} ${t.nameEn}',
      );
    }).toList();

    final talukaWidget = AppSearchableDropdown<String>(
      key: ValueKey('${widget.keyPrefix}_tal_${_selectedDistrict?.code}_${_selectedTaluka?.nameEn}'),
      value: _selectedTaluka?.nameEn,
      labelText: widget.talukaLabel ?? (isMr ? 'तालुका / शहर' : 'Taluka / City'),
      hintText: isMr ? 'तालुका निवडा...' : 'Select taluka...',
      searchHint: isMr ? 'तालुका शोधा...' : 'Search taluka...',
      isRequired: widget.isRequired,
      enabled: talukas.isNotEmpty,
      validator: (val) {
        if (!widget.isRequired) return null;
        if (_selectedDistrict != null && _selectedDistrict!.talukas.isEmpty) return null;
        if (val == null || val.trim().isEmpty) {
          return isMr ? 'कृपया तालुका निवडा' : 'Please select taluka';
        }
        return null;
      },
      prefixIcon: const Icon(Icons.holiday_village_outlined, color: AppColors.gold, size: 18),
      items: talukaItems,
      onChanged: _onTalukaSelected,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final useDesktop = widget.isDesktop ?? (constraints.maxWidth > 580);

        if (useDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: stateWidget),
              const SizedBox(width: 12),
              Expanded(child: distWidget),
              const SizedBox(width: 12),
              Expanded(child: talukaWidget),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            stateWidget,
            const SizedBox(height: 10),
            distWidget,
            const SizedBox(height: 10),
            talukaWidget,
          ],
        );
      },
    );
  }
}
