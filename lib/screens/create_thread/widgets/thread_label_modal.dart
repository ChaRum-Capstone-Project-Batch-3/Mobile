import 'package:flutter/material.dart';

class TopicBottomModal extends StatefulWidget {
  const TopicBottomModal({super.key});

  @override
  State<TopicBottomModal> createState() => _TopicBottomModal();
}

class _TopicBottomModal extends State<TopicBottomModal> {
  bool _hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
          ),
          SizedBox(height: 16,),
          Text(
            'Choose topic',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16,),
          Row(
            children: [
              ChipButton('Business'),
              ChipButton('Technology'),
              ChipButton('Games'),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              ChipButton('Education'),
              ChipButton('Movie'),
              ChipButton('Travel'),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              ChipButton('Music'),
              ChipButton('Horror'),
              ChipButton('Fashion'),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              ChipButton('Animal'),
              ChipButton('Art'),
              ChipButton('Food'),
            ],
          ),
          SizedBox(height: 64,),
          
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0XFF178066),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row ChipButton(name) {
    return Row(
      children: [
        ElevatedButton(
          child: Text(
            '$name',
            style: TextStyle(
              color: _hasBeenPressed ? Colors.white : Colors.grey,
            ),
          ),
          style: ElevatedButton.styleFrom(
            side: BorderSide(
              color: _hasBeenPressed ? Color(0XFF178066) : Colors.grey,
              width: 1,
            ),
            backgroundColor: _hasBeenPressed ? Color(0XFF178066) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () => {
            setState(() {
              _hasBeenPressed = !_hasBeenPressed;
            })
          },
        ),
        SizedBox(width: 8,),
      ],
    );
  }
}