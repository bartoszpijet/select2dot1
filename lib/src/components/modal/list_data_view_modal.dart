import 'package:flutter/material.dart';
import 'package:select2dot1/src/components/modal/modal_item_widget.dart';
import 'package:select2dot1/src/components/modal/modal_category_widget.dart';
import 'package:select2dot1/src/components/modal/loading_data_modal.dart';
import 'package:select2dot1/src/components/modal/search_empty_info_modal.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/category_model.dart';
import 'package:select2dot1/src/models/item_model.dart';
import 'package:select2dot1/src/models/select_model.dart';
import 'package:select2dot1/src/settings/global_settings.dart';
import 'package:select2dot1/src/settings/modal/modal_item_settings.dart';
import 'package:select2dot1/src/settings/modal/modal_category_settings.dart';
import 'package:select2dot1/src/settings/modal/list_data_view_modal_settings.dart';
import 'package:select2dot1/src/settings/modal/loading_data_modal_settings.dart';
import 'package:select2dot1/src/settings/modal/search_empty_info_modal_settings.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class ListDataViewModal<T> extends StatefulWidget {
  final ScrollController scrollController;
  final SearchControllerSelect2dot1<T> searchController;
  final SelectDataController<T> selectDataController;
  final LoadingDataModalBuilder? loadingDataModalBuilder;
  final LoadingDataModalSettings loadingDataModalSettings;
  final SearchEmptyInfoModalBuilder? searchEmptyInfoModalBuilder;
  final SearchEmptyInfoModalSettings searchEmptyInfoModalSettings;
  final ListDataViewModalBuilder<T>? listDataViewModalBuilder;
  final ListDataViewModalSettings listDataViewModalSettings;
  final CategoryItemModalBuilder<T>? modalItemBuilder;
  final ModalItemSettings modalItemSettings;
  final CategoryNameModalBuilder<T>? modalCategoryBuilder;
  final ModalCategorySettings modalCategorySettings;
  final GlobalSettings globalSettings;

  const ListDataViewModal({
    super.key,
    required this.scrollController,
    required this.searchController,
    required this.selectDataController,
    required this.loadingDataModalBuilder,
    required this.loadingDataModalSettings,
    required this.searchEmptyInfoModalBuilder,
    required this.searchEmptyInfoModalSettings,
    required this.listDataViewModalBuilder,
    required this.listDataViewModalSettings,
    required this.modalItemBuilder,
    required this.modalItemSettings,
    required this.modalCategoryBuilder,
    required this.modalCategorySettings,
    required this.globalSettings,
  });

  @override
  State<ListDataViewModal<T>> createState() => _ListDataViewModalState<T>();
}

class _ListDataViewModalState<T> extends State<ListDataViewModal<T>> {
  // It's okey.
  // ignore: avoid-late-keyword
  late Stream<List<Widget>> streamController = dataStreamFunc(isInit: true);

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(searchListener);
  }

  @override
  void dispose() {
    widget.searchController.removeListener(searchListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listDataViewModalBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.listDataViewModalBuilder!(
        context,
        ListDataViewModalDetails(
          scrollController: widget.scrollController,
          searchController: widget.searchController,
          selectDataController: widget.selectDataController,
          categoryNameModal: _categoryNameModal,
          categoryItemModal: _categoryItemModal,
          searchEmptyInfoModal: _searchEmptyInfoModal,
          loadingDataModal: _loadingDataModal,
          globalSettings: widget.globalSettings,
        ),
      );
    }

    return StreamBuilder<List<Widget>>(
      stream: streamController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingDataModal(
            loadingDataModalBuilder: widget.loadingDataModalBuilder,
            loadingDataModalSettings: widget.loadingDataModalSettings,
            globalSettings: widget.globalSettings,
          );
        }

        if ((snapshot.data as List).isEmpty) {
          return SearchEmptyInfoModal(
            searchEmptyInfoModalBuilder: widget.searchEmptyInfoModalBuilder,
            searchEmptyInfoModalSettings: widget.searchEmptyInfoModalSettings,
            globalSettings: widget.globalSettings,
          );
        }

        return Container(
          margin: widget.listDataViewModalSettings.margin,
          padding: widget.listDataViewModalSettings.padding,
          child: ListView.builder(
            shrinkWrap: true,
            itemExtent: widget.listDataViewModalSettings.itemExtents,
            controller: widget.scrollController,
            itemBuilder: (context, index) => snapshot.data![index],
            itemCount: snapshot.data!.length,
          ),
        );
      },
    );
  }

  void searchListener() {
    if (mounted) {
      setState(() {
        streamController = dataStreamFunc();
      });
    }
  }

  Stream<List<Widget>> dataStreamFunc({bool isInit = false}) async* {
    var listDataViewChildren = await Future.wait([
      dataFuture(),
      if (!isInit)
        Future.delayed(
          widget.listDataViewModalSettings.minLoadDuration,
        ),
    ]);

    yield listDataViewChildren.first as List<Widget>;
  }

  Future<List<Widget>> dataFuture() async {
    List<Widget> listDataViewChildren = [];

    for (SelectModel<T> item in widget.searchController.getResults) {
      listDataViewChildren.addAll(categoryModal(item));
    }

    return listDataViewChildren;
  }

  List<Widget> categoryModal(SelectModel<T> category, [int deepth = 0]) {
    List<Widget> listDataViewChildren = [];
    if (!category.isCategory) {
      listDataViewChildren.add(
        ModalItemWidget(
          deepth: deepth,
          singleItem: category,
          selectDataController: widget.selectDataController,
          modalItemBuilder: widget.modalItemBuilder,
          modalItemSettings: widget.modalItemSettings,
          globalSettings: widget.globalSettings,
        ),
      );
      return listDataViewChildren;
    }
    listDataViewChildren.add(
      ModalCategoryWidget(
        deepth: deepth,
        singleCategory: category,
        selectDataController: widget.selectDataController,
        modalCategoryBuilder: widget.modalCategoryBuilder,
        modalCategorySettings: widget.modalCategorySettings,
        globalSettings: widget.globalSettings,
      ),
    );
    for (SelectModel<T> item in category.itemList) {
      listDataViewChildren.addAll(categoryModal(item, deepth + 1));
    }

    return listDataViewChildren;
  }

  Widget _categoryNameModal(CategoryModel<T> i) => ModalCategoryWidget<T>(
        singleCategory: i,
        selectDataController: widget.selectDataController,
        modalCategoryBuilder: widget.modalCategoryBuilder,
        modalCategorySettings: widget.modalCategorySettings,
        globalSettings: widget.globalSettings,
      );

  Widget _categoryItemModal(ItemModel<T> i) => ModalItemWidget<T>(
        singleItem: i,
        selectDataController: widget.selectDataController,
        modalItemBuilder: widget.modalItemBuilder,
        modalItemSettings: widget.modalItemSettings,
        globalSettings: widget.globalSettings,
      );

  Widget _searchEmptyInfoModal() => SearchEmptyInfoModal(
        searchEmptyInfoModalBuilder: widget.searchEmptyInfoModalBuilder,
        searchEmptyInfoModalSettings: widget.searchEmptyInfoModalSettings,
        globalSettings: widget.globalSettings,
      );

  Widget _loadingDataModal() => LoadingDataModal(
        loadingDataModalBuilder: widget.loadingDataModalBuilder,
        loadingDataModalSettings: widget.loadingDataModalSettings,
        globalSettings: widget.globalSettings,
      );
}
