import 'package:select2dot1/src/models/select_model.dart';

/// This is a model class which score.
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
    SelectModel<T> model,
    this.score,
    List<SelectModel<T>> itemList,
  ) : super(
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
