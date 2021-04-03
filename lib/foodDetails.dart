import 'package:approved_foods/foodDetailsBO.dart';
import 'package:approved_foods/foodDetailsBloc.dart';
import 'package:flutter/material.dart';

class FoodDetails extends StatefulWidget {
  FoodDetailsBloc foodDetailsBloc;
  FoodDetails(this.foodDetailsBloc);

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 19.0),
      child: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            //-------Cross button-----
            Container(
                alignment: Alignment.centerLeft,
                child: IconButton(icon: Icon(Icons.clear), onPressed: () {
                  Navigator.pop(context,);
                })),
            //-----------Heading-----------
            Container(
              alignment: Alignment.centerLeft,
              child:Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Text("Approved food List",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
              )
            ),
            //-------Search bar-------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(5.0),
                        bottomRight: const Radius.circular(5.0),
                        bottomLeft: const Radius.circular(5.0))),
                child: TextFormField(
                  cursorColor: Colors.black,
                  // controller: searchController,
                  decoration: new InputDecoration(
                    prefixIcon: new Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: 'Search by name',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (text) {
                    //itemsDetailsBloc.fnGetItemsList(1, searchController.text.toString());
                  },
                ),
              ),
            ),
            //----------listview-----------
            Container(
              child: StreamBuilder<List<FoodDetailsBO>>(
                  stream: this.widget.foodDetailsBloc.foodStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          // scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              categoryExpandableWidget(
                                  snapshot,
                                  index,
                                  snapshot
                                      .data[0].categoryResponse[index].category),
                          itemCount: snapshot.data[0].categoryResponse.length,
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
//--------------------category expandable widget------------------------
  categoryExpandableWidget(AsyncSnapshot<List<FoodDetailsBO>> snapshot, int index,
      Category category) {
    return Card(
        child: ExpansionTile(
      key: PageStorageKey<Category>(
          snapshot.data[0].categoryResponse[index].category),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: HexColor(snapshot
                    .data[0].categoryResponse[index].category.strColors),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(5.0),
                    bottomRight: const Radius.circular(5.0),
                    bottomLeft: const Radius.circular(5.0))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
                snapshot.data[0].categoryResponse[index].category.categoryName,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: HexColor(snapshot
                        .data[0].categoryResponse[index].category.strColors))),
          ),
        ],
      ),
      children: snapshot.data[0].categoryResponse[index].category.subCategory
          .map<Widget>((subCategory) => showSubCategory(subCategory,snapshot,index))
          .toList(),
    ));
  }

//--------------show subCategory--------------------------
  showSubCategory(SubCategory subCategory, AsyncSnapshot<List<FoodDetailsBO>> snapshot, int index) {
    if (subCategory.subCategoryName.isEmpty)
      subCategory.items.map<Widget>((items) => showItems(items)).toList();
    return new ExpansionTile(
      key: PageStorageKey<SubCategory>(subCategory),
      title: Text(
        subCategory.subCategoryName,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: HexColor(snapshot
                .data[0].categoryResponse[index].category.strColors)),
      ),
      children:
          subCategory.items.map<Widget>((items) => showItems(items)).toList(),
    );
  }

//----------show items----------------
  showItems(items) {
    return Column(
      children: [
        new ListTile(
          title: new Text(
            items,
            style: new TextStyle(fontSize: 15),
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}

//-------------class to change color format-------------
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
