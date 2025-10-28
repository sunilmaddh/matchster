import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extensions.dart';
import 'package:matchster/shared/widgets/bottomsheet/custom_bottomsheet.dart';

class CommonBottomSheet {
  static void showFullWidthCupertinoPicker({
    required BuildContext context,
    required List<String> listFeet,
    required List<String> listInch,
    required Function(String feet, String inch) onSelected,
    required String defaultFeet,
    required String defaultInch,
    required RxBool isNotFeet,
  }) {
    int selectedFeetIndex = listFeet.indexOf(defaultFeet);
    int selectedInchIndex = listInch.indexOf(defaultInch);

    if (selectedFeetIndex == -1) selectedFeetIndex = 0;
    if (selectedInchIndex == -1) selectedInchIndex = 0;

    FixedExtentScrollController feetController = FixedExtentScrollController(
      initialItem: selectedFeetIndex,
    );
    FixedExtentScrollController inchController = FixedExtentScrollController(
      initialItem: selectedInchIndex,
    );

    String selectedFeet = listFeet[selectedFeetIndex];
    String selectedInch = listInch[selectedInchIndex];

    CustomBottomSheet.show(
      context: context,
      child: SizedBox(
        height: 300.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Expanded(
                child: CupertinoPicker(
                  scrollController: feetController,
                  looping: true,
                  itemExtent: 50,
                  squeeze: 1.0,
                  diameterRatio: 2.0,
                  onSelectedItemChanged: (int index) {
                    selectedFeet = listFeet[index];
                    onSelected(selectedFeet, selectedInch);
                  },
                  children:
                      listFeet.map((e) {
                        return Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: e,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: isNotFeet.isTrue ? "" : " feet",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),

            // Inch Picker
            Obx(
              () => Expanded(
                child: CupertinoPicker(
                  scrollController: inchController,
                  looping: true,
                  itemExtent: 50,
                  squeeze: 1.0,
                  diameterRatio: 2.0,
                  onSelectedItemChanged: (int index) {
                    selectedInch = listInch[index];
                    onSelected(selectedFeet, selectedInch);
                  },
                  children:
                      listInch.map((e) {
                        return Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: isNotFeet.isTrue ? ".$e" : e,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: isNotFeet.isTrue ? "Cm" : " inch",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
