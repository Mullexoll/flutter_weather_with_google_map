import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app_flutter/constants/home_screen_consts.dart';

import '../../../bloc/weather_bloc.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _textController = TextEditingController();

  CustomSearchBarState();

  _onSearchBarSubmitted(String value, WeatherBloc weatherBloc) {
    final _ = weatherBloc.add(WeatherPerformSearchEvent(queryString: value));

    setState(() {
      _textController.text = value;
    });
  }

  _onSearchBarChanged(String value) {
    setState(() {
      _textController.text = value;
    });
  }

  clearSearchBar(WeatherBloc weatherBloc) {
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return SearchBar(
      controller: _textController,
      backgroundColor: MaterialStateProperty.all(
        const Color.fromRGBO(242, 242, 242, 1),
      ),
      overlayColor: MaterialStateProperty.all(
        const Color.fromRGBO(229, 237, 255, 1),
      ),
      side: MaterialStateProperty.all(
        _textController.text != ''
            ? const BorderSide(
          color: Colors.white,
        )
            : BorderSide.none,
      ),
      hintText: 'Search',
      hintStyle: MaterialStateProperty.all(
        const TextStyle(
          color: HomeScreenConsts.primaryColor,
        ),
      ),
      onSubmitted: (String value) => _onSearchBarSubmitted(value, weatherBloc),
      onChanged: (String value) => _onSearchBarChanged(value),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SvgPicture.asset(
          'assets/icons/search_icon.svg',
          width: 24,
          height: 24,
          fit: BoxFit.none,

        ),
      ),
      trailing: [
        if (_textController.text != '')
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () => clearSearchBar(weatherBloc),
              child: SvgPicture.asset(
                'assets/icons/close_icon.svg',
                width: 24,
                height: 24,
                fit: BoxFit.none,
              ),
            ),
          )
      ],
    );
  }
}
