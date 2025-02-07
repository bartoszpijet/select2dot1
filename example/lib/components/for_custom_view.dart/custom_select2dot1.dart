import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';

class CustomSelect2dot1<T> extends StatelessWidget {
  final String title;
  final Iterable<ItemInterface<T>> data;
  final bool isMultiSelect;
  final bool avatarInSingleSelect;
  final bool extraInfoInSingleSelect;
  final bool extraInfoInDropdown;
  final ScrollController? scrollController;

  const CustomSelect2dot1({
    super.key,
    required this.title,
    required this.data,
    required this.isMultiSelect,
    required this.avatarInSingleSelect,
    required this.extraInfoInSingleSelect,
    required this.extraInfoInDropdown,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300,
      ),
      child: Select2dot1<T>(
        selectDataController: SelectDataController<T>(
          isMultiSelect: isMultiSelect,
          data: data,
        ),
        selectStyle: SelectStyle(
          pillboxStyle: PillboxStyle(
            pillboxTitleSettings: PillboxTitleSettings(
              title: title,
              titlePadding: EdgeInsets.zero,
              titleStyleDefault: const TextStyle(
                color: Color(0xFF99A5C1),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              titleStyleHover: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              titleStyleFocus: const TextStyle(
                color: Color(0xFF1DEDB2),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            pillboxSettings: const PillboxSettings(
              padding: null,
              defaultDecoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF202E50)),
                ),
              ),
              activeDecoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF1DEDB2)),
                ),
              ),
              hoverDecoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white),
                ),
              ),
              focusDecoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF1DEDB2)),
                ),
              ),
            ),
            pillboxIconSettings: const PillboxIconSettings(
              padding: null,
              defaultColor: Color(0xFF99A5C1),
              hoverColor: Colors.white,
              focusColor: Color(0xFF1DEDB2),
            ),
            pillboxContentMultiSettings: const PillboxContentMultiSettings(
              pillboxLayout: PillboxLayout.scroll,
            ),
          ),
          overlayStyle: OverlayStyle(
            dropdownOverlaySettings: DropdownOverlaySettings(
              maxHeight: 330,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.zero,
                color: Color(0xFF001029),
                border: Border(),
                boxShadow: [],
              ),
              animationBuilder: (context, child, animationController) {
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SizeTransition(
                    sizeFactor: CurvedAnimation(
                      parent: animationController,
                      curve: Curves.easeInOutQuart,
                    ),
                    child: child,
                  ),
                );
              },
            ),
          ),
          modalStyle: ModalStyle(
            dropdownModalSettings: const DropdownModalSettings(
              backgroundColor: Color(0xff001029),
            ),
            titleModalSettings: TitleModalSettings(
              title: title,
              titleTextStyle: const TextStyle(
                color: Color(0xFF1DEDB2),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            doneButtonModalSettings: DoneButtonModalSettings(
              buttonDecoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1DEDB2)),
                color: const Color(0xff001029),
                borderRadius: BorderRadius.circular(24),
              ),
              textStyle: const TextStyle(color: Color(0xFF1DEDB2)),
            ),
          ),
          searchEmptyInfoStyle: const SearchEmptyInfoStyle(
            textStyle: TextStyle(color: Colors.white),
          ),
          itemListStyle: const ItemListStyle(
            thumbColor: Color(0xFF1DEDB2),
          ),
          categoryStyle: CategoryStyle(
            // modalCategorySettings: const ModalCategorySettings(
            //   defaultTextStyle: TextStyle(
            //     color: Color(0xFF6B7893),
            //     fontSize: 18,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            buttonStyle: ButtonStyle(
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.white;
                }
                if (states.contains(WidgetState.hovered)) {
                  return Colors.lime;
                }
                if (states.contains(WidgetState.selected)) {
                  return Colors.green;
                }

                return Colors.white;
              }),
              alignment: Alignment.centerLeft,
            ),
            // constraints: const BoxConstraints(minHeight: 27),
            // defaultTextStyle: const TextStyle(
            //   color: Color(0xFF6B7893),
            //   fontSize: 14,
            //   fontWeight: FontWeight.w500,
            // ),
            // selectedTextStyle: const TextStyle(
            //   color: Color(0xFF1DEDB2),
            //   fontSize: 14,
            //   fontWeight: FontWeight.w500,
            // ),
            // iconSelectedColor: const Color(0xFF1DEDB2),
            // defaultDecoration: const BoxDecoration(color: Colors.transparent),
            // hoverDecoration:
            //     BoxDecoration(color: const Color(0xFF00183D).withOpacity(0.5)),
          ),
          itemStyle: ItemStyle(
            // modalItemSettings: ModalItemSettings(
            //   defaultTextStyle: const TextStyle(
            //     color: Colors.white,
            //     fontSize: 18,
            //     fontWeight: FontWeight.w500,
            //   ),
            //   selectedTextStyle: const TextStyle(
            //     color: Color(0xFF1DEDB2),
            //     fontSize: 18,
            //     fontWeight: FontWeight.w500,
            //   ),
            //   // ignore: avoid_redundant_argument_values
            //   iconSize: 18,
            //   iconSelectedColor: const Color(0xFF1DEDB2),
            //   showExtraInfo: extraInfoInDropdown,
            // ),
            buttonStyle: ButtonStyle(
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.white;
                }
                if (states.contains(WidgetState.hovered)) {
                  return Colors.lime;
                }
                if (states.contains(WidgetState.selected)) {
                  return Colors.green;
                }

                return Colors.white;
              }),
              alignment: Alignment.centerLeft,
            ),
            // constraints: const BoxConstraints(minHeight: 35),
            // defaultTextStyle: const TextStyle(
            //   color: Colors.white,
            //   fontSize: 14,
            //   fontWeight: FontWeight.w500,
            // ),
            // selectedTextStyle: const TextStyle(
            //   color: Color(0xFF1DEDB2),
            //   fontSize: 14,
            //   fontWeight: FontWeight.w500,
            // ),
            // iconSize: 14,
            // iconSelectedColor: const Color(0xFF1DEDB2),
            // defaultDecoration: const BoxDecoration(color: Colors.transparent),
            // hoverDecoration:
            //     BoxDecoration(color: const Color(0xFF00183D).withOpacity(0.5)),
            // showExtraInfo: extraInfoInDropdown,
          ),
          selectOverloadInfoSettings: const SelectOverloadInfoSettings(
            textStyle: TextStyle(color: Colors.white),
            padding: null,
          ),
          selectSingleSettings: SelectSingleSettings(
            padding: null,
            textStyle: const TextStyle(color: Colors.white),
            showExtraInfo: extraInfoInSingleSelect,
            showAvatar: avatarInSingleSelect,
          ),
          selectEmptyInfoSettings: const SelectEmptyInfoSettings(
            padding: EdgeInsets.zero,
            text: 'Select',
            textStyle: TextStyle(
              color: Color(0xFF6B7893),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        overlayData: OverlayData(
          searchBarOverlayBuilder: (context, searchBarOverlayDetails) {
            return Container(
              height: 48,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin:
                  const EdgeInsets.only(top: 9, left: 5, right: 5, bottom: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF00183D),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchBarOverlayDetails.searchBarController,
                      focusNode: searchBarOverlayDetails.searchBarFocusNode,
                      cursorColor: const Color(0xFF1DEDB2),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Color(0xFF202E50)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        modalData: ModalData(
          searchBarModalBuilder: (context, searchBarModalDetails) {
            return Container(
              height: 48,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(top: 9, bottom: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF00183D),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller:
                          searchBarModalDetails.searchBarModalController,
                      focusNode: searchBarModalDetails.searchBarModalFocusNode,
                      cursorColor: const Color(0xFF1DEDB2),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Color(0xFF202E50)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        dropdownButtonData: DropdownButtonData(
          selectChipBuilder: (context, selectChipDetails) {
            return Container(
              height: 29,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              constraints: const BoxConstraints(maxWidth: 200),
              decoration: BoxDecoration(
                color: const Color(0xFF001029),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      selectChipDetails.singleItem.label,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0, left: 2.0),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          selectChipDetails.selectDataController
                              .removeSelectedChip(
                            selectChipDetails.singleItem,
                          );
                        },
                        child: const Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        dropdownListData: DropdownListData(
          scrollController: scrollController,
        ),
      ),
    );
  }
}
