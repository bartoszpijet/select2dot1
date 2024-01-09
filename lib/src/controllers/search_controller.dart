import 'package:flutter/material.dart';
import 'package:fuzzysearch/fuzzysearch.dart';
import 'package:select2dot1/src/models/scoreable_select_model.dart';
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

  /// Hide category after search.
  /// Default to [true].
  final bool hideCategoryAfterSearch;

  /// If [true] search will include category names.
  /// Default to [false].
  final bool searchInCategories;

  /// Getter for [results] find by [findSearchDataResults].
  List<SelectModel<T>> get getResults => results;

  /// Creating an argument constructor of [SearchControllerSelect2dot1] class.
  /// [data] is data to search. [data] is required.
  SearchControllerSelect2dot1(
    this.data, {
    this.fuzzyOptions,
    this.hideEmptyCategory = true,
    this.hideCategoryAfterSearch = true,
    this.searchInCategories = false,
  }) : results = data.toList() // Fix pass by reference.
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
      List<Result<SelectModel<T>>> tmpResults =
          await fuzzySearch(flatData, searchText);
      for (Result<SelectModel<T>> searchResult in tmpResults) {
        if (searchResult.identifier != null) {
          // Null check done above.
          // ignore: avoid-non-null-assertion
          results.add(searchResult.identifier!);
        }
      }
    } else {
      List<ScoreableSelectModel<T>> resultsWithScore =
          await addFromList(data, searchText);

      resultsWithScore.sort((a, b) => a.score.compareTo(b.score));
      results.addAll(
        resultsWithScore.cast<SelectModel<T>>(),
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

  Future<List<ScoreableSelectModel<T>>> addToResults(
    List<SelectModel<T>> dataToAdd,
    String searchText,
  ) async {
    List<ScoreableSelectModel<T>> resultsWithScore = [];

    List<Result<SelectModel<T>>> tmpResults =
        await fuzzySearch(dataToAdd, searchText);
    for (Result<SelectModel<T>> searchResult in tmpResults) {
      SelectModel<T>? resultItem = searchResult.identifier;

      if (resultItem != null) {
        ScoreableSelectModel<T> newItem;
        if (resultItem.itemList.isEmpty) {
          newItem = ScoreableSelectModel.fromModel(
            resultItem,
            searchResult.score,
          );
        } else {
          newItem = ScoreableSelectModel.fromModelWithNewList(
            resultItem,
            searchResult.score,
            [],
          );
        }
        resultsWithScore.add(newItem);
      }
    }

    return resultsWithScore;
  }

  Future<List<ScoreableSelectModel<T>>> addFromList(
    List<SelectModel<T>> data,
    String searchText,
  ) async {
    List<ScoreableSelectModel<T>> resultsWithScore = [];

    List<SelectModel<T>> selectableData = searchInCategories
        ? data
        : data.where((element) => !element.isCategory).toList();
    resultsWithScore.addAll(await addToResults(selectableData, searchText));

    List<SelectModel<T>> categoryData =
        data.where((element) => element.isCategory).toList();

    for (SelectModel<T> category in categoryData) {
      List<ScoreableSelectModel<T>> items = await addFromList(
        category.itemList,
        searchText,
      );
      if (items.isNotEmpty) {
        ScoreableSelectModel<T> newItem =
            ScoreableSelectModel.fromModelWithNewList(
          category,
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

  Future<List<Result<SelectModel<T>>>> fuzzySearch(
    List<SelectModel<T>> dataToSearchIn,
    String searchText,
  ) {
    Fuzzy<SelectModel<T>> fuse = Fuzzy.withIdentifiers(
      {
        for (SelectModel<T> element in dataToSearchIn)
          element.itemName: element,
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
