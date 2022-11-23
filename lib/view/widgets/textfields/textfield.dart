import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';

class CustomTextField {
  Widget createTextField(
      {Key? key,
      required hint,
      dynamic hasPrefixIcon,
      dynamic hasSuffixIcon,
      dynamic suffixColor,
      dynamic suffixPress,
      dynamic prefixPress,
      dynamic obscure,
      required height,
      dynamic bg,
      dynamic prefixIcon,
      dynamic suffixIcon,
      dynamic node,
      dynamic textInputAction,
      dynamic keyboardType,
      dynamic inputFormatters,
      dynamic hintStyle,
      dynamic maxLines,
      dynamic align,
      dynamic onSubmitted,
      dynamic radius,
      dynamic borderWidth,
      dynamic onTap,
      dynamic lable,
      dynamic lableColor,
      dynamic autoFocus,
      dynamic maxLength,
      dynamic controller,
      dynamic borderColor}) {
    return Container(
      height: height.toDouble(),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      decoration: BoxDecoration(
          border: Border.all(
              color: borderColor ?? const Color(0xffdcdcdc),
              width: borderWidth ?? 1),
          borderRadius: BorderRadius.circular(radius ?? 8.0),
          color: bg ?? Colors.white),
      child: TextFormField(
          textInputAction: textInputAction,
          onFieldSubmitted: onSubmitted,
          autofocus: autoFocus ?? false,
          onTap: onTap,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          focusNode: node,
          obscureText: obscure ?? false,
          maxLength: maxLength,
          controller: controller,
          maxLines: maxLines ?? 1,
          textAlign: align ?? TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              // contentPadding: EdgeInsets.only(
              //   bottom: height / 5, // HERE THE IMPORTANT PART
              // ),
              counterText: '',
              border: InputBorder.none,
              hintText: hint,
              // labelText: hint,
              // alignLabelWithHint: true,
              // labelStyle: TextStyle(
              //     color: node.hasFocus ? Colors.white : Colors.green),
              hintStyle: hintStyle,
              suffixIcon: hasSuffixIcon == true
                  ? IconButton(
                    alignment: AlignmentDirectional.centerEnd,
                      onPressed: suffixPress,
                      icon: Icon(
                        suffixIcon ?? Icons.search,
                        color: suffixColor ?? Colors.black,size: 20,
                      ),
                    )
                  : null,
              prefixIcon: hasPrefixIcon == true
                  ? IconButton(
                      onPressed: prefixPress,
                      icon: Icon(
                        prefixIcon ?? Icons.search,
                      ),
                    )
                  : null)),
    );
  }

  Widget createCustomTextField(
      {Key? key,
      required hint,
      dynamic hasPrefixIcon,
      dynamic hasSuffixIcon,
      dynamic suffixPress,
      dynamic prefixPress,
      dynamic obscure,
      required height,
      dynamic bg,
      dynamic prefixIcon,
      dynamic suffixIcon,
      dynamic node,
      dynamic textInputAction,
      dynamic keyboardType,
      dynamic inputFormatters,
      dynamic hintStyle,
      dynamic align,
      dynamic maxLength,
        dynamic keyy,
        dynamic validate,
      dynamic controller,
      dynamic maxLines,
      dynamic borderColor}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextFormField(
        validator: validate,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          // style: const TextStyle(fontSize: 12),
          maxLines: maxLines ?? 1,
          focusNode: node,
          obscureText: obscure != null ? true : false,
          maxLength: maxLength,
          controller: controller,
          textAlign: align ?? TextAlign.start,
          onChanged: (str) {},
          decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: AppColors().green,width: 1.0),borderRadius: BorderRadius.circular(12)),
              focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: AppColors().green,width: 1.3),borderRadius: BorderRadius.circular(12)),
              border: OutlineInputBorder(borderSide: BorderSide(color: AppColors().green,width: 1.0),borderRadius: BorderRadius.circular(12)),
              errorBorder: OutlineInputBorder(borderSide:const BorderSide(color: Colors.red,width: 1.5),borderRadius: BorderRadius.circular(12)),
              hintText: hint,
              hintStyle: hintStyle,
              suffixIcon: hasSuffixIcon == true
                  ? IconButton(
                      onPressed: suffixPress,
                      icon: Icon(
                        suffixIcon ?? Icons.search,
                      ),
                    )
                  : null,
              prefixIcon: hasPrefixIcon == true
                  ? IconButton(
                      onPressed: prefixPress,
                      icon: Icon(
                        prefixIcon ?? Icons.search,
                      ),
                    )
                  : null)),
    );
  }
}
