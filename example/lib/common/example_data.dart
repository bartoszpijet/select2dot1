import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';

class ExampleData {
  static List<ItemInterface<String>> exampleData1 = [
    CategoryItem<String>(
      label: 'Team Leader',
      addAllChildren: true,
      childrens: [
        CategoryItem<String>(
          label: 'Design',
          childrens: <SelectableItem<String>>[
            SelectableItem<String>(
              value: 'Ed Smith',
              label: 'Ed Smith',
              getLabel: (value) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(value ?? 'null'),
                    const Icon(Icons.ac_unit),
                  ],
                );
              },
            ),
          ],
        ),
        CategoryItem<String>(
          label: 'IT',
          childrens: <SelectableItem<String>>[
            SelectableItem<String>(
              value: 'David Eubanks',
              label: 'David Eubanks',
            ),
            SelectableItem(
              value: 'Stuart Resch',
              label: 'Stuart Resch',
            ),
          ],
        ),
      ],
    ),
    CategoryItem<String>(
      label: 'Programmer',
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: 'David Eubanks',
          label: 'David Eubanks',
        ),
        SelectableItem(
          value: 'Manuel Eyre',
          label: 'Manuel Eyre',
        ),
        SelectableItem(
          value: 'Robert Keller',
          label: 'Robert Keller',
        ),
      ],
    ),
    CategoryItem<String>(
      label: 'UX Designer',
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: 'Shirley Stark',
          label: 'Shirley Stark',
          metadataSearch: {'Edward'},
        ),
        SelectableItem(
          value: 'Wendy Cangelosi',
          label: 'Wendy Cangelosi',
        ),
        SelectableItem(
          value: 'Antoinette Herbert',
          label: 'Antoinette Herbert',
        ),
      ],
    ),
  ];

  static const List<CategoryItem<String>> exampleData2 = [
    CategoryItem<String>(
      label: 'Alaskan/Hawaiian Time Zone',
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: null,
          label: 'Alaska',
        ),
        SelectableItem(
          value: null,
          label: 'Hawaii',
        ),
      ],
    ),
    CategoryItem<String>(
      label: 'Pacific Time Zone',
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: null,
          label: 'California',
        ),
        SelectableItem(
          value: null,
          label: 'Nevada',
        ),
        SelectableItem(
          value: null,
          label: 'Oregon',
        ),
        SelectableItem(
          value: null,
          label: 'Washington',
        ),
      ],
    ),
    CategoryItem<String>(
      label: 'Mountain Time Zone',
      childrens: <SelectableItem<String>>[
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
    CategoryItem<String>(
      label: 'Central Time Zone',
      childrens: <SelectableItem<String>>[
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
      ],
    ),
    CategoryItem<String>(
      label: 'Eastern Time Zone',
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: null,
          label: 'Connecticut',
        ),
        SelectableItem(
          value: null,
          label: 'Massechusetts',
        ),
        SelectableItem(
          value: null,
          label: 'North Carolina',
        ),
        SelectableItem(
          value: null,
          label: 'South Carolina',
        ),
        SelectableItem(
          value: null,
          label: 'Vermont',
        ),
        SelectableItem(
          value: null,
          label: 'West Virginia',
        ),
      ],
    ),
  ];

  static const List<SelectableItem<String>> exampleData3 = [
    SelectableItem(value: 'Alabama1', label: 'Alabama'),
    SelectableItem(value: 'Alabama2', label: 'Alabama'),
    SelectableItem(value: null, label: 'Arkansas'),
    SelectableItem(value: null, label: 'Illonois'),
    SelectableItem(value: null, label: 'Iowa'),
    SelectableItem(value: null, label: 'Kansas'),
    SelectableItem(value: null, label: 'Kentucky'),
    SelectableItem(value: null, label: 'Louisiana'),
    SelectableItem(value: null, label: 'Minnesota'),
    SelectableItem(value: null, label: 'Mississippi'),
    SelectableItem(value: null, label: 'Missouri'),
    SelectableItem(value: null, label: 'Oklahoma'),
    SelectableItem(value: null, label: 'South Dakota'),
    SelectableItem(value: null, label: 'Texas'),
    SelectableItem(value: null, label: 'Tennessee'),
  ];

  static const List<SelectableCategory<String>> exampleData4 = [
    SelectableCategory<String>(
      value: null,
      childrens: [
        SelectableItem(value: null, label: 'Alabama'),
        SelectableItem(value: null, label: 'Arkansas'),
        SelectableItem(value: null, label: 'Illonois'),
        SelectableItem(value: null, label: 'Iowa'),
        SelectableItem(value: null, label: 'Kansas'),
        SelectableItem(value: null, label: 'Kentucky'),
        SelectableItem(value: null, label: 'Louisiana'),
        SelectableItem(value: null, label: 'Minnesota'),
        SelectableItem(value: null, label: 'Mississippi'),
        SelectableItem(value: null, label: 'Missouri'),
        SelectableItem(value: null, label: 'Oklahoma'),
        SelectableItem(value: null, label: 'South Dakota'),
        SelectableItem(value: null, label: 'Texas'),
        SelectableItem(value: null, label: 'Tennessee'),
      ],
    ),
  ];
}
