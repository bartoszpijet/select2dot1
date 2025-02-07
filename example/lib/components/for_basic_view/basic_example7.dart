import 'package:example/common/example_data.dart';
import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';

class BasicExample7 extends StatelessWidget {
  final ScrollController scrollController;

  const BasicExample7({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Select2dot1<String>(
            selectDataController: SelectDataController(
              data: ExampleData.exampleData2,
              initSelected: const [
                SelectableItem(value: null, label: 'Alaska'),
                SelectableItem(value: null, label: 'California'),
                SelectableItem(value: null, label: 'Hawaii'),
                SelectableItem(value: null, label: 'Arizona'),
                SelectableItem(value: null, label: 'Colorado'),
              ],
            ),
            // modalItemSettings: const ModalItemSettings(
            //   showExtraInfo: false,
            // ),

            dropdownListData: DropdownListData(
              scrollController: scrollController,
            ),
            selectStyle: const SelectStyle(
              selectSingleSettings: SelectSingleSettings(showExtraInfo: false),
              pillboxStyle: PillboxStyle(
                pillboxTitleSettings: PillboxTitleSettings(title: 'Example 7'),
                pillboxContentMultiSettings:
                    PillboxContentMultiSettings(pillboxOverload: 5),
              ),
              modalStyle: ModalStyle(
                titleModalSettings: TitleModalSettings(title: 'Example 7'),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Description: Overload info in pillbox',
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
