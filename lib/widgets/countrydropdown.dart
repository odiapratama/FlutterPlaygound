import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef bool ItemFilter(Country country);
typedef Widget ItemBuilder(Country country);

class CountryDropDown extends StatefulWidget {
  final ItemFilter itemFilter;
  final ItemBuilder itemBuilder;
  final String initialValue;
  final ValueChanged<Country> onValuePicked;

  CountryDropDown(
      {this.itemFilter,
      this.itemBuilder,
      this.initialValue,
      this.onValuePicked});

  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  List<Country> _countries;
  Country _selectedCountry;
  bool acceptAllCountries(_) => true;

  @override
  void initState() {
    _countries =
        countryList.where(widget.itemFilter ?? acceptAllCountries).toList();
    if (widget.initialValue != null) {
      try {
        _selectedCountry = _countries.firstWhere(
            (country) => country.isoCode == widget.initialValue.toUpperCase());
      } catch (error) {
        throw Exception("Country not found!");
      }
    } else {
      _selectedCountry = _countries.first;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> items = _countries
        .map((country) => DropdownMenuItem<Country>(
            value: country,
            child: widget.itemBuilder != null
                ? widget.itemBuilder(country)
                : _buildDefaultMenuItem(country)))
        .toList();

    return Row(
      children: <Widget>[
        DropdownButtonHideUnderline(
            child: DropdownButton<Country>(
          isDense: true,
          icon: Icon(
            FontAwesomeIcons.chevronDown,
            size: 18,
          ),
          onChanged: (value) {
            setState(() {
              _selectedCountry = value;
              widget.onValuePicked(value);
            });
          },
          items: items,
          value: _selectedCountry,
        ))
      ],
    );
  }

  Widget _buildDefaultMenuItem(Country country) {
    return Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(
          width: 8,
        ),
        Text("(${country.isoCode}) +(${country.phoneCode})")
      ],
    );
  }
}
