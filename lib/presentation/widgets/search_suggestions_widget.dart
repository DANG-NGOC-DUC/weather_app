import 'package:flutter/material.dart';

class SearchSuggestionsWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onCitySelected;
  final Future<List<String>> Function(String) getSuggestions;

  const SearchSuggestionsWidget({
    super.key,
    required this.controller,
    required this.onCitySelected,
    required this.getSuggestions,
  });

  @override
  State<SearchSuggestionsWidget> createState() => _SearchSuggestionsWidgetState();
}

class _SearchSuggestionsWidgetState extends State<SearchSuggestionsWidget> {
  List<String> _suggestions = [];
  bool _isLoading = false;
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.controller.text.isNotEmpty) {
      _loadSuggestions(widget.controller.text);
    } else {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
    }
  }

  Future<void> _loadSuggestions(String query) async {
    if (query.length < 2) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final suggestions = await widget.getSuggestions(query);
      setState(() {
        _suggestions = suggestions;
        _showSuggestions = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
        _isLoading = false;
      });
    }
  }

  void _selectCity(String city) {
    widget.controller.text = city;
    widget.onCitySelected(city);
    setState(() {
      _showSuggestions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm thành phố...',
              hintStyle: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[500],
              ),
              prefixIcon: Icon(
                Icons.search,
                color: isDark ? Colors.grey[400] : Colors.grey[500],
              ),
              suffixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: isDark ? Colors.grey[400] : Colors.grey[500],
                      ),
                      onPressed: () {
                        widget.controller.clear();
                        setState(() {
                          _showSuggestions = false;
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: isDark 
                  ? const Color(0xFF1E293B)
                  : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: const Color(0xFF6366F1),
                  width: 2,
                ),
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                widget.onCitySelected(value);
                setState(() {
                  _showSuggestions = false;
                });
              }
            },
            onTap: () {
              if (widget.controller.text.isNotEmpty) {
                _loadSuggestions(widget.controller.text);
              }
            },
          ),
        ),
        
        // Suggestions List
        if (_showSuggestions && _suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                      strokeWidth: 2,
                    ),
                  )
                else
                  ..._suggestions.map((city) => ListTile(
                    leading: Icon(
                      Icons.location_city,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      size: 20,
                    ),
                    title: Text(
                      city,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () => _selectCity(city),
                    hoverColor: isDark 
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                  )),
              ],
            ),
          ),
      ],
    );
  }
}
