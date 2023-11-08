import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';

class ExampleData {
  static const List<SelectModel<String>> exampleData1 = [
    CategoryModel<String>(
      itemName: 'Team Leader',
      itemList: [
        CategoryModel<String>(
          itemName: 'Design',
          itemList: <ItemModel<String>>[
            ItemModel(
              value: null,
              itemName: 'Ed Smith',
              extraInfoSingleItem: 'Full time',
              avatarSingleItem: CircleAvatar(
                backgroundColor: Colors.brown,
                child: Text('ES', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        CategoryModel<String>(
          itemName: 'IT',
          itemList: <ItemModel<String>>[
            ItemModel(
              value: null,
              itemName: 'David Eubanks',
              extraInfoSingleItem: 'Full time',
              avatarSingleItem: CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/avatar1.jpg'),
              ),
            ),
            ItemModel(
              value: null,
              itemName: 'Stuart Resch',
              extraInfoSingleItem: 'Part time',
              avatarSingleItem: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('SR', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    ),
    CategoryModel<String>(
      itemName: 'Programmer',
      itemList: <ItemModel<String>>[
        ItemModel(
          value: null,
          itemName: 'David Eubanks',
          extraInfoSingleItem: 'Full time',
          avatarSingleItem: CircleAvatar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/avatar1.jpg'),
          ),
        ),
        ItemModel(
          value: null,
          itemName: 'Manuel Eyre',
          extraInfoSingleItem: 'Full time',
          avatarSingleItem: CircleAvatar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/avatar2.jpg'),
          ),
        ),
        ItemModel(
          value: null,
          itemName: 'Robert Keller',
          extraInfoSingleItem: 'Part time',
          avatarSingleItem: CircleAvatar(
            backgroundColor: Colors.brown,
            child: Text('RK', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
    CategoryModel<String>(
      itemName: 'UX Designer',
      itemList: <ItemModel<String>>[
        ItemModel(
          value: null,
          itemName: 'Shirley Stark',
          extraInfoSingleItem: 'Part time',
          avatarSingleItem: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text('SS', style: TextStyle(color: Colors.white)),
          ),
        ),
        ItemModel(
          value: null,
          itemName: 'Wendy Cangelosi',
          extraInfoSingleItem: 'Part time',
          avatarSingleItem: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('WC', style: TextStyle(color: Colors.white)),
          ),
        ),
        ItemModel(
          value: null,
          itemName: 'Antoinette Herbert',
          extraInfoSingleItem: 'Full time',
          avatarSingleItem: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text('AH', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  ];

  static const List<CategoryModel<String>> exampleData2 = [
    CategoryModel<String>(
      itemName: 'Alaskan/Hawaiian Time Zone',
      itemList: <ItemModel<String>>[
        ItemModel(
          value: null,
          itemName: 'Alaska',
          extraInfoSingleItem: '1395 Lincoln Street',
        ),
        ItemModel(
          value: null,
          itemName: 'Hawaii',
          extraInfoSingleItem: '4880 Michigan Avenue',
        ),
      ],
    ),
    CategoryModel<String>(
      itemName: 'Pacific Time Zone',
      itemList: <ItemModel<String>>[
        ItemModel(
          value: null,
          itemName: 'California',
          extraInfoSingleItem: '3878 Chapel Street',
        ),
        ItemModel(
          value: null,
          itemName: 'Nevada',
          extraInfoSingleItem: '4045 Lucy Lane',
        ),
        ItemModel(
          value: null,
          itemName: 'Oregon',
          extraInfoSingleItem: '83 Kenwood Place',
        ),
        ItemModel(
          value: null,
          itemName: 'Washington',
          extraInfoSingleItem: '3573 Pallet Street',
        ),
      ],
    ),
    CategoryModel<String>(
      itemName: 'Mountain Time Zone',
      itemList: <ItemModel<String>>[
        ItemModel(
          value: null,
          itemName: 'Arizona',
          extraInfoSingleItem: '4473 Prospect Street',
        ),
        ItemModel(
          value: null,
          itemName: 'Colorado',
          extraInfoSingleItem: '2247 Nuzum Court',
        ),
        ItemModel(
          value: null,
          itemName: 'Idaho',
          extraInfoSingleItem: '1182 Bailey Drive',
        ),
        ItemModel(
          value: null,
          itemName: 'Montana',
          extraInfoSingleItem: '4530 Elk City Road',
        ),
        ItemModel(
          value: null,
          itemName: 'Nebraska',
          extraInfoSingleItem: '2012 Armbrester Drive',
        ),
        ItemModel(
          value: null,
          itemName: 'New Mexico',
          extraInfoSingleItem: '2393 Wines Lane',
        ),
        ItemModel(
          value: null,
          itemName: 'North Dakota',
          extraInfoSingleItem: '4190 Don Jackson Lane',
        ),
        ItemModel(
          value: null,
          itemName: 'Utah',
          extraInfoSingleItem: '468 Green Acres Road',
        ),
        ItemModel(
          value: null,
          itemName: 'Wyoming',
          extraInfoSingleItem: '1898 Sardis Sta',
        ),
      ],
    ),
    CategoryModel<String>(
      itemName: 'Central Time Zone',
      itemList: <ItemModel<String>>[
        ItemModel(
          value: null,
          itemName: 'Alabama',
          extraInfoSingleItem: '4446 Jarvisville Road',
        ),
        ItemModel(
          value: null,
          itemName: 'Arkansas',
          extraInfoSingleItem: '4111 Little Acres Lane',
        ),
        ItemModel(
          value: null,
          itemName: 'Illonois',
          extraInfoSingleItem: '3444 Clark Street',
        ),
        ItemModel(
          value: null,
          itemName: 'Iowa',
          extraInfoSingleItem: '4610 Lucy Lane',
        ),
        ItemModel(
          value: null,
          itemName: 'Kansas',
          extraInfoSingleItem: '323 Stratford Drive',
        ),
        ItemModel(
          value: null,
          itemName: 'Kentucky',
          extraInfoSingleItem: '3631 Vine Street',
        ),
        ItemModel(
          value: null,
          itemName: 'Louisiana',
          extraInfoSingleItem: '3283 Godfrey Street',
        ),
        ItemModel(
          value: null,
          itemName: 'Minnesota',
          extraInfoSingleItem: '4838 Ridenour Street',
        ),
        ItemModel(
          value: null,
          itemName: 'Mississippi',
          extraInfoSingleItem: '38 Ray Court',
        ),
        ItemModel(
          value: null,
          itemName: 'Missouri',
          extraInfoSingleItem: '1360 Bingamon Road',
        ),
        ItemModel(
          value: null,
          itemName: 'Oklahoma',
          extraInfoSingleItem: '1636 Sundown Lane',
        ),
        ItemModel(
          value: null,
          itemName: 'South Dakota',
          extraInfoSingleItem: '1091 Elm Drive',
        ),
        ItemModel(
          value: null,
          itemName: 'Texas',
          extraInfoSingleItem: '4764 Bond Street',
        ),
        ItemModel(
          value: null,
          itemName: 'Tennessee',
          extraInfoSingleItem: '4540 Oakmound Road',
        ),
      ],
    ),
    CategoryModel<String>(
      itemName: 'Eastern Time Zone',
      itemList: <ItemModel<String>>[
        ItemModel(
          value: null,
          itemName: 'Connecticut',
          extraInfoSingleItem: '695 Center Avenue',
        ),
        ItemModel(
          value: null,
          itemName: 'Massechusetts',
          extraInfoSingleItem: '2085 Heron Way',
        ),
        ItemModel(
          value: null,
          itemName: 'North Carolina',
          extraInfoSingleItem: '1034 Conference Center Way',
        ),
        ItemModel(
          value: null,
          itemName: 'South Carolina',
          extraInfoSingleItem: '3865 Hickory Street',
        ),
        ItemModel(
          value: null,
          itemName: 'Vermont',
          extraInfoSingleItem: '3159 Sumner Street',
        ),
        ItemModel(
          value: null,
          itemName: 'West Virginia',
          extraInfoSingleItem: '2506 Hall Street',
        ),
      ],
    ),
  ];

  static const List<CategoryModel<String>> exampleData3 = [
    CategoryModel<String>(
      itemName: '',
      itemList: <ItemModel<String>>[
        ItemModel(value: 'Alabama1', itemName: 'Alabama'),
        ItemModel(value: 'Alabama2', itemName: 'Alabama'),
        ItemModel(value: null, itemName: 'Arkansas'),
        ItemModel(value: null, itemName: 'Illonois'),
        ItemModel(value: null, itemName: 'Iowa'),
        ItemModel(value: null, itemName: 'Kansas'),
        ItemModel(value: null, itemName: 'Kentucky'),
        ItemModel(value: null, itemName: 'Louisiana'),
        ItemModel(value: null, itemName: 'Minnesota'),
        ItemModel(value: null, itemName: 'Mississippi'),
        ItemModel(value: null, itemName: 'Missouri'),
        ItemModel(value: null, itemName: 'Oklahoma'),
        ItemModel(value: null, itemName: 'South Dakota'),
        ItemModel(value: null, itemName: 'Texas'),
        ItemModel(value: null, itemName: 'Tennessee'),
      ],
    ),
  ];

  static const List<CategoryModel<String>> exampleData4 = [
    CategoryModel<String>(
      itemName: '',
      itemList: [
        ItemModel(value: null, itemName: 'Alabama'),
        ItemModel(value: null, itemName: 'Arkansas'),
        ItemModel(value: null, itemName: 'Illonois'),
        ItemModel(value: null, itemName: 'Iowa'),
        ItemModel(value: null, itemName: 'Kansas'),
        ItemModel(value: null, itemName: 'Kentucky'),
        ItemModel(value: null, itemName: 'Louisiana'),
        ItemModel(value: null, itemName: 'Minnesota'),
        ItemModel(value: null, itemName: 'Mississippi'),
        ItemModel(value: null, itemName: 'Missouri'),
        ItemModel(value: null, itemName: 'Oklahoma'),
        ItemModel(value: null, itemName: 'South Dakota'),
        ItemModel(value: null, itemName: 'Texas'),
        ItemModel(value: null, itemName: 'Tennessee'),
      ],
    ),
  ];
}
