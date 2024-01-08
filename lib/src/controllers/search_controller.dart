import 'package:flutter/material.dart';
import 'package:fuzzysearch/fuzzysearch.dart';
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
  final bool hideCategoryAfterSearch = false;

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
    // for (SelectModel<T> element in flatData) {
    if (hideCategoryAfterSearch) {
      Fuzzy<SelectModel<T>> fuse = Fuzzy.withIdentifiers(
        {for (SelectModel<T> element in flatData) element.itemName: element},
        options: fuzzyOptions ??
            FuzzyOptions(
              findAllMatches: true,
              tokenize: true,
              threshold: 0.5,
            ),
      );
      List<Result<SelectModel<T>>> tmpResults = await fuse.search(searchText);
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

    Fuzzy<SelectModel<T>> fuse = Fuzzy.withIdentifiers(
      {for (SelectModel<T> element in dataToAdd) element.itemName: element},
      options: fuzzyOptions ??
          FuzzyOptions(
            findAllMatches: true,
            tokenize: true,
            threshold: 0.5,
          ),
    );
    List<Result<SelectModel<T>>> tmpResults = await fuse.search(searchText);
    for (Result<SelectModel<T>> searchResult in tmpResults) {
      if (searchResult.identifier != null) {
        // Null check done above.
        // ignore: avoid-non-null-assertion
        resultsWithScore.add(
          ScoreableSelectModel.fromModel(
            searchResult.identifier!,
            searchResult.score,
          ),
        );
      }
    }

    return resultsWithScore;
  }

  Future<List<ScoreableSelectModel<T>>> addFromList(
    List<SelectModel<T>> data,
    String searchText,
  ) async {
    List<ScoreableSelectModel<T>> resultsWithScore = [];

    List<SelectModel<T>> selectableData =
        data.where((element) => !element.isCategory).toList();
    resultsWithScore.addAll(await addToResults(selectableData, searchText));

    List<SelectModel<T>> categoryData =
        data.where((element) => element.isCategory).toList();

    for (SelectModel<T> category in categoryData) {
      List<ScoreableSelectModel<T>> items = await addFromList(
        category.itemList,
        searchText,
      );
      if (items.isNotEmpty) {
        resultsWithScore.add(
          ScoreableSelectModel.fromModelWithNewList(
            category,
            items.fold<double>(
              1,
              (value, element) => element.score < value ? element.score : value,
            ),
            items,
          ),
        );
      }
    }
    resultsWithScore.sort((a, b) => a.score.compareTo(b.score));

    return resultsWithScore;
  }
}

/// This is a model class which contains the name of the category and the list of items in the category.
class ScoreableSelectModel<T> extends SelectModel<T> {
  final double score;

  /// Creating an argument constructor of [ScoreableSelectModel] class.
  const ScoreableSelectModel({
    required super.itemName,
    required super.itemList,
    required this.score,
    super.value,
    super.extraInfoSingleItem,
    super.avatarSingleItem,
    super.enabled,
    super.isCategory,
  });

  ScoreableSelectModel.fromModel(SelectModel<T> model, this.score)
      : super(
          itemName: model.itemName,
          itemList: model.itemList,
          value: model.value,
          extraInfoSingleItem: model.extraInfoSingleItem,
          avatarSingleItem: model.avatarSingleItem,
          enabled: model.enabled,
          isCategory: model.isCategory,
        );
  ScoreableSelectModel.fromModelWithNewList(
      SelectModel<T> model, this.score, List<SelectModel<T>> itemList)
      : super(
          itemName: model.itemName,
          itemList: itemList,
          value: model.value,
          extraInfoSingleItem: model.extraInfoSingleItem,
          avatarSingleItem: model.avatarSingleItem,
          enabled: model.enabled,
          isCategory: model.isCategory,
        );

  @override
  String toString() {
    return '\nScoreableSelectModel(itemName=$itemName, score=$score ,isCategory=$isCategory, itemList=$itemList)\n';
  }
}
