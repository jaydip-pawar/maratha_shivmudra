import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

/// Item definition for [AppSearchableDropdown].
@immutable
class AppDropdownItem<T> {
  final T? value;
  final String label;
  final String? selectedLabel;
  final String? subtitle;
  final String? searchKey;
  final Widget? leading;
  final Widget? trailing;
  final bool isHeader;

  const AppDropdownItem({
    required this.value,
    required this.label,
    this.selectedLabel,
    this.subtitle,
    this.searchKey,
    this.leading,
    this.trailing,
    this.isHeader = false,
  });

  /// Factory for a category or divider header in the dropdown menu
  factory AppDropdownItem.header(String title) {
    return AppDropdownItem<T>(
      value: null,
      label: title,
      isHeader: true,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDropdownItem &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          label == other.label;

  @override
  int get hashCode => (value?.hashCode ?? 0) ^ label.hashCode;
}

/// A premium, reusable searchable dropdown widget with an anchored popup menu
/// that opens directly below the input field.
///
/// Features:
/// - Anchored directly below the textfield with exact matching width.
/// - Built-in live search filtering across Marathi & English labels.
/// - Outside click dismissal and smooth state management.
/// - Gold and dark-theme aesthetics matching the Maratha Shivmudra design system.
class AppSearchableDropdown<T> extends StatefulWidget {
  final T? value;
  final List<AppDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? labelText;
  final String? hintText;
  final String searchHint;
  final Widget? prefixIcon;
  final bool showSearch;
  final bool enabled;
  final double maxMenuHeight;
  final String? errorText;
  final bool isRequired;
  final FormFieldValidator<T>? validator;
  final FormFieldSetter<T>? onSaved;
  final AutovalidateMode? autovalidateMode;

  const AppSearchableDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.searchHint = 'शोधा... (Search)',
    this.prefixIcon,
    this.showSearch = true,
    this.enabled = true,
    this.maxMenuHeight = 280,
    this.errorText,
    this.isRequired = false,
    this.validator,
    this.onSaved,
    this.autovalidateMode,
  });

  @override
  State<AppSearchableDropdown<T>> createState() => _AppSearchableDropdownState<T>();
}

