import 'package:example/my_app.dart';
import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';

void main() {
  // To see all example available on https://select2dot1.site,
  // you have to download the source code available on https://github.com/romanjrdykyj/select2dot1
  // and go to folder example.
  runApp(const MyApp());
  // runApp(const SimpleExampleApp());
}

// Below you can see the code for the simple example app, but it is not included in the example available on https://select2dot1.site

class SimpleExampleApp extends StatefulWidget {
  const SimpleExampleApp({super.key});

  @override
  State<SimpleExampleApp> createState() => _SimpleExampleAppState();
}

class _SimpleExampleAppState extends State<SimpleExampleApp> {
  ScrollController scrollController = ScrollController();

  static const List<SelectableCategory<String>> exampleData = [
    SelectableCategory(
      label: 'Central Time Zone',
      value: 'Central Time Zone',
      childrens: <SelectableItem<String>>[
        SelectableItem<String>(
          label: 'Alabama',
          value: 'Alabama',
        ),
        SelectableItem(label: 'Arkansas', value: 'Arkansas'),
        SelectableItem(label: 'Illonois', value: 'Illonois'),
      ],
    ),
    SelectableCategory(
      label: 'Pacific Time Zone',
      value: 'Pacific Time Zone',
      childrens: <SelectableItem<String>>[
        SelectableItem(label: 'California', value: 'California'),
        SelectableItem(label: 'Nevada', value: 'Nevada'),
        SelectableItem(label: 'Oregon', value: 'Oregon'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Basic Example'),
          titleTextStyle: const TextStyle(
            color: Color(0xff001029),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          foregroundColor: const Color(0xff001029),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: Select2dot1<String>(
                    selectDataController: SelectDataController(
                      data: exampleData,
                    ),
                    dropdownListData: DropdownListData(
                      scrollController: scrollController,
                    ),
                  ),
                ),
                const SizedBox(height: 250),
                Select2dot1<String>(
                  selectDataController: SelectDataController(
                    data: exampleData,
                    initSelected: const [
                      SelectableItem(
                        label: 'Oregon',
                        value: 'Oregon',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 250),
                Select2dot1<String>(
                  selectDataController: SelectDataController(
                    data: exampleData,
                    isMultiSelect: false,
                    initSelected: const [
                      SelectableItem(label: 'Arkansas', value: 'Arkansas'),
                    ],
                  ),
                  dropdownListData: DropdownListData(
                    scrollController: scrollController,
                  ),
                ),
                const SizedBox(height: 250),
                Select2dot1<String>(
                  selectDataController: SelectDataController(
                    data: exampleData,
                    initSelected: const [
                      SelectableItem(label: 'Illonois', value: 'Illonois'),
                      SelectableItem(label: 'California', value: 'California'),
                      SelectableItem(label: 'Alabama', value: 'Alabama'),
                    ],
                  ),
                  // item: const ModalItemSettings(
                  //   showExtraInfo: false,
                  // ),

                  dropdownListData: DropdownListData(
                    scrollController: scrollController,
                  ),
                  selectStyle: const SelectStyle(
                    selectSingleSettings:
                        SelectSingleSettings(showExtraInfo: false),
                    pillboxStyle: PillboxStyle(
                      pillboxContentMultiSettings: PillboxContentMultiSettings(
                        pillboxOverload: 5,
                      ),
                      pillboxTitleSettings:
                          PillboxTitleSettings(title: 'Example 7'),
                    ),
                    modalStyle: ModalStyle(
                      titleModalSettings:
                          TitleModalSettings(title: 'Example 7'),
                    ),
                  ),
                ),
                const SizedBox(height: 250),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
