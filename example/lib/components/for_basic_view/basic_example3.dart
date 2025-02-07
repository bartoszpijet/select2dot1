import 'package:example/common/example_data.dart';
import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';

class BasicExample3 extends StatelessWidget {
  final ScrollController scrollController;

  const BasicExample3({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Select2dot1<String>(
            selectDataController: SelectDataController(
              data: ExampleData.exampleData1,
              isMultiSelect: false,
              initSelected: const [
                SelectableItem(value: null, label: 'Manuel Eyre'),
              ],
            ),
            isSearchable: false,
            dropdownListData: DropdownListData(
              scrollController: scrollController,
            ),
            selectStyle: const SelectStyle(
              selectSingleSettings: SelectSingleSettings(showExtraInfo: false),
              pillboxStyle: PillboxStyle(
                pillboxTitleSettings: PillboxTitleSettings(title: 'Example 3'),
              ),
              modalStyle: ModalStyle(
                titleModalSettings: TitleModalSettings(title: 'Example 3'),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Single select example with initial selected item, group option, avatar and extra info (but extra info only in dropdown, not in pillbox); without searchbar',
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
