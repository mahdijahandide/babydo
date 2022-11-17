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
                      alignment: const Alignment(1.0, -1.0),
                      onPressed: suffixPress,
                      icon: Icon(
                        suffixIcon ?? Icons.search,
                        color: suffixColor ?? Colors.black,
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
      dynamic controller,
      dynamic maxLines,
      dynamic borderColor}) {
    return Container(
      height: height.toDouble(),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? const Color(0xffdcdcdc)),
          borderRadius: BorderRadius.circular(12),
          color: bg ?? Colors.white),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextField(
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: const TextStyle(fontSize: 12),
            maxLines: maxLines ?? 1,
            focusNode: node,
            obscureText: obscure != null ? true : false,
            maxLength: maxLength,
            controller: controller,
            textAlign: align ?? TextAlign.start,
            onChanged: (str) {
              // text.value = str;
            },
            decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
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
      ),
    );
  }
}
