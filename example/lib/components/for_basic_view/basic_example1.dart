import 'package:example/common/example_data.dart';
import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';

class BasicExample1 extends StatelessWidget {
  final ScrollController scrollController;

  const BasicExample1({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    // print(
    //   ((ExampleData.exampleData1.first as CategoryItem<String>).childrens.first
    //           as CategoryItem<String>)
    //       .childrens
    //       .whereType<SelectableInterface<String>>()
    //       .first
    //       .label,
    // );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Select2dot1<String>(
            selectDataController: SelectDataController(
              data: ExampleData.exampleData1,
              initSelected: [
                ...((ExampleData.exampleData1.first as CategoryItem<String>)
                        .childrens
                        .first as CategoryItem<String>)
                    .childrens
                    .whereType<SelectableInterface<String>>(),
              ],
            ),
            dropdownListData:
                DropdownListData(scrollController: scrollController),
            selectStyle: const SelectStyle(
              pillboxStyle: PillboxStyle(
                pillboxTitleSettings: PillboxTitleSettings(title: 'Example 1'),
              ),
              modalStyle: ModalStyle(
                titleModalSettings: TitleModalSettings(title: 'Example 1'),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Multi select example with initial selected items, group option, searchbar, avatar and extra info',
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
