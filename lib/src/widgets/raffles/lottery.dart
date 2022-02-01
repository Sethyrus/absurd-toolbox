import 'package:flutter/material.dart';

class Lottery extends StatefulWidget {
  const Lottery({Key? key}) : super(key: key);

  @override
  _LotteryState createState() => _LotteryState();
}

class _LotteryState extends State<Lottery> {
  final List<String> _participants = [];
  List<String> _winners = [];
  String _addParticipantsError = '';
  final _addParticipantsFocusNode = FocusNode();
  final _addParticipantsController = TextEditingController();
  String _winnersError = '';
  final _winnersCountController = TextEditingController();

  void _addParticipant() {
    _resetWinners();

    if (_addParticipantsController.text == '') {
      setState(() {
        _addParticipantsError = 'Pero pon algo en el cuadrao ._.';
      });
      return;
    }

    if (_participants.contains(_addParticipantsController.text)) {
      setState(() {
        _addParticipantsError = 'Ese ya está en el listado';
      });
      return;
    }

    setState(() {
      _addParticipantsError = '';
      _winnersError = '';

      _participants.add(_addParticipantsController.text);
    });

    _addParticipantsController.text = '';
  }

  void _getWinners() {
    if (_addParticipantsError != '') {
      setState(() {
        _addParticipantsError = '';
      });
    }

    if (_participants.isEmpty) {
      setState(() {
        _winners = [];
        _winnersError = 'Pero añade algún participante';
      });
      return;
    }

    _winners = [..._participants];

    setState(() {
      _winnersError = '';

      _winners.shuffle();
    });
  }

  void _resetWinners() {
    if (_winners.isNotEmpty || _winnersError != '') {
      setState(() {
        _winners = [];
        _winnersError = '';
      });
    }
  }

  @override
  void dispose() {
    _addParticipantsFocusNode.dispose();
    _addParticipantsController.dispose();
    _winnersCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              width: double.infinity,
              child: const Text(
                'Sorteo',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: _addParticipantsFocusNode,
                          onSubmitted: (_) {
                            _addParticipant();
                            _addParticipantsFocusNode.requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {
                            if (_addParticipantsError != '') {
                              setState(() => _addParticipantsError = '');
                            }
                            _resetWinners();
                          },
                          controller: _addParticipantsController,
                          decoration: InputDecoration(
                            hintText: 'Añadir participante',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Colors.green.shade400,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(width: 1),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 8,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: ElevatedButton(
                          onPressed: _addParticipant,
                          child: const Text('Añadir'),
                        ),
                      ),
                    ],
                  ),
                  ..._addParticipantsError != ''
                      ? [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              _addParticipantsError,
                              textAlign: TextAlign.start,
                              style: const TextStyle(color: Colors.red),
                            ),
                          )
                        ]
                      : []
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Participantes',
                style: TextStyle(fontSize: 16),
              ),
            ),
            _participants.isEmpty
                ? Container(
                    child: const Text('No hay participantes'),
                    margin: const EdgeInsets.only(bottom: 8),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: double.infinity,
                    child: Wrap(
                      children: List.generate(
                        _participants.length,
                        (index) => Container(
                          margin: const EdgeInsets.only(bottom: 6, right: 8),
                          child: InkWell(
                            onTap: () => setState(
                              () => _participants.removeAt(index),
                            ),
                            child: Ink(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                                border: Border.all(
                                  color: Colors.green.shade400,
                                ),
                              ),
                              child: Text(_participants[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: _getWinners,
                    child: const Text('Realizar sorteo'),
                  ),
                ),
                ..._winnersError != ''
                    ? [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            _winnersError,
                            textAlign: TextAlign.end,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      ]
                    : []
              ],
            ),
            ..._winners.isNotEmpty
                ? [
                    Text('1º ' + _winners[0]),
                    ..._winners.length > 1
                        ? [
                            Text('2º ' + _winners[1]),
                            ..._winners.length > 2
                                ? [
                                    Text('3º ' + _winners[2]),
                                  ]
                                : [],
                          ]
                        : [],
                  ]
                : []
          ],
        ),
      ),
    );
  }
}
