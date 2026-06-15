import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/health_guide/logic/health_guide_controller.dart';
import 'package:sakeena_app/features/health_guide/ui/widgets/article_card_widget.dart';
import 'package:sakeena_app/features/health_guide/ui/widgets/category_chips_widget.dart';
import 'package:sakeena_app/features/health_guide/ui/widgets/guide_search_bar_widget.dart';
import 'package:sakeena_app/features/health_guide/ui/widgets/quick_tips_widget.dart';

import 'article_detail_screen.dart';

class HealthGuideScreen extends StatelessWidget {
  const HealthGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HealthGuideController(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xffFAF5F7),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: CircleAvatar(
                  radius: 21.r,
                  backgroundColor: AppColors.border,
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.kprimaryColor,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            title: Text(
              'دليلك الصحي',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
          body: Consumer<HealthGuideController>(
            builder: (context, controller, _) {
              final articles = controller.filteredArticles;

              return CustomScrollView(
                slivers: [
                  // ── Search bar ────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
                      child: GuideSearchBarWidget(
                        onChanged: controller.updateSearch,
                      ),
                    ),
                  ),

                  // ── Quick tips ────────────────────────────────
                  SliverToBoxAdapter(
                    child: QuickTipsWidget(tips: controller.quickTips),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                  // ── Section title ─────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        'المقالات الصحية',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 12.h)),

                  // ── Category chips ────────────────────────────
                  SliverToBoxAdapter(
                    child: CategoryChipsWidget(
                      categories: controller.categories,
                      selectedId: controller.selectedCategoryId,
                      onSelected: controller.selectCategory,
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                  // ── Articles list or empty state ──────────────
                  articles.isEmpty
                      ? SliverFillRemaining(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '🔍',
                                  style: TextStyle(fontSize: 40.sp),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  'لا توجد نتائج',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final article = articles[index];
                                return ArticleCardWidget(
                                  article: article,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ArticleDetailScreen(
                                        article: article,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: articles.length,
                            ),
                          ),
                        ),

                  SliverToBoxAdapter(child: SizedBox(height: 30.h)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}