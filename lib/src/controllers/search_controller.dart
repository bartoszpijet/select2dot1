import 'package:flutter/material.dart';
import 'package:fuzzysearch/fuzzysearch.dart';
import 'package:select2dot1/src/models/selectable_category.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';

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
  final List<SelectableInterface<T>> data;

  /// Search results.
  /// First it will be same as [data].
  final List<SelectableInterface<T>> results;

  /// Hide category if [SelectableInterface.itemList] is empty.
  /// Default to [true].
  final bool hideEmptyCategory;

  /// Hide category after search.
  /// Default to [true].
  final bool hideCategoryAfterSearch;

  /// If [true] search will include category names.
  /// Default to [false].
  final bool searchInCategories;

  /// Getter for [results] find by [findSearchDataResults].
  List<SelectableInterface<T>> get getResults => results;

  /// Creating an argument constructor of [SearchControllerSelect2dot1] class.
  /// [data] is data to search. [data] is required.
  SearchControllerSelect2dot1(
    this.data, {
    this.fuzzyOptions,
    this.hideEmptyCategory = true,
    this.hideCategoryAfterSearch = true,
    this.searchInCategories = false,
  }) : results = data
            .cast<SelectableInterface<T>>()
            .toList() // Fix pass by reference.
  {
    oldLength = countLength();
    if (searchInCategories && (hideCategoryAfterSearch || hideEmptyCategory)) {
      debugPrint(
        'WARNING!: searchInCategories won\'t work properly with hideCategoryAfterSearch or hideEmptyCategory setted to true.',
      );
    }
  }

  /// Find search data results function.
  /// This function will be used to find search data results.
  /// [searchText] is required string pattern to search.
  Future<void> findSearchDataResults(String searchText) async {
    oldLength = countLength();
    if (searchText == '') {
      results.clear();
      results.addAll(data);
      int newLength = countLength();
      if (oldLength != newLength) {
        notifyListeners();
      }

      return;
    }

    results.clear();

    if (hideCategoryAfterSearch) {
      List<Result<SelectableInterface<T>>> tmpResults =
          await fuzzySearch(flatData, searchText);
      for (Result<SelectableInterface<T>> searchResult in tmpResults) {
        if (searchResult.identifier != null) {
          // Null check done above.
          // ignore: avoid-non-null-assertion
          results.add(searchResult.identifier!);
        }
      }
    } else {
      List<SelectableInterface<T>> resultsWithScore =
          await addFromList(data, searchText);

      resultsWithScore.sort((a, b) => a.score.compareTo(b.score));
      results.addAll(
        resultsWithScore.cast<SelectableInterface<T>>(),
      );
    }

    int newLength = countLength();
    if (oldLength != newLength) {
      notifyListeners();
    }
  }

  /// Count length of search results function.
  int countLength() {
    int length = 0;
    for (SelectableInterface<T> element in results) {
      if (element is SelectableCategory<T>) {
        int toAdd = element.childrens.length;
        if (toAdd == 0 && hideEmptyCategory) continue;
        length += element.childrens.length + 1;
      } else {
        length++;
      }
    }

    return length;
  }

  List<SelectableInterface<T>> get flatData => addChildrens(data);

  List<SelectableInterface<T>> addChildrens(List<SelectableInterface<T>> list) {
    List<SelectableInterface<T>> tempFlatData = [];
    for (SelectableInterface<T> element in list) {
      if (element is SelectableCategory<T>) {
        tempFlatData.addAll(
          addChildrens(element.childrens.cast<SelectableInterface<T>>()),
        );
      } else {
        tempFlatData.add(element);
      }
    }

    return tempFlatData;
  }

  Future<List<SelectableInterface<T>>> addToResults(
    List<SelectableInterface<T>> dataToAdd,
    String searchText,
  ) async {
    List<SelectableInterface<T>> resultsWithScore = [];

    List<Result<SelectableInterface<T>>> tmpResults =
        await fuzzySearch(dataToAdd, searchText);
    for (Result<SelectableInterface<T>> searchResult in tmpResults) {
      SelectableInterface<T>? resultItem = searchResult.identifier;

      if (resultItem != null) {
        SelectableInterface<T> newScoreItem =
            resultItem.copyWithScore(searchResult.score);
        resultsWithScore.add(newScoreItem);
      }
    }

    return resultsWithScore;
  }

  Future<List<SelectableInterface<T>>> addFromList(
    List<SelectableInterface<T>> data,
    String searchText,
  ) async {
    List<SelectableInterface<T>> resultsWithScore = [];

    List<SelectableInterface<T>> selectableData = searchInCategories
        ? data
        : data.where((element) => element is! SelectableCategory<T>).toList();
    resultsWithScore.addAll(await addToResults(selectableData, searchText));

    List<SelectableCategory<T>> categoryData =
        data.whereType<SelectableCategory<T>>().toList();

    for (SelectableCategory<T> category in categoryData) {
      List<SelectableInterface<T>> items = await addFromList(
        category.childrens,
        searchText,
      );
      if (items.isNotEmpty) {
        SelectableInterface<T> newItem = category.copyWithScoreAndList(
          items.fold<double>(
            1,
            (value, element) => element.score < value ? element.score : value,
          ),
          items,
        );
        int index = resultsWithScore.indexOf(newItem);
        if (index == -1) {
          resultsWithScore.add(newItem);
        } else {
          resultsWithScore.setAll(index, [newItem]);
        }
      }
    }
    resultsWithScore.sort((a, b) => a.score.compareTo(b.score));

    return resultsWithScore;
  }

  Future<List<Result<SelectableInterface<T>>>> fuzzySearch(
    List<SelectableInterface<T>> dataToSearchIn,
    String searchText,
  ) {
    Fuzzy<SelectableInterface<T>> fuse = Fuzzy.withIdentifiers(
      {
        for (SelectableInterface<T> element in dataToSearchIn)
          element.finalLabel: element,
      },
      options: fuzzyOptions ??
          FuzzyOptions(
            findAllMatches: true,
            tokenize: true,
            threshold: 0.5,
          ),
    );

    return fuse.search(searchText);
  }
}
