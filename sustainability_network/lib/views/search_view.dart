import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/cards/user_card.dart';

class SearchView extends StatefulWidget {
  static const routeName = '/search_view';

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _searchController;
  List<String> matches = [];
  var _loading = false;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void search(String query) async {
    if (_searchController.text.isEmpty) {
      setState(() {
        matches = [];
      });
    } else {
      setState(() {
        _loading = true;
      });
      final matchesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(
            'username',
            isGreaterThanOrEqualTo: query,
            isLessThan: query.substring(0, query.length - 1) +
                String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),
          )
          .get();
      final matchesDocs = matchesSnapshot.docs;
      matches = matchesDocs.map(
        (doc) {
          return doc.id;
        },
      ).toList();
      setState(() {
        _loading = false;
      });
    }
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onChanged: search,
                cursorColor: Theme.of(context).primaryColor,
                cursorHeight: 18,
                decoration: InputDecoration(
                  labelText: 'Search for somebody!',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: buildAppBar(),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return UserCard(
                    matches[index],
                  );
                },
                itemCount: matches.length,
              ),
      ),
    );
  }
}
