import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const screenTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const listTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static const listSubtitle = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
  static const statLabel = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
  static const statValue = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static const sectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle darkScreenTitle(BuildContext context) => screenTitle.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle darkListTitle(BuildContext context)   => listTitle.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle darkListSubtitle(BuildContext context)=> listSubtitle.copyWith(color: AppColors.darkTextSecondary);
  static TextStyle darkStatLabel(BuildContext context)  => statLabel.copyWith(color: AppColors.darkTextSecondary);
  static TextStyle darkStatValue(BuildContext context)  => statValue.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle darkSectionTitle(BuildContext context)=> sectionTitle.copyWith(color: AppColors.darkTextPrimary);
}