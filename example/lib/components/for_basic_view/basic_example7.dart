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
          Select2dot1(
            selectDataController: SelectDataController(
              data: ExampleData.exampleData2,
              initSelected: const [
                ItemModel(value: null, itemName: 'Alaska'),
                ItemModel(value: null, itemName: 'California'),
                ItemModel(value: null, itemName: 'Hawaii'),
                ItemModel(value: null, itemName: 'Arizona'),
                ItemModel(value: null, itemName: 'Colorado'),
              ],
            ),
            pillboxContentMultiSettings:
                const PillboxContentMultiSettings(pillboxOverload: 5),
            selectSingleSettings:
                const SelectSingleSettings(showExtraInfo: false),
            modalItemSettings: const ModalItemSettings(
              showExtraInfo: false,
            ),
            overlayItemSettings: const OverlayItemSettings(
              showExtraInfo: false,
            ),
            scrollController: scrollController,
            pillboxTitleSettings:
                const PillboxTitleSettings(title: 'Example 7'),
            titleModalSettings: const TitleModalSettings(title: 'Example 7'),
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
