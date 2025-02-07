import 'package:flutter/material.dart';
import 'package:fuzzysearch/fuzzysearch.dart';
import 'package:select2dot1/src/models/category_item.dart';
import 'package:select2dot1/src/models/item_interface.dart';
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
  final Iterable<ItemInterface<T>> data;

  /// Search results.
  /// First it will be same as [data].
  final List<ItemInterface<T>> results;

  /// Hide category if Category itemList is empty.
  /// Default to [true].
  final bool hideEmptyCategory;

  /// Hide category after search.
  /// Default to [true].
  final bool hideCategoryAfterSearch;

  /// If [true] search will include category names.
  /// Default to [false].
  final bool searchInCategories;

  /// Getter for [results] find by [findSearchDataResults].
  List<ItemInterface<T>> get getResults => results;

  /// Creating an argument constructor of [SearchControllerSelect2dot1] class.
  /// [data] is data to search. [data] is required.
  SearchControllerSelect2dot1(
    this.data, {
    this.fuzzyOptions,
    this.hideEmptyCategory = true,
    this.hideCategoryAfterSearch = true,
    this.searchInCategories = false,
  }) : results = List.of(data) // Fix pass by reference.
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
      Iterable<Result<ItemInterface<T>>> tmpResults =
          await fuzzySearch(flatData, searchText);
      for (Result<ItemInterface<T>> searchResult in tmpResults) {
        if (searchResult.identifier != null &&
            searchResult.identifier is SelectableInterface<T>) {
          // Null check done above.
          // ignore: avoid-non-null-assertion
          results.add(searchResult.identifier!);
        }
      }
    } else {
      List<ItemInterface<T>> resultsWithScore =
          await addFromList(data, searchText);

      resultsWithScore.sort((a, b) => a.score.compareTo(b.score));
      results.addAll(resultsWithScore);
    }

    int newLength = countLength();
    if (oldLength != newLength) {
      notifyListeners();
    }
  }

  /// Count length of search results function.
  int countLength() {
    int length = 0;
    for (ItemInterface<T> element in results) {
      if (element is CategoryItem<T>) {
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

  List<SelectableInterface<T>> addChildrens(Iterable<ItemInterface<T>> list) {
    List<SelectableInterface<T>> tempFlatData = [];
    for (ItemInterface<T> element in list) {
      if (element is CategoryItem<T>) {
        tempFlatData.addAll(
          addChildrens(element.childrens),
        );
      } else if (element is SelectableInterface<T>) {
        tempFlatData.add(element);
      }
    }

    return tempFlatData;
  }

  Future<List<ItemInterface<T>>> addToResults(
    Iterable<ItemInterface<T>> dataToAdd,
    String searchText,
  ) async {
    List<ItemInterface<T>> resultsWithScore = [];

    List<Result<ItemInterface<T>>> tmpResults =
        await fuzzySearch(dataToAdd, searchText);
    for (Result<ItemInterface<T>> searchResult in tmpResults) {
      ItemInterface<T>? resultItem = searchResult.identifier;
      if (resultItem != null) {
        ItemInterface<T> newScoreItem =
            resultItem.copyWithScore(searchResult.score);
        resultsWithScore.add(newScoreItem);
      }
    }

    return resultsWithScore;
  }

  Future<List<ItemInterface<T>>> addFromList(
    Iterable<ItemInterface<T>> data,
    String searchText,
  ) async {
    List<ItemInterface<T>> resultsWithScore = [];

    Iterable<ItemInterface<T>> selectableData = searchInCategories
        ? data
        : data.where((element) => element is! CategoryItem<T>).toList();
    resultsWithScore.addAll(await addToResults(selectableData, searchText));

    List<CategoryItem<T>> categoryData =
        data.whereType<CategoryItem<T>>().toList();

    for (CategoryItem<T> category in categoryData) {
      List<ItemInterface<T>> items = await addFromList(
        category.childrens,
        searchText,
      );
      if (items.isNotEmpty) {
        ItemInterface<T> newItem = category.copyWithScoreAndList(
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

  Future<List<Result<ItemInterface<T>>>> fuzzySearch(
    Iterable<ItemInterface<T>> dataToSearchIn,
    String searchText,
  ) {
    Map<String, ItemInterface<T>> searchMap = {};
    for (ItemInterface<T> element in dataToSearchIn) {
      searchMap.addAll({
        element.label: element,
        for (String metaSearch in element.metadataSearch) metaSearch: element,
      });
    }

    Fuzzy<ItemInterface<T>> fuse = Fuzzy.withIdentifiers(
      searchMap,
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
