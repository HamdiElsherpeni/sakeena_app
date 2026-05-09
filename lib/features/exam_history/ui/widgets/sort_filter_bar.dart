import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class SortFilterBar extends StatelessWidget {
  const SortFilterBar({
    super.key,
    this.activeFilter = 'all',
    this.sortAscending = false,
    this.onSortToggle,
    this.onFilterChanged,
  });

  final String activeFilter;
  final bool sortAscending;
  final VoidCallback? onSortToggle;
  final void Function(String filter)? onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _showFilterSheet(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColors.border, width: 1.w),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 13.sp,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'ترتيب: حسب',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  SizedBox(width: 4.w),
                  AnimatedRotation(
                    turns: sortAscending ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18.sp,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _FilterBottomSheet(
        activeFilter: activeFilter,
        sortAscending: sortAscending,
        onFilterChanged: onFilterChanged,
        onSortToggle: onSortToggle,
      ),
    );
  }
}

// ─── Bottom Sheet ─────────────────────────────────────────────────────────────

class _FilterBottomSheet extends StatelessWidget {
  const _FilterBottomSheet({
    required this.activeFilter,
    required this.sortAscending,
    this.onFilterChanged,
    this.onSortToggle,
  });

  final String activeFilter;
  final bool sortAscending;
  final void Function(String)? onFilterChanged;
  final VoidCallback? onSortToggle;

  static const _filters = [
    ('all', 'الكل', Icons.list_rounded),
    ('Benign', 'آمن', Icons.check_circle_outline_rounded),
    ('Malignant', 'خطير', Icons.warning_amber_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 28.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Text(
            'تصفية وترتيب',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              fontFamily: 'Rubik',
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'اختر نوع النتيجة',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
              fontFamily: 'Rubik',
            ),
          ),
          SizedBox(height: 16.h),

          // Filter options
          ..._filters.map(
            (f) => _FilterTile(
              label: f.$2,
              icon: f.$3,
              isActive: activeFilter == f.$1,
              onTap: () {
                onFilterChanged?.call(f.$1);
                Navigator.pop(context);
              },
            ),
          ),

          Divider(height: 24.h, color: AppColors.border),

          // Sort toggle
          _SortTile(
            sortAscending: sortAscending,
            onTap: () {
              onSortToggle?.call();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// ─── Filter Tile ──────────────────────────────────────────────────────────────

class _FilterTile extends StatelessWidget {
  const _FilterTile({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.selectedBg : AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.border,
            width: isActive ? 1.5.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            if (isActive)
              Icon(Icons.check_rounded, size: 16.sp, color: AppColors.primary)
            else
              SizedBox(width: 16.sp),
            SizedBox(width: 10.w),
            Icon(
              icon,
              size: 18.sp,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Rubik',
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.primary : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Sort Tile ────────────────────────────────────────────────────────────────

class _SortTile extends StatelessWidget {
  const _SortTile({required this.sortAscending, required this.onTap});

  final bool sortAscending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border, width: 1.w),
        ),
        child: Row(
          children: [
            Icon(
              sortAscending
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              size: 18.sp,
              color: AppColors.primary,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                sortAscending ? 'الأقدم أولاً' : 'الأحدث أولاً',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Rubik',
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              'تغيير',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Rubik',
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
