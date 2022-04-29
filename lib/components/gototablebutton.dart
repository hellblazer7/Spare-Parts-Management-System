import 'package:flutter/material.dart';

class GoToTableButton extends StatelessWidget {
  final String tableImage;
  final String tableName;
  final void Function()? onPressed;
  final Color theme;
  const GoToTableButton({
    required this.theme,
    required this.tableImage,
    required this.tableName,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Colors.black,
                  width: 3.0,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageIcon(
                  AssetImage(tableImage),
                  size: 50.0,
                  color: theme,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Center(
                    child: Text(
                      tableName,
                      style: TextStyle(
                        fontSize: 30.0,
                        color: theme,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
