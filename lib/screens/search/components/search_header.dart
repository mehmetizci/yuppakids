import 'package:flutter/material.dart';

import 'package:yuppakids/size_config.dart';
import 'package:yuppakids/screens/search/components/search_field.dart';
import 'package:yuppakids/screens/search/components/icon_button.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconBtn(),
          SearchField(),
        ],
      ),
    );
  }
}
