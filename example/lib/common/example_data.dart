import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';

class ExampleData {
  static const List<SelectableInterface<String>> exampleData1 = [
    SelectableCategory<String>(
      label: 'Team Leader',
      value: null,
      childrens: [
        SelectableCategory<String>(
          label: 'Design',
          value: null,
          childrens: <SelectableItem<String>>[
            SelectableItem(
              value: null,
              label: 'Ed Smith',
              extraInfo: 'Full time',
              icon: CircleAvatar(
                backgroundColor: Colors.brown,
                child: Text('ES', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        SelectableCategory<String>(
          label: 'IT',
          value: null,
          childrens: <SelectableItem<String>>[
            SelectableItem(
              value: null,
              label: 'David Eubanks',
              extraInfo: 'Full time',
              icon: CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/avatar1.jpg'),
              ),
            ),
            SelectableItem(
              value: null,
              label: 'Stuart Resch',
              extraInfo: 'Part time',
              icon: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('SR', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    ),
    SelectableCategory<String>(
      label: 'Programmer',
      value: null,
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: null,
          label: 'David Eubanks',
          extraInfo: 'Full time',
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/avatar1.jpg'),
          ),
        ),
        SelectableItem(
          value: null,
          label: 'Manuel Eyre',
          extraInfo: 'Full time',
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/avatar2.jpg'),
          ),
        ),
        SelectableItem(
          value: null,
          label: 'Robert Keller',
          extraInfo: 'Part time',
          icon: CircleAvatar(
            backgroundColor: Colors.brown,
            child: Text('RK', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
    SelectableCategory<String>(
      label: 'UX Designer',
      value: null,
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: null,
          label: 'Shirley Stark',
          extraInfo: 'Part time',
          icon: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text('SS', style: TextStyle(color: Colors.white)),
          ),
        ),
        SelectableItem(
          value: null,
          label: 'Wendy Cangelosi',
          extraInfo: 'Part time',
          icon: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('WC', style: TextStyle(color: Colors.white)),
          ),
        ),
        SelectableItem(
          value: null,
          label: 'Antoinette Herbert',
          extraInfo: 'Full time',
          icon: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text('AH', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  ];

  static const List<SelectableCategory<String>> exampleData2 = [
    SelectableCategory<String>(
      label: 'Alaskan/Hawaiian Time Zone',
      value: null,
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: null,
          label: 'Alaska',
          extraInfo: '1395 Lincoln Street',
        ),
        SelectableItem(
          value: null,
          label: 'Hawaii',
          extraInfo: '4880 Michigan Avenue',
        ),
      ],
    ),
    SelectableCategory<String>(
      label: 'Pacific Time Zone',
      value: null,
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: null,
          label: 'California',
          extraInfo: '3878 Chapel Street',
        ),
        SelectableItem(
          value: null,
          label: 'Nevada',
          extraInfo: '4045 Lucy Lane',
        ),
        SelectableItem(
          value: null,
          label: 'Oregon',
          extraInfo: '83 Kenwood Place',
        ),
        SelectableItem(
          value: null,
          label: 'Washington',
          extraInfo: '3573 Pallet Street',
        ),
      ],
    ),
    SelectableCategory<String>(
      label: 'Mountain Time Zone',
      value: null,
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: null,
          label: 'Arizona',
          extraInfo: '4473 Prospect Street',
        ),
        SelectableItem(
          value: null,
          label: 'Colorado',
          extraInfo: '2247 Nuzum Court',
        ),
        SelectableItem(
          value: null,
          label: 'Idaho',
          extraInfo: '1182 Bailey Drive',
        ),
        SelectableItem(
          value: null,
          label: 'Montana',
          extraInfo: '4530 Elk City Road',
        ),
        SelectableItem(
          value: null,
          label: 'Nebraska',
          extraInfo: '2012 Armbrester Drive',
        ),
        SelectableItem(
          value: null,
          label: 'New Mexico',
          extraInfo: '2393 Wines Lane',
        ),
        SelectableItem(
          value: null,
          label: 'North Dakota',
          extraInfo: '4190 Don Jackson Lane',
        ),
        SelectableItem(
          value: null,
          label: 'Utah',
          extraInfo: '468 Green Acres Road',
        ),
        SelectableItem(
          value: null,
          label: 'Wyoming',
          extraInfo: '1898 Sardis Sta',
        ),
      ],
    ),
    SelectableCategory<String>(
      label: 'Central Time Zone',
      value: null,
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: null,
          label: 'Alabama',
          extraInfo: '4446 Jarvisville Road',
        ),
        SelectableItem(
          value: null,
          label: 'Arkansas',
          extraInfo: '4111 Little Acres Lane',
        ),
        SelectableItem(
          value: null,
          label: 'Illonois',
          extraInfo: '3444 Clark Street',
        ),
        SelectableItem(
          value: null,
          label: 'Iowa',
          extraInfo: '4610 Lucy Lane',
        ),
        SelectableItem(
          value: null,
          label: 'Kansas',
          extraInfo: '323 Stratford Drive',
        ),
        SelectableItem(
          value: null,
          label: 'Kentucky',
          extraInfo: '3631 Vine Street',
        ),
        SelectableItem(
          value: null,
          label: 'Louisiana',
          extraInfo: '3283 Godfrey Street',
        ),
        SelectableItem(
          value: null,
          label: 'Minnesota',
          extraInfo: '4838 Ridenour Street',
        ),
        SelectableItem(
          value: null,
          label: 'Mississippi',
          extraInfo: '38 Ray Court',
        ),
        SelectableItem(
          value: null,
          label: 'Missouri',
          extraInfo: '1360 Bingamon Road',
        ),
        SelectableItem(
          value: null,
          label: 'Oklahoma',
          extraInfo: '1636 Sundown Lane',
        ),
        SelectableItem(
          value: null,
          label: 'South Dakota',
          extraInfo: '1091 Elm Drive',
        ),
        SelectableItem(
          value: null,
          label: 'Texas',
          extraInfo: '4764 Bond Street',
        ),
        SelectableItem(
          value: null,
          label: 'Tennessee',
          extraInfo: '4540 Oakmound Road',
        ),
      ],
    ),
    SelectableCategory<String>(
      label: 'Eastern Time Zone',
      value: null,
      childrens: <SelectableItem<String>>[
        SelectableItem(
          value: null,
          label: 'Connecticut',
          extraInfo: '695 Center Avenue',
        ),
        SelectableItem(
          value: null,
          label: 'Massechusetts',
          extraInfo: '2085 Heron Way',
        ),
        SelectableItem(
          value: null,
          label: 'North Carolina',
          extraInfo: '1034 Conference Center Way',
        ),
        SelectableItem(
          value: null,
          label: 'South Carolina',
          extraInfo: '3865 Hickory Street',
        ),
        SelectableItem(
          value: null,
          label: 'Vermont',
          extraInfo: '3159 Sumner Street',
        ),
        SelectableItem(
          value: null,
          label: 'West Virginia',
          extraInfo: '2506 Hall Street',
        ),
      ],
    ),
  ];

  static const List<SelectableCategory<String>> exampleData3 = [
    SelectableCategory<String>(
      label: '',
      value: null,
      childrens: <SelectableItem<String>>[
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
      ],
    ),
  ];

  static const List<SelectableCategory<String>> exampleData4 = [
    SelectableCategory<String>(
      label: '',
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
