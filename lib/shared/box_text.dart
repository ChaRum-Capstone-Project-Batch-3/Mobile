import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';

class BoxText extends StatelessWidget {
  final String text;
  final TextStyle style;

  //REGULAR
  BoxText.heading1(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading1.copyWith(color: color);
  BoxText.heading2(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading2.copyWith(color: color);
  BoxText.heading3(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading3.copyWith(color: color);
  BoxText.heading4(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading4.copyWith(color: color);
  BoxText.body1(this.text, {Color color = AppColors.kcBaseBlack})
      : style = body1.copyWith(color: color);
  BoxText.body2(this.text, {Color color = AppColors.kcBaseBlack})
      : style = body2.copyWith(color: color);
  BoxText.body3(this.text, {Color color = AppColors.kcBaseBlack})
      : style = body3.copyWith(color: color);
  BoxText.caption(this.text, {Color color = AppColors.kcBaseBlack})
      : style = caption.copyWith(color: color);
  BoxText.button(this.text, {Color color = AppColors.kcBaseBlack})
      : style = button.copyWith(color: color);
  BoxText.overline(this.text, {Color color = AppColors.kcBaseBlack})
      : style = overline.copyWith(color: color);

  //SEMI BOLD
  BoxText.heading1Semi(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading1Semi.copyWith(color: color);
  BoxText.heading2Semi(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading2Semi.copyWith(color: color);
  BoxText.heading3Semi(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading3Semi.copyWith(color: color);
  BoxText.heading4Semi(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading4Semi.copyWith(color: color);
  BoxText.body1Semi(this.text, {Color color = AppColors.kcBaseBlack})
      : style = body1Semi.copyWith(color: color);
  BoxText.body2Semi(this.text, {Color color = AppColors.kcBaseBlack})
      : style = body2Semi.copyWith(color: color);
  BoxText.body3Semi(this.text, {Color color = AppColors.kcBaseBlack})
      : style = body3Semi.copyWith(color: color);
  BoxText.captionSemi(this.text, {Color color = AppColors.kcBaseBlack})
      : style = captionSemi.copyWith(color: color);
  BoxText.buttonSemi(this.text, {Color color = AppColors.kcBaseBlack})
      : style = buttonSemi.copyWith(color: color);
  BoxText.overlineSemi(this.text, {Color color = AppColors.kcBaseBlack})
      : style = overlineSemi.copyWith(color: color);

  //BOLD
  BoxText.heading1Bold(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading1Bold.copyWith(color: color);
  BoxText.heading2Bold(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading2Bold.copyWith(color: color);
  BoxText.heading3Bold(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading3Bold.copyWith(color: color);
  BoxText.heading4Bold(this.text, {Color color = AppColors.kcBaseBlack})
      : style = heading4Bold.copyWith(color: color);
  BoxText.body1Bold(this.text, {Color color = AppColors.kcBaseBlack})
      : style = body1Bold.copyWith(color: color);
  BoxText.body2Bold(this.text, {Color color = AppColors.kcBaseBlack})
      : style = body2Bold.copyWith(color: color);
  BoxText.body3Bold(this.text, {Color color = AppColors.kcBaseBlack})
      : style = body3Bold.copyWith(color: color);
  BoxText.captionBold(this.text, {Color color = AppColors.kcBaseBlack})
      : style = captionBold.copyWith(color: color);
  BoxText.buttonBold(this.text, {Color color = AppColors.kcBaseBlack})
      : style = buttonBold.copyWith(color: color);
  BoxText.overlineBold(this.text, {Color color = AppColors.kcBaseBlack})
      : style = overlineBold.copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}