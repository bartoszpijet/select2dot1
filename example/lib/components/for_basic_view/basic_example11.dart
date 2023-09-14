import 'package:example/common/example_data.dart';
import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';

class BasicExample11 extends StatelessWidget {
  final ScrollController scrollController;

  const BasicExample11({super.key, required this.scrollController});

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
                ItemModel(
                  value: null,
                  itemName: 'Alabama',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Arkansas',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Illonois',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Iowa',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Kansas',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Kentucky',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Louisiana',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Minnesota',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Mississippi',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Missouri',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Oklahoma',
                ),
                ItemModel(
                  value: null,
                  itemName: 'South Dakota',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Texas',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Tennessee',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Arizona',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Colorado',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Idaho',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Montana',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Nebraska',
                ),
                ItemModel(
                  value: null,
                  itemName: 'New Mexico',
                ),
                ItemModel(
                  value: null,
                  itemName: 'North Dakota',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Utah',
                ),
                ItemModel(
                  value: null,
                  itemName: 'Wyoming',
                ),
              ],
            ),
            pillboxContentMultiSettings: const PillboxContentMultiSettings(
              pillboxLayout: PillboxLayout.scroll,
            ),
            scrollController: scrollController,
            pillboxTitleSettings:
                const PillboxTitleSettings(title: 'Example 11'),
            titleModalSettings: const TitleModalSettings(title: 'Example 11'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Description: Scroll horizontal'),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          ),
          const SizedBox(height: 250),
        ],
      ),
    );
  }
}
