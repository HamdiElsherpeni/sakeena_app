import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/services/permission_service.dart';

enum _GuardState { checking, granted, denied, permanentlyDenied }

class PermissionGuard extends StatefulWidget {
  final AppPermission permission;
  final Widget child;
  final bool autoRequest;

  PermissionGuard({
    super.key,
    required this.permission,
    required this.child,
    this.autoRequest = true,
  });

  @override
  State<PermissionGuard> createState() => _PermissionGuardState();
}

class _PermissionGuardState extends State<PermissionGuard>
    with WidgetsBindingObserver {
  final _permissionService = PermissionService();
  _GuardState _state = _GuardState.checking;
  bool _hasAutoRequested = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    if (!mounted) return;
    setState(() => _state = _GuardState.checking);

    final isGranted = await _permissionService.check(widget.permission);
    if (isGranted) {
      if (!mounted) return;
      setState(() => _state = _GuardState.granted);
      return;
    }

    final isPermanent = await _permissionService.isPermanentlyDenied(
      widget.permission,
    );

    if (!mounted) return;

    if (isPermanent) {
      setState(() => _state = _GuardState.permanentlyDenied);
    } else {
      setState(() => _state = _GuardState.denied);
      if (widget.autoRequest && !_hasAutoRequested) {
        _hasAutoRequested = true;
        _requestPermission();
      }
    }
  }

  Future<void> _requestPermission() async {
    if (!mounted) return;
    setState(() => _state = _GuardState.checking);

    final isGranted = await _permissionService.request(widget.permission);
    if (!mounted) return;

    if (isGranted) {
      setState(() => _state = _GuardState.granted);
    } else {
      final isPermanent = await _permissionService.isPermanentlyDenied(
        widget.permission,
      );
      setState(() {
        _state = isPermanent
            ? _GuardState.permanentlyDenied
            : _GuardState.denied;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      _GuardState.granted => widget.child,
      _GuardState.checking => Center(child: CupertinoActivityIndicator()),
      _ => _PermissionBlocker(
        permission: widget.permission,
        isPermanent: _state == _GuardState.permanentlyDenied,
        onTap: () {
          if (_state == _GuardState.permanentlyDenied) {
            _permissionService.openSettings();
          } else {
            _requestPermission();
          }
        },
      ),
    };
  }
}

class _PermissionBlocker extends StatefulWidget {
  final AppPermission permission;
  final bool isPermanent;
  final VoidCallback onTap;

  const _PermissionBlocker({
    required this.permission,
    required this.isPermanent,
    required this.onTap,
  });

  @override
  State<_PermissionBlocker> createState() => _PermissionBlockerState();
}

class _PermissionBlockerState extends State<_PermissionBlocker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  IconData get _icon => switch (widget.permission) {
    AppPermission.camera => CupertinoIcons.camera_fill,
    AppPermission.location => CupertinoIcons.location_fill,
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 72.w,
                    height: 72.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(_icon, color: AppColors.primary, size: 32),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              Text(
                'نحتاج إذن الوصول إلى ${widget.permission.arabicName}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                widget.permission.arabicDescription,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),

              if (widget.isPermanent) ...[
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.exclamationmark_triangle_fill,
                        color: Colors.orange,
                        size: 20,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'لقد قمت برفض الصلاحية مسبقاً. يجب تفعيلها يدوياً من الإعدادات.',
                          style: TextStyle(fontSize: 12.sp, color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 28.h),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: widget.onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.isPermanent
                            ? CupertinoIcons.settings
                            : CupertinoIcons.checkmark_shield_fill,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.isPermanent ? 'فتح الإعدادات' : 'منح الصلاحية',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
