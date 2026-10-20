import 'package:flutter/material.dart';

void main() {
  runApp(const PapaFilaApp());
}

class PapaFilaApp extends StatelessWidget {
  const PapaFilaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Papa-Fila',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E8C),
        ),
        useMaterial3: true,
      ),
      home: const ConfiguracoesAlertasPage(),
    );
  }
}

class ConfiguracoesAlertasPage extends StatefulWidget {
  const ConfiguracoesAlertasPage({super.key});

  @override
  State<ConfiguracoesAlertasPage> createState() =>
      _ConfiguracoesAlertasPageState();
}

class _ConfiguracoesAlertasPageState
    extends State<ConfiguracoesAlertasPage> {
  bool alertasAtivos = true;
  double volume = 50;
  bool mesaExpressSelecionada = false;

  void redefinirPadroes() {
    setState(() {
      alertasAtivos = true;
      volume = 50;
      mesaExpressSelecionada = false;
    });
  }

  void salvarConfiguracoes() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Configurações salvas'),
          content: Text(
            'Alertas: ${alertasAtivos ? "Ativados" : "Desativados"}\n'
            'Volume: ${volume.round()}%\n'
            'Entrega: ${mesaExpressSelecionada ? "Mesa Express" : "Entrega padrão"}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurações',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE91E8C),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Saída da tela simulada.'),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alertas e Entrega',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Personalize suas preferências no Papa-Fila.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),

              Card(
                child: SwitchListTile(
                  title: const Text(
                    'Alerta de lanche pronto',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    alertasAtivos
                        ? 'Você receberá alertas.'
                        : 'Os alertas estão desativados.',
                  ),
                  value: alertasAtivos,
                  activeThumbColor: const Color(0xFFE91E8C),
                  onChanged: (valor) {
                    setState(() {
                      alertasAtivos = valor;
                    });
                  },
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Volume do alerta',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('0%'),
                  Text(
                    '${volume.round()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE91E8C),
                    ),
                  ),
                  const Text('100%'),
                ],
              ),

              Slider(
                value: volume,
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: const Color(0xFFE91E8C),
                label: '${volume.round()}%',
                onChanged: alertasAtivos
                    ? (valor) {
                        setState(() {
                          volume = valor;
                        });
                      }
                    : null,
              ),

              if (!alertasAtivos)
                const Text(
                  'Ative os alertas para ajustar o volume.',
                  style: TextStyle(color: Colors.grey),
                ),

              const SizedBox(height: 32),

              const Text(
                'Forma de entrega',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              GestureDetector(
                onTap: () {
                  setState(() {
                    mesaExpressSelecionada =
                        !mesaExpressSelecionada;
                  });

                  if (mesaExpressSelecionada) {
                    print('Mesa Selecionada para Entrega!');
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: mesaExpressSelecionada
                        ? const Color(0xFFE91E8C).withValues(alpha: 0.12)
                        : Colors.grey.shade100,
                    border: Border.all(
                      color: mesaExpressSelecionada
                          ? const Color(0xFFE91E8C)
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.table_restaurant,
                        size: 32,
                        color: mesaExpressSelecionada
                            ? const Color(0xFFE91E8C)
                            : Colors.grey.shade700,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mesa Express',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Receba seu pedido na mesa.',
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        mesaExpressSelecionada
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: mesaExpressSelecionada
                            ? const Color(0xFFE91E8C)
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Center(
                child: TextButton(
                  onPressed: redefinirPadroes,
                  child: const Text(
                    'Redefinir Padrões',
                    style: TextStyle(
                      color: Color(0xFFE91E8C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: salvarConfiguracoes,
        backgroundColor: const Color(0xFFE91E8C),
        foregroundColor: Colors.white,
        tooltip: 'Salvar configurações',
        child: const Icon(Icons.save),
      ),
    );
  }
}