import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ViewModeSection extends StatelessWidget {
  const ViewModeSection(
      {Key? key,
      this.handleViewMode,
      this.showAsList,
      this.handleSortOption,
      this.sortOption})
      : super(key: key);

  final void Function()? handleViewMode;

  final bool? showAsList;

  final void Function(int)? handleSortOption;

  final int? sortOption;

  final sortOptions = const [
    'Recently played',
    'Recently added',
    'Alphabetical'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Row(
            children: [
              const Icon(Icons.arrow_downward, size: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  sortOptions[sortOption!],
                  style: const TextStyle(fontSize: 13),
                ),
              )
            ],
          ),
          onTap: () async {
            final opt = await showCupertinoModalBottomSheet(
              context: context,
              builder: (context) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: Scaffold(
                    backgroundColor: const Color(0xff282828),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 25,
                            bottom: 10,
                          ),
                          child: Text(
                            'Sort by',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        Column(
                          children: sortOptions.map((opt) {
                            final index = sortOptions.indexOf(opt);

                            final active = index == sortOption;

                            return GestureDetector(
                              child: ListTile(
                                title: Text(
                                  opt,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: active
                                        ? const Color(0xff57b760)
                                        : Colors.white,
                                  ),
                                ),
                                trailing: active
                                    ? const Icon(
                                        Icons.check,
                                        color: Color(0xff57b760),
                                      )
                                    : null,
                                dense: true,
                                visualDensity: VisualDensity.compact,
                              ),
                              onTap: () {
                                Navigator.pop(context, index);
                              },
                            );
                          }).toList(),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white60,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              duration: const Duration(milliseconds: 250),
            );

            if (opt != null) handleSortOption!(opt);
          },
        ),
        GestureDetector(
          child: Icon(
            showAsList! ? Icons.dashboard_outlined : Icons.format_list_bulleted,
            size: 18,
          ),
          onTap: handleViewMode,
        )
      ],
    );
  }
}
