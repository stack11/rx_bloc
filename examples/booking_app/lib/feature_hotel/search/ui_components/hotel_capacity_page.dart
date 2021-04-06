import 'package:booking_app/feature_hotel/search/ui_components/filter_value_chooser.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HotelCapacityPage extends StatefulWidget {
  HotelCapacityPage({
    required this.onApplyPressed,
    this.roomCapacity,
    this.personCapacity,
  });

  final void Function(int, int) onApplyPressed;
  final int? roomCapacity;
  final int? personCapacity;

  @override
  _HotelCapacityPageState createState() => _HotelCapacityPageState();
}

class _HotelCapacityPageState extends State<HotelCapacityPage> {
  late int roomCapacity;
  late int personCapacity;

  @override
  void initState() {
    super.initState();

    roomCapacity = widget.roomCapacity ?? 0;
    personCapacity = widget.personCapacity ?? 0;
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ItemValueChooser(
            title: 'Room capacity',
            initialValue: roomCapacity,
            onValueChanged: (val) {
              roomCapacity = val;
            },
          ),
          const SizedBox(height: 26),
          ItemValueChooser(
            title: 'Person count',
            initialValue: personCapacity,
            onValueChanged: (val) {
              personCapacity = val;
            },
          ),
          const SizedBox(height: 16),
          DialogButton(
            onPressed: () {
              widget.onApplyPressed(roomCapacity, personCapacity);
            },
            child: const Text(
              'Apply',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      );
}