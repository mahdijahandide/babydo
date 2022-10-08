import 'package:babydoo/services/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropDown {
  Widget createCustomDropdown({required value, required List<String> mList}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors().green, width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: DropdownButtonHideUnderline(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: mList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            )),
      ),
    );
  }
}
