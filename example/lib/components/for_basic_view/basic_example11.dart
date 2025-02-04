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
                SelectableItem(
                  value: null,
                  label: 'Alabama',
                ),
                SelectableItem(
                  value: null,
                  label: 'Arkansas',
                ),
                SelectableItem(
                  value: null,
                  label: 'Illonois',
                ),
                SelectableItem(
                  value: null,
                  label: 'Iowa',
                ),
                SelectableItem(
                  value: null,
                  label: 'Kansas',
                ),
                SelectableItem(
                  value: null,
                  label: 'Kentucky',
                ),
                SelectableItem(
                  value: null,
                  label: 'Louisiana',
                ),
                SelectableItem(
                  value: null,
                  label: 'Minnesota',
                ),
                SelectableItem(
                  value: null,
                  label: 'Mississippi',
                ),
                SelectableItem(
                  value: null,
                  label: 'Missouri',
                ),
                SelectableItem(
                  value: null,
                  label: 'Oklahoma',
                ),
                SelectableItem(
                  value: null,
                  label: 'South Dakota',
                ),
                SelectableItem(
                  value: null,
                  label: 'Texas',
                ),
                SelectableItem(
                  value: null,
                  label: 'Tennessee',
                ),
                SelectableItem(
                  value: null,
                  label: 'Arizona',
                ),
                SelectableItem(
                  value: null,
                  label: 'Colorado',
                ),
                SelectableItem(
                  value: null,
                  label: 'Idaho',
                ),
                SelectableItem(
                  value: null,
                  label: 'Montana',
                ),
                SelectableItem(
                  value: null,
                  label: 'Nebraska',
                ),
                SelectableItem(
                  value: null,
                  label: 'New Mexico',
                ),
                SelectableItem(
                  value: null,
                  label: 'North Dakota',
                ),
                SelectableItem(
                  value: null,
                  label: 'Utah',
                ),
                SelectableItem(
                  value: null,
                  label: 'Wyoming',
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
