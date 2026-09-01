import 'package:flutter/material.dart';

void main() {
  runApp(const PapaFilaApp());
}

class PapaFilaApp extends StatelessWidget {
  const PapaFilaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PapaFila',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D5A4C),
          primary: const Color(0xFF2D5A4C), // Verde escuro idêntico ao protótipo
          surface: const Color(0xFFF2F7F5),
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

// ==========================================
// TELA 1: CARDÁPIO E PEDIDO
// ==========================================
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

  double get _valorTotal =>
      _itens.fold(0, (total, item) => total + (item.preco * item.quantidade));

  int get _totalItens =>
      _itens.fold(0, (total, item) => total + item.quantidade);

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Cardápio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
      // Banner Simples
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          // Lista dos Itens do Cardápio
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _itens.length,
              itemBuilder: (context, index) {
                final item = _itens[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // Imagem/Ícone do Produto
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.fastfood, color: themeColor),
                        ),
                        const SizedBox(width: 12),
                        // Nome, Descrição e Preço Visualmente Claro
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: themeColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Seletor de Quantidade
                        Row(
                          children: [
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.remove),
                              onPressed: item.quantidade > 0
                                  ? () => setState(() => item.quantidade--)
                                  : null,
                            ),
                            Text(
                              '${item.quantidade}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  setState(() => item.quantidade++),
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
      // Rodapé Fixo (Zona do Polegar) conforme Wireframe
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Caixinha de Resumo de Valor
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2ECE9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: themeColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Botão Principal de Confirmação
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
                              builder: (context) => PickupScreen(
                                itens: _itens
                                    .where((i) => i.quantidade > 0)
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

// ==========================================
// TELA 2: RETIRADA EXPRESS
// ==========================================
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
    final themeColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: themeColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Retirada Express',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Status de Pedido Pronto
            const Icon(
              Icons.check_circle,
              color: Color(0xFF2D5A4C),
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
              style: TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Bloco do QR Code e Senha
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

            // Card Resumo dos Itens Comprados
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
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${item.quantidade}x ${item.nome}'),
                          Text(
                            'R\$ ${(item.preco * item.quantidade).toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'R\$ ${valorTotal.toStringAsFixed(2)}',
                        style: TextStyle(
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