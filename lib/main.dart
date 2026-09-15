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
          seedColor: const Color(0xFF2D5A4C),
        ),
        useMaterial3: true,
      ),
      home: const MenuScreen(),
    );
  }
}

class ItemCardapio {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  int quantidade;

  ItemCardapio({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    this.quantidade = 0,
  });
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<ItemCardapio> _itens = [
    ItemCardapio(
      id: '1',
      nome: 'Misto Quente',
      descricao: 'Pão de forma, queijo e presunto',
      preco: 8.50,
    ),
    ItemCardapio(
      id: '2',
      nome: 'Sanduíche Natural',
      descricao: 'Pão integral, frango e salada',
      preco: 10.00,
    ),
    ItemCardapio(
      id: '3',
      nome: 'Suco de Laranja',
      descricao: 'Copo de 400ml natural',
      preco: 6.00,
    ),
    ItemCardapio(
      id: '4',
      nome: 'Bolo de Chocolate',
      descricao: 'Fatia individual',
      preco: 7.00,
    ),
  ];

  double get _valorTotal => _itens.fold(
        0,
        (total, item) => total + item.preco * item.quantidade,
      );

  int get _totalItens => _itens.fold(
        0,
        (total, item) => total + item.quantidade,
      );

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF2D5A4C);

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: themeColor,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Cardápio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            tooltip: 'Preferências',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PreferencesScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            color: const Color(0xFFE2ECE9),
            child: const Text(
              'O que você vai pedir hoje?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF1E3A32),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _itens.length,
              itemBuilder: (context, index) {
                final item = _itens[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.fastfood,
                            color: themeColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.nome,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                item.descricao,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'R\$ ${item.preco.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: themeColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.remove),
                              onPressed: item.quantidade > 0
                                  ? () {
                                      setState(() {
                                        item.quantidade--;
                                      });
                                    }
                                  : null,
                            ),
                            Text(
                              '${item.quantidade}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  item.quantidade++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2ECE9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL ($_totalItens itens):',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A32),
                      ),
                    ),
                    Text(
                      'R\$ ${_valorTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: themeColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _totalItens > 0
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PickupScreen(
                                itens: _itens
                                    .where(
                                      (item) => item.quantidade > 0,
                                    )
                                    .toList(),
                                valorTotal: _valorTotal,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text(
                    'CONFIRMAR COMPRA',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PickupScreen extends StatelessWidget {
  final List<ItemCardapio> itens;
  final double valorTotal;

  const PickupScreen({
    super.key,
    required this.itens,
    required this.valorTotal,
  });

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF2D5A4C);

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Retirada Express',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle,
              color: themeColor,
              size: 48,
            ),
            const SizedBox(height: 8),
            const Text(
              'SEU PEDIDO ESTÁ PRONTO!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1E3A32),
              ),
            ),
            const Text(
              'Apresente a imagem abaixo no balcão para retirar.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    color: Colors.black,
                    child: Center(
                      child: Container(
                        width: 160,
                        height: 160,
                        color: Colors.white,
                        child: const Icon(
                          Icons.qr_code_2,
                          size: 150,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Senha: #042',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE2ECE9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumo do Pedido',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A32),
                    ),
                  ),
                  const Divider(),
                  ...itens.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${item.quantidade}x ${item.nome}',
                          ),
                          Text(
                            'R\$ ${(item.preco * item.quantidade).toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'R\$ ${valorTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() =>
      _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool notificacoesAtivas = true;
  double volumeAlertas = 0.7;
  String? mesaSelecionada;

  void selecionarMesa() {
    print('Mesa Selecionada para Entrega!');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecionar Mesa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _opcaoMesa('Mesa 1'),
              _opcaoMesa('Mesa 2'),
              _opcaoMesa('Mesa 3'),
              _opcaoMesa('Mesa 4'),
              _opcaoMesa('Mesa 5'),
            ],
          ),
        );
      },
    );
  }

  Widget _opcaoMesa(String mesa) {
    return ListTile(
      leading: const Icon(
        Icons.table_restaurant,
        color: Color(0xFF2D5A4C),
      ),
      title: Text(mesa),
      trailing: mesaSelecionada == mesa
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : null,
      onTap: () {
        setState(() {
          mesaSelecionada = mesa;
        });

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$mesa selecionada para entrega!'),
            backgroundColor: const Color(0xFF2D5A4C),
          ),
        );
      },
    );
  }

  void redefinirPadroes() {
    setState(() {
      notificacoesAtivas = true;
      volumeAlertas = 0.7;
      mesaSelecionada = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preferências redefinidas!'),
      ),
    );
  }

  void salvarPreferencias() {
    print('Preferências salvas!');
    print('Notificações: $notificacoesAtivas');
    print('Volume: $volumeAlertas');
    print('Mesa: ${mesaSelecionada ?? "Nenhuma"}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Preferências salvas com sucesso!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF2D5A4C);

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar ao cardápio',
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Preferências do Usuário',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personalizando a Experiência',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A32),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Configure como deseja receber os alertas '
                'e utilizar o Papa-Fila.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: themeColor,
                          size: 27,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Alertas e Notificações',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A32),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Notificações de Pedido Pronto',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        notificacoesAtivas
                            ? 'Notificações ativadas'
                            : 'Notificações desativadas',
                      ),
                      value: notificacoesAtivas,
                      activeColor: themeColor,
                      onChanged: (valor) {
                        setState(() {
                          notificacoesAtivas = valor;
                        });
                      },
                    ),
                    const Divider(height: 25),
                    const Text(
                      'Volume dos Alertas Sonoros',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.volume_mute,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Slider(
                            value: volumeAlertas,
                            min: 0.0,
                            max: 1.0,
                            divisions: 10,
                            activeColor: themeColor,
                            inactiveColor:
                                Color(0xFFD5E4DF),
                            label:
                                '${(volumeAlertas * 100).round()}%',
                            onChanged: (valor) {
                              setState(() {
                                volumeAlertas = valor;
                              });
                            },
                          ),
                        ),
                        const Icon(
                          Icons.volume_up,
                          color: themeColor,
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        'Volume: '
                        '${(volumeAlertas * 100).round()}%',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.table_restaurant,
                          color: themeColor,
                          size: 27,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Mesa / Área de Consumo',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A32),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      mesaSelecionada == null
                          ? 'Nenhuma mesa selecionada.'
                          : 'Mesa selecionada: $mesaSelecionada',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: selecionarMesa,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.blue.withOpacity(0.30),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.table_restaurant,
                                color: Colors.white,
                                size: 55,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Selecionar Mesa',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              TextButton.icon(
                onPressed: redefinirPadroes,
                icon: const Icon(
                  Icons.restore,
                  color: Colors.red,
                ),
                label: const Text(
                  'Redefinir Padrões',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: salvarPreferencias,
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        tooltip: 'Salvar preferências',
        child: const Icon(Icons.check),
      ),
    );
  }
}