import 'package:flutter/material.dart';

import 'package:yuppakids/models/models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppakids/blocs/search/blocs.dart';
import 'package:yuppakids/widgets/widgets.dart';
import 'package:flutter/services.dart';

import 'package:yuppakids/size_config.dart';

class SearchField extends StatefulWidget {
  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _textController = TextEditingController();
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    SystemChrome.restoreSystemUIOverlays();
    _focus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.5,
      alignment: Alignment.centerLeft,
      height: 80,
      child: TextField(
        style: TextStyle(fontSize: 20.0, color: Colors.white),
        controller: _textController,
        textInputAction: TextInputAction.search,
        onChanged: (value) => print(value),
        onSubmitted: (value) {
          print(value);
          if (_textController.text.isEmpty) return;
          FocusManager.instance.primaryFocus.unfocus();
          if (_textController.text != null) {
            BlocProvider.of<SearchBloc>(context)
              ..add(SearchRequested(query: _textController.text));
          }
        },
        autofocus: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
            hintText: "Youtube videolarda ara...",
            prefixIcon: Icon(Icons.search, size: 48)),
      ),
    );
  }
}
