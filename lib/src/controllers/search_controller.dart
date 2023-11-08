import 'package:flutter/material.dart';
import 'package:fuzzysearch/fuzzysearch.dart';
import 'package:select2dot1/src/models/category_model.dart';
import 'package:select2dot1/src/models/select_model.dart';

/// SearchController is a class that will be used to search data.
// Its okay.
// ignore: prefer-match-file-name
class SearchControllerSelect2dot1<T> extends ChangeNotifier {
  /// Old length memory of search results.
  int oldLength = 0;

  /// Options for FuzzySearch default values are:
  /// [FuzzyOptions.findAllMatches] = true,
  /// [FuzzyOptions.tokenize] = true,
  /// [FuzzyOptions.threshold] = 0.5.
  final FuzzyOptions? fuzzyOptions;

  /// Data to search.
  /// It is required.
  final List<SelectModel<T>> data;

  /// Search results.
  /// First it will be same as [data].
  final List<SelectModel<T>> results;

  /// Hide category if [SelectModel.itemList] is empty.
  /// Default to [true].
  final bool hideEmptyCategory;

  /// Getter for [results] find by [findSearchDataResults].
  List<SelectModel<T>> get getResults => results;

  /// Creating an argument constructor of [SearchControllerSelect2dot1] class.
  /// [data] is data to search. [data] is required.
  SearchControllerSelect2dot1(
    this.data, {
    this.fuzzyOptions,
    this.hideEmptyCategory = false,
  }) : results = data.toList() // Fix pass by reference.
  {
    oldLength = countLength();
  }

  /// Find search data results function.
  /// This function will be used to find search data results.
  /// [value] is required string pattern to search.
  Future<void> findSearchDataResults(String value) async {
    // Will be improve in next version.
    oldLength = countLength();
    if (value == '') {
      results.clear();
      results.addAll(data);
      int newLength = countLength();
      if (oldLength != newLength) {
        notifyListeners();
      }

      return;
    }

    results.clear();
    for (SelectModel<T> element in flatData) {
      Fuzzy<SelectModel<T>> fuse = Fuzzy.withIdentifiers(
        {
          element.itemName: element,
          // if (element.isCategory)
          //   for (SelectModel<T> singleItem in element.itemList)
          //     singleItem.itemName: singleItem,
        },
        options: fuzzyOptions ??
            FuzzyOptions(
              findAllMatches: true,
              tokenize: true,
              threshold: 0.5,
            ),
      );
      List<Result<SelectModel<T>>> tmpResults = await fuse.search(value);
      for (Result<SelectModel<T>> searchResult in tmpResults) {
        if (searchResult.identifier != null) {
          // Null check done above.
          // ignore: avoid-non-null-assertion
          results.add(searchResult.identifier!);
        }
      }

      // if (tempSingleItemCategoryList.isNotEmpty) {
      //   if (element.isCategory) {
      //     results.add(
      //       CategoryModel(
      //         itemName: element.itemName,
      //         itemList: tempSingleItemCategoryList,
      //       ),
      //     );
      //   }
      // }
    }
    print(results);

    int newLength = countLength();
    if (oldLength != newLength) {
      notifyListeners();
    }
  }

  /// Count length of search results function.
  int countLength() {
    int length = 0;
    for (SelectModel<T> element in results) {
      if (element.isCategory) {
        int toAdd = element.itemList.length;
        if (toAdd == 0 && hideEmptyCategory) continue;
        length += element.itemList.length + 1;
      } else {
        length++;
      }
    }

    return length;
  }

  List<SelectModel<T>> get flatData => addChildrens(data);

  List<SelectModel<T>> addChildrens(List<SelectModel<T>> list) {
    List<SelectModel<T>> tempFlatData = [];
    for (SelectModel<T> element in list) {
      if (element.isCategory) {
        tempFlatData.addAll(addChildrens(element.itemList));
      } else {
        tempFlatData.add(element);
      }
    }
    return tempFlatData;
  }
}
