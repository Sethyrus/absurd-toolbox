import 'package:flutter/material.dart';

class Raffle extends StatefulWidget {
  Raffle({Key? key}) : super(key: key);

  @override
  _RaffleState createState() => _RaffleState();
}

class _RaffleState extends State<Raffle> {
  List<String> _participants = [];
  List<String> _winners = [];
  String _addParticipantsError = '';
  final _addParticipantsFocusNode = new FocusNode();
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
    if (_addParticipantsError != '')
      setState(() {
        _addParticipantsError = '';
      });

    if (_participants.length == 0) {
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
    if (_winners.length > 0 || _winnersError != '')
      setState(() {
        _winners = [];
        _winnersError = '';
      });
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
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              width: double.infinity,
              child: Text(
                'Sorteo',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
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
                                  color: Colors.green.shade400, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 8,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: ElevatedButton(
                          onPressed: _addParticipant,
                          child: Text('Añadir'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.green.shade400),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ..._addParticipantsError != ''
                      ? [
                          Container(
                            width: double.infinity,
                            child: Text(
                              _addParticipantsError,
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ]
                      : []
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Text(
                'Participantes',
                style: TextStyle(fontSize: 16),
              ),
            ),
            _participants.length == 0
                ? Container(
                    child: Text('No hay participantes'),
                    margin: EdgeInsets.only(bottom: 8),
                  )
                : Container(
                    margin: EdgeInsets.only(bottom: 8),
                    width: double.infinity,
                    child: Wrap(
                      children: List.generate(
                        _participants.length,
                        (index) => Container(
                          margin: EdgeInsets.only(bottom: 6, right: 8),
                          child: InkWell(
                            onTap: () =>
                                setState(() => _participants.removeAt(index)),
                            child: Ink(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border:
                                    Border.all(color: Colors.green.shade400),
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
                    child: Text('Realizar sorteo'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green.shade400),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                  ),
                ),
                ..._winnersError != ''
                    ? [
                        Container(
                          width: double.infinity,
                          child: Text(
                            _winnersError,
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ]
                    : []
              ],
            ),
            ..._winners.length > 0
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
