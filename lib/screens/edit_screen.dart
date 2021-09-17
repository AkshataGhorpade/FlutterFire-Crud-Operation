import 'package:flutter/material.dart';
import 'package:webproject/res/custom_colors.dart';
import 'package:webproject/utils/database.dart';
import 'package:webproject/widgets/app_bar_title.dart';
import 'package:webproject/widgets/edit_item_form.dart';


class EditScreen extends StatefulWidget {
  final String currentTitle;
  final String currentProductname;
  final String currentProductprice;
  final String currentSubcategory;
  final String documentId;

  EditScreen({
     this.currentTitle,
     this.documentId,
    this.currentSubcategory,
    this.currentProductprice,
    this.currentProductname,
  });

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _productnameFocusNode = FocusNode();
  final FocusNode _productpriceFocusNode = FocusNode();
  final FocusNode _subcategoryFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _productnameFocusNode.unfocus();
        _productpriceFocusNode.unfocus();
        _subcategoryFocusNode.unfocus();


      },
      child: Scaffold(
        backgroundColor: CustomColors.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.firebaseNavy,
          title: AppBarTitle(),
          actions: [
            _isDeleting
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });

                      await Database.deleteItem(
                        docId: widget.documentId,
                      );

                      setState(() {
                        _isDeleting = false;
                      });

                      Navigator.of(context).pop();
                    },
                  ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditItemForm(
              documentId: widget.documentId,
              titleFocusNode: _titleFocusNode,
              productnameFocusNode: _productnameFocusNode,
              productpriceFocusNode: _productpriceFocusNode,
              subcategoryFocusNode: _subcategoryFocusNode,
              currentTitle: widget.currentTitle,
              currentProductname: widget.currentProductname,
              currentProductprice: widget.currentProductprice,
              currentSubcategory: widget.currentSubcategory,
            ),
          ),
        ),
      ),
    );
  }
}