class _AppSearchableDropdownState<T> extends State<AppSearchableDropdown<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _boxKey = GlobalKey();
  final GlobalKey<FormFieldState<T>> _fieldKey = GlobalKey<FormFieldState<T>>();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  T? _currentVal;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  late AnimationController _arrowAnimController;
  late Animation<double> _arrowRotation;

  @override
  void initState() {
    super.initState();
    _currentVal = widget.value;
    _arrowAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _arrowRotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _arrowAnimController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant AppSearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isOpen && widget.items != oldWidget.items) {
      _overlayEntry?.markNeedsBuild();
    }
    if (widget.value != oldWidget.value) {
      _currentVal = widget.value;
      if (_fieldKey.currentState?.value != widget.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _fieldKey.currentState?.value != widget.value) {
            _fieldKey.currentState?.didChange(widget.value);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchController.dispose();
    _arrowAnimController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (_isOpen || !mounted) return;

    setState(() {
      _isOpen = true;
      _searchQuery = '';
      _searchController.clear();
    });
    _arrowAnimController.forward();

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    if (!_isOpen) return;

    _removeOverlay();
    if (mounted) {
      setState(() {
        _isOpen = false;
        _searchQuery = '';
        _searchController.clear();
      });
      _arrowAnimController.reverse();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  AppDropdownItem<T>? get _selectedItem {
    final effectiveVal = widget.value ?? _currentVal;
    if (effectiveVal == null) return null;
    for (final item in widget.items) {
      if (!item.isHeader && item.value == effectiveVal) {
        return item;
      }
    }
    return null;
  }

  List<AppDropdownItem<T>> _getFilteredItems() {
    if (_searchQuery.isEmpty) return widget.items;

    final q = _searchQuery.toLowerCase();
    return widget.items.where((item) {
      if (item.isHeader) return false;
      final label = item.label.toLowerCase();
      final sub = (item.subtitle ?? '').toLowerCase();
      final key = (item.searchKey ?? '').toLowerCase();
      return label.contains(q) || sub.contains(q) || key.contains(q);
    }).toList();
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = (_boxKey.currentContext?.findRenderObject() as RenderBox?) ??
        (context.findRenderObject() as RenderBox?)!;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final bottomInset = mediaQuery.viewInsets.bottom;
    final topPadding = mediaQuery.padding.top;
    final availableBelow =
        screenHeight - bottomInset - (position.dy + size.height);
    final availableAbove = position.dy - topPadding;

    // If bottom space is insufficient (< maxMenuHeight) and above has more space, open upward
    final bool openUpward = availableBelow < widget.maxMenuHeight &&
        availableAbove > availableBelow;
    final double maxAllowed = openUpward
        ? math.min(widget.maxMenuHeight, math.max(140.0, availableAbove - 12))
        : math.min(widget.maxMenuHeight, math.max(140.0, availableBelow - 12));

    return OverlayEntry(
      builder: (overlayContext) {
        return Stack(
          children: [
            // Barrier to detect outside clicks and close the menu
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeDropdown,
                child: const SizedBox.expand(),
              ),
            ),

            // Anchored dropdown menu shifted dynamically upward or downward
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                targetAnchor:
                    openUpward ? Alignment.topLeft : Alignment.bottomLeft,
                followerAnchor:
                    openUpward ? Alignment.bottomLeft : Alignment.topLeft,
                offset: Offset(0, openUpward ? -4 : 4),
                child: Material(
                  elevation: 8,
                  shadowColor: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.darkSurface,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: maxAllowed,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.45),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: StatefulBuilder(
                      builder: (context, setMenuState) {
                        final filteredItems = _getFilteredItems();

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Embedded Live Search Field
                            if (widget.showSearch) ...[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
                                child: TextField(
                                  controller: _searchController,
                                  autofocus: true,
                                  style: const TextStyle(color: Colors.white, fontSize: 13),
                                  decoration: InputDecoration(
                                    hintText: widget.searchHint ??
                                        (Localizations.maybeLocaleOf(context)?.languageCode == 'mr'
                                            ? 'शोधा...'
                                            : 'Search...'),
                                    hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    prefixIcon: const Icon(
                                      Icons.search_rounded,
                                      color: AppColors.gold,
                                      size: 18,
                                    ),
                                    suffixIcon: _searchQuery.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(Icons.clear_rounded, size: 16, color: AppColors.textMuted),
                                            onPressed: () {
                                              _searchController.clear();
                                              setState(() => _searchQuery = '');
                                              setMenuState(() => _searchQuery = '');
                                            },
                                          )
                                        : null,
                                    filled: true,
                                    fillColor: AppColors.darkBgHeroTop,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(color: AppColors.darkBorder),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(color: AppColors.darkBorder),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(color: AppColors.gold, width: 1.2),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() => _searchQuery = val.trim());
                                    setMenuState(() => _searchQuery = val.trim());
                                  },
                                ),
                              ),
                              const Divider(color: AppColors.darkBorder, height: 1),
                            ],

                            // Scrollable Options List
                            Flexible(
                              child: filteredItems.isEmpty
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.search_off_rounded, color: AppColors.textMuted, size: 28),
                                          const SizedBox(height: 6),
                                          Text(
                                            'कोणतेही निकाल आढळले नाहीत\n"$_searchQuery"',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      itemCount: filteredItems.length,
                                      separatorBuilder: (_, __) => const Divider(
                                        color: AppColors.darkBorder,
                                        height: 1,
                                        indent: 12,
                                        endIndent: 12,
                                      ),
                                      itemBuilder: (context, index) {
                                        final item = filteredItems[index];

                                        if (item.isHeader) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                            color: AppColors.darkBgHeroTop,
                                            child: Text(
                                              item.label,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.goldLight,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          );
                                        }

                                        final isSelected = !item.isHeader && item.value == widget.value;

                                        return Material(
                                          color: isSelected
                                              ? AppColors.gold.withValues(alpha: 0.12)
                                              : Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              _currentVal = item.value;
                                              widget.onChanged?.call(item.value);
                                              _fieldKey.currentState?.didChange(item.value);
                                              _fieldKey.currentState?.validate();
                                              _closeDropdown();
                                            },
                                            splashColor: AppColors.gold.withValues(alpha: 0.2),
                                            hoverColor: AppColors.gold.withValues(alpha: 0.08),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                              child: Row(
                                                children: [
                                                  if (item.leading != null) ...[
                                                    item.leading!,
                                                    const SizedBox(width: 10),
                                                  ],
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          item.label,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                                            color: isSelected ? AppColors.goldLight : Colors.white,
                                                          ),
                                                        ),
                                                        if (item.subtitle != null && item.subtitle!.isNotEmpty) ...[
                                                          const SizedBox(height: 2),
                                                          Text(
                                                            item.subtitle!,
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              color: isSelected
                                                                  ? AppColors.gold.withValues(alpha: 0.8)
                                                                  : AppColors.textSecondary,
                                                            ),
                                                          ),
                                                        ],
                                                      ],
                                                    ),
                                                  ),
                                                  if (item.trailing != null)
                                                    item.trailing!
                                                  else if (isSelected)
                                                    const Icon(
                                                      Icons.check_rounded,
                                                      color: AppColors.goldLight,
                                                      size: 18,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      key: _fieldKey,
      initialValue: widget.value ?? _currentVal,
      autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
      onSaved: widget.onSaved,
      validator: (val) {
        final effectiveVal = widget.value ?? _currentVal ?? val;
        if (widget.validator != null) {
          return widget.validator!(effectiveVal);
        }
        if (widget.isRequired) {
          if (effectiveVal == null || (effectiveVal is String && effectiveVal.trim().isEmpty)) {
            final isMr = Localizations.maybeLocaleOf(context)?.languageCode == 'mr';
            final cleanLabel = widget.labelText?.replaceAll('*', '').trim();
            if (cleanLabel != null && cleanLabel.isNotEmpty) {
              return isMr ? 'कृपया $cleanLabel निवडा' : 'Please select $cleanLabel';
            }
            return isMr ? 'कृपया निवडा' : 'Please select an option';
          }
        }
        return null;
      },
      builder: (FormFieldState<T> fieldState) {
        final selected = _selectedItem;
        final effectiveError = (widget.errorText != null && widget.errorText!.isNotEmpty)
            ? widget.errorText
            : fieldState.errorText;
        final bool hasError = effectiveError != null && effectiveError.isNotEmpty;

        final boxWidget = SizedBox(
          key: _boxKey,
          height: 44,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: InkWell(
              onTap: widget.enabled ? _toggleDropdown : null,
              borderRadius: BorderRadius.circular(8),
              child: InputDecorator(
                isEmpty: selected == null,
                isFocused: _isOpen,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: AppColors.darkSurface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  hintText: widget.hintText ??
                      (Localizations.maybeLocaleOf(context)?.languageCode == 'mr'
                          ? 'निवडा...'
                          : 'Select...'),
                  hintStyle: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: widget.prefixIcon != null
                      ? IconTheme(
                          data: const IconThemeData(
                            color: AppColors.goldLight,
                            size: 18,
                          ),
                          child: widget.prefixIcon!,
                        )
                      : null,
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 44,
                  ),
                  suffixIcon: RotationTransition(
                    turns: _arrowRotation,
                    child: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: _isOpen ? AppColors.gold : (hasError ? AppColors.errorColor : AppColors.goldLight),
                      size: 24,
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 44,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: hasError ? AppColors.errorColor : AppColors.darkBorder,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: hasError
                          ? AppColors.errorColor
                          : (_isOpen ? AppColors.gold : AppColors.darkBorder),
                      width: (_isOpen || hasError) ? 1.5 : 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: hasError ? AppColors.errorColor : AppColors.gold,
                      width: 1.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.errorColor,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.errorColor,
                      width: 1.5,
                    ),
                  ),
                ),
                child: selected != null
                    ? Row(
                        children: [
                          if (selected.leading != null) ...[
                            selected.leading!,
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: Text(
                              selected.selectedLabel ?? selected.label,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
            ),
          ),
        );

        if (widget.labelText == null && !hasError) {
          return boxWidget;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.labelText != null) ...[
              Text.rich(
                TextSpan(
                  text: widget.labelText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.goldLight,
                  ),
                  children: [
                    if (widget.isRequired)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: AppColors.errorColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
            ],
            boxWidget,
            if (effectiveError != null && effectiveError.isNotEmpty) ...[
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  effectiveError,
                  style: const TextStyle(
                    color: AppColors.errorColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
