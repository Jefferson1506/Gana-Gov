// ignore_for_file: unused_field

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/global/widgets/text_span.dart';
import 'package:ganagov/module/seller/model_seller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:video_player/video_player.dart';

class DetailViewPage extends StatelessWidget {
  final Sale sale;

  const DetailViewPage({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        centerTitle: true,
        title: CustomTextSpan(
          primary: const Color.fromARGB(255, 54, 54, 54),
          secondary: colorScheme.primary,
          textPrimary: "Detalle de Venta     Gana",
          textSecondary: "Gov",
          sizePrimary: 23,
          sizeSecondary: 23,
        ),
        shape: const UnderlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 17, 163, 3), width: 5),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 244, 244, 244),
                Color.fromARGB(255, 255, 254, 190),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SaleCard(
                sale: sale,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _openWhatsApp(sale.telefono),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('WhatsApp'),
                  ),
                  ElevatedButton(
                    onPressed: () => _callNumber(sale.telefono),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Llamar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _openWhatsApp(tel) async {
  String _url = 'https://wa.me/$tel';
  bool whatsappInstalled = await _isWhatsappInstalled();

  if (whatsappInstalled) {
    bool launched = await launch(_url, forceSafariVC: false);
    if (!launched) {}
  } else {
    bool launched = await launch(_url);
    if (!launched) {}
  }
}

Future<bool> _isWhatsappInstalled() async {
  bool isInstalled = await canLaunch('whatsapp://');
  return isInstalled;
}

_callNumber(tel) async {
  await FlutterPhoneDirectCaller.callNumber(tel);
}

class SaleCard extends StatelessWidget {
  final Sale sale;

  const SaleCard({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailViewPage(sale: sale),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageGallery(),
              const SizedBox(height: 10),
              _buildTitle(),
              const SizedBox(height: 5),
              _buildDetails(),
              const SizedBox(height: 5),
              _buildIcons(),
              const SizedBox(height: 5),
              _buildNegotiableInfo(),
              const SizedBox(height: 5),
              Center(
                child: buildTextIconRow(
                  icon: Icons.price_change,
                  text: sale.precio,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              _buildDescription(),
              const SizedBox(height: 20),
              if (sale.videoUrl != null && sale.videoUrl.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: VideoPlayerWidget(videoUrl: sale.videoUrl),
                  ),
                )
              else
                const Text('No hay video disponible',
                    style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return sale.fotos.isNotEmpty
        ? SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sale.fotos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      sale.fotos[index],
                      fit: BoxFit.cover,
                      height: 250,
                      width: 250,
                    ),
                  ),
                );
              },
            ),
          )
        : Container();
  }

  Widget _buildTitle() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTextIconRow(
            icon: Icons.pets,
            text: sale.raza,
            color: Colors.black87,
          ),
          buildTextIconRow(
            icon: Icons.location_on,
            text: sale.departamento,
            color: Colors.grey,
          ),
          buildTextIconRow(
            icon: Icons.location_city,
            text: sale.municipio,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTextIconRow(
          icon: Icons.confirmation_number_outlined,
          text: 'Cantidad: ${sale.cantidad}',
          color: Colors.grey,
        ),
        buildTextIconRow(
          icon: Icons.monitor_weight_outlined,
          text: '${sale.peso} kg',
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTextIconRow(
          icon: Icons.sell,
          text: 'Venta: ${sale.tipoVenta}',
          color: Colors.grey,
        ),
        buildTextIconRow(
          icon: Icons.calendar_today,
          text: 'Meses: ${sale.edad}',
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildNegotiableInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTextIconRow(
          text: sale.estado,
          color: sale.estado == 'En Venta'
              ? Colors.orange
              : sale.estado == 'Cancelado'
                  ? Colors.red
                  : Colors.green,
        ),
        buildTextIconRow(
          icon: Icons.handshake_outlined,
          text: sale.negociable ? 'Si Negociable' : 'No Negociable',
          color: sale.negociable ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descripción',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.green.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            sale.descripcion,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildTextIconRow(
    {required String text, IconData? icon, required Color color}) {
  return TextButton.icon(
    onPressed: () {},
    icon: icon != null
        ? Icon(icon, color: Colors.black, size: 16)
        : const SizedBox(),
    label: AutoSizeText(
      text,
      style: TextStyle(
        fontSize: 15,
        color: color,
      ),
    ),
  );
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      }).catchError((error) {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(_controller),
                    _ControlsOverlay(controller: _controller),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
        IconButton(
          icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
        ),
      ],
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;

  const _ControlsOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              controller.value.volume > 0 ? Icons.volume_up : Icons.volume_off,
              color: Colors.white,
            ),
            onPressed: () {
              controller.setVolume(controller.value.volume > 0 ? 0.0 : 1.0);
            },
          ),
        ),
      ],
    );
  }
}
