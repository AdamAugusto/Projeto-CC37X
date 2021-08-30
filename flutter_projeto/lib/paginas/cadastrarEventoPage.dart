import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projeto/blocs/application_bloc.dart';
import 'package:flutter_projeto/modelos/evento.dart';
import 'package:flutter_projeto/modelos/place.dart';
import 'package:flutter_projeto/repositotio/eventosGerais.dart';
import 'package:flutter_projeto/services/auth_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CadastrarEventoPage extends StatefulWidget {
  final EventosGerais evento;

  CadastrarEventoPage({
    Key? key,
    required this.evento,
  }) : super(key: key);

  @override
  _CadastrarEventoPageState createState() => _CadastrarEventoPageState();
}

class _CadastrarEventoPageState extends State<CadastrarEventoPage> {
  Set<Marker> markers = Set<Marker>();
  final _nomeEvento = TextEditingController();
  final _localEvento = TextEditingController();
  final _data = TextEditingController();
  final _ingresso = TextEditingController();
  final _preco = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;
  XFile? imagem;

  late ApplicationBloc applicationBloc;
  String? placeId;

  Future<void> _goToPlace(Place place) async {
    markers.clear();
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        place.geometry.location.lat,
        place.geometry.location.lng,
      ),
      zoom: 14,
    )));
    markers.add(Marker(
        markerId: MarkerId(place.name),
        position:
            LatLng(place.geometry.location.lat, place.geometry.location.lng)));
  }

  selecionarImagem() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) setState(() => imagem = file);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.searchResults = null;
    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      _goToPlace(place);
    });

    super.initState();
  }

  @override
  void dispose() {
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Cadastrar Evento',
          style: TextStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeEvento,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) return 'Informe o nome do Evento';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                ListTile(
                  leading: Icon(Icons.attach_file),
                  title: Text('Selecione uma Imagem'),
                  onTap: selecionarImagem,
                  trailing:
                      imagem != null ? Image.file(File(imagem!.path)) : null,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _localEvento,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Local',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        _localEvento.clear();
                        applicationBloc.searchResults = null;
                      },
                    ),
                  ),
                  onChanged: (value) => applicationBloc.searchPlaces(value),
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe o local do Evento';
                  },
                ),
                (applicationBloc.currentLocation == null)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            height: 300.0,
                            child: GoogleMap(
                              mapType: MapType.normal,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      applicationBloc.currentLocation!.latitude,
                                      applicationBloc
                                          .currentLocation!.longitude),
                                  zoom: 14),
                              onMapCreated: (GoogleMapController controller) {
                                _mapController.complete(controller);
                              },
                              markers: markers,
                            ),
                          ),
                          if (applicationBloc.searchResults != null &&
                              applicationBloc.searchResults!.length != 0)
                            Container(
                              height: 300.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.6),
                                backgroundBlendMode: BlendMode.darken,
                              ),
                            ),
                          if (applicationBloc.searchResults != null)
                            Container(
                                height: 300.0,
                                child: ListView.builder(
                                    itemCount:
                                        applicationBloc.searchResults!.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          applicationBloc.searchResults![index]
                                              .description!,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onTap: () {
                                          placeId = applicationBloc
                                              .searchResults![index].placeId;
                                          _localEvento.text = applicationBloc
                                              .searchResults![index]
                                              .description!;
                                          applicationBloc.setSelectedLocation(
                                              applicationBloc
                                                  .searchResults![index]
                                                  .placeId!);
                                        },
                                      );
                                    }))
                        ],
                      ),
                TextFormField(
                  controller: _data,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data',
                      hintText: 'dd/mm/aaaa'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe a data do Evento';
                    if (!RegExp(r'^(\d{1,2})\/(\d{1,2})\/(\d{4})')
                        .hasMatch(value))
                      return 'Data deve ser no formato: dd/mm/aaaa';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _ingresso,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantidade de Ingressos',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                  ],
                  validator: (value) {
                    if (value!.isEmpty)
                      return 'Informe a quantidade de ingressos do Evento';
                    if (!(int.parse(value) > 0)) {
                      return 'Informe uma quantidade válida de ingressos ';
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _preco,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Preço do Ingresso',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty)
                      return 'Informe o preço dos ingressos do Evento';
                  },
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        AuthService auth = context.read<AuthService>();
                        if (placeId != null) {
                          if (imagem != null) {
                            widget.evento.adicionar(
                              Evento(
                                  placeId: placeId!,
                                  nome: _nomeEvento.text,
                                  data: _data.text,
                                  local: _localEvento.text,
                                  ingressos: int.parse(_ingresso.text),
                                  ingressosIniciais: int.parse(_ingresso.text),
                                  preco: double.parse(_preco.text),
                                  criador: auth.usuario!.email!,
                                  imagem: imagem!.path),
                            );
                          } else {
                            widget.evento.adicionar(
                              Evento(
                                placeId: placeId!,
                                nome: _nomeEvento.text,
                                data: _data.text,
                                local: _localEvento.text,
                                ingressos: int.parse(_ingresso.text),
                                ingressosIniciais: int.parse(_ingresso.text),
                                preco: double.parse(_preco.text),
                                criador: auth.usuario!.email!,
                              ),
                            );
                          }

                          await locationSubscription.cancel();
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Salvar',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
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
