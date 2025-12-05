# 🚛 Ocorrência de Transporte

Aplicativo Flutter para registro de ocorrências de transporte com sincronização offline.

## 📋 Descrição

Este projeto implementa um sistema completo de registro de ocorrências de transporte, permitindo que os usuários registrem ocorrências mesmo sem conexão com a internet. As ocorrências são salvas localmente e sincronizadas automaticamente quando a conexão estiver disponível.

## 🏗️ Arquitetura

O projeto segue os princípios de **Clean Architecture** com separação clara de responsabilidades:

- **Camada de Apresentação**: Páginas e componentes UI
- **Camada de Negócio**: Stores (MobX) e ViewModels
- **Camada de Dados**: Repositórios, Clientes e Database

### Padrões Utilizados

- **MVVM** (Model-View-ViewModel) com MobX
- **Repository Pattern** para acesso a dados
- **Dependency Injection** via Flutter Modular
- **Clean Architecture** com separação em camadas

### Trade-offs Arquiteturais

**Por que MVVM com MobX?**
- **vs Provider**: MobX oferece reatividade automática com menos boilerplate e melhor performance
- **vs Bloc**: MobX é mais simples para casos de uso diretos, com code generation que garante type-safety
- **vs Riverpod**: MobX tem melhor integração com Flutter Modular e menor curva de aprendizado

**Por que Flutter Modular?**
- **vs Navigator 2.0**: Flutter Modular oferece DI integrada e roteamento declarativo mais simples
- **vs GoRouter**: Modular tem melhor integração com injeção de dependências e suporte a rotas nomeadas

## 🛠️ Stack Tecnológica

- **Flutter**: Framework de desenvolvimento
- **Flutter Modular**: Navegação e injeção de dependências
- **MobX**: Gerenciamento de estado reativo
- **SQLite**: Persistência local de dados
- **Workmanager**: Sincronização em background
- **Image Picker**: Captura de fotos
- **Signature**: Assinatura digital

## 📦 Dependências Principais

```yaml
dependencies:
  flutter_modular: ^6.4.1
  mobx: ^2.3.0
  flutter_mobx: ^2.1.0
  sqflite: ^2.3.0
  workmanager: ^0.5.2
  image_picker: ^1.0.7
  signature: ^5.4.0
  mask_text_input_formatter: ^2.9.0
```

## 🚀 Como Executar

### Pré-requisitos

- Flutter SDK >= 3.5.1
- Dart SDK >= 3.5.1
- Android Studio / Xcode (para desenvolvimento mobile)

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/Eliabek07/sadamov-app.git
cd sadamov-app
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Gere o código do MobX:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Execute o aplicativo:
```bash
flutter run
```

## 📱 Funcionalidades

### 1. Checklist (Home)
- Tela inicial com card "Ocorrência"
- Navegação para o fluxo de registro

### 2. Ocorrência - Placa + Foto
- Campo de placa com máscara e validação
  - Aceita formatos: AAA-1234 (antigo) e AAA1A23 (novo)
- Componente de captura de fotos
  - Mínimo 1 foto obrigatória
  - Múltiplas fotos permitidas
- Botão "Avançar" habilitado apenas quando:
  - Placa válida
  - Pelo menos 1 foto capturada

### 3. Revisão & Finalizar
- Campo "Responsável" (obrigatório)
- Área de assinatura digital
  - Tela de desenho da assinatura
  - Visualização da assinatura após confirmação
- Botão "Finalizar" habilitado apenas quando:
  - Responsável preenchido
  - Assinatura realizada

### 4. Sucesso
- Exibição de cartão com informações:
  - Serviço
  - Responsável
  - Data/Hora
  - Placa do veículo
- Botão "OK" retorna à Home

## 💾 Persistência de Dados

### SQLite

O projeto utiliza **SQLite** para persistência local dos dados. A escolha do SQLite foi baseada nos seguintes critérios:

1. **Persistência Real**: Dados são salvos permanentemente no dispositivo, não em cache volátil
2. **Performance**: Excelente performance para operações de leitura/escrita
3. **Suporte Nativo**: Suporte nativo no Flutter através do pacote `sqflite`
4. **Confiabilidade**: Banco de dados relacional robusto e amplamente testado
5. **Escalabilidade**: Suporta grandes volumes de dados sem degradação de performance

### Trade-offs Técnicos

**Por que SQLite em vez de outras soluções?**
- **vs SharedPreferences**: SQLite oferece estrutura relacional e suporte a dados complexos (fotos, assinaturas em base64)
- **vs Hive/Isar**: SQLite é mais maduro, amplamente testado e não requer code generation adicional
- **vs Cache em memória**: SQLite garante persistência mesmo após fechamento do app, essencial para funcionalidade offline

### Estrutura do Banco

```sql
CREATE TABLE occurrences (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  plate TEXT NOT NULL,
  photos TEXT NOT NULL,
  responsible_name TEXT,
  signature TEXT,
  created_at TEXT NOT NULL,
  synced_at TEXT,
  is_synced INTEGER NOT NULL DEFAULT 0
)
```

## 🔄 Sincronização

### Background Job

O aplicativo utiliza **Timer periódico** para sincronização automática em background:

- **Frequência**: A cada 7 minutos (dentro do intervalo de 5-10 minutos conforme requisito)
- **Condição**: Apenas quando há conexão com internet
- **Taxa de Sucesso**: 70% (simulado)
- **Comportamento**: 
  - Em caso de sucesso: marca como sincronizado e remove do banco local
  - Em caso de falha: mantém no banco para tentativa posterior

### Trade-offs Técnicos

**Por que Timer em vez de Workmanager para intervalo de 5-10 minutos?**

- **Workmanager no Android**: Exige mínimo de 15 minutos para tarefas periódicas, não atendendo ao requisito de 5-10 minutos
- **Timer.periodic**: Permite intervalo exato de 7 minutos, garantindo que o requisito seja atendido
- **Limitação**: Timer funciona apenas quando o app está em execução (em foreground ou background)
- **Workmanager como complemento**: Inicializado no Android para execução quando app está fechado, mas com limitação de 15 minutos do sistema

### Cliente Mock

O `OccurrenceClient` simula o envio para uma API real:
- Delay de 1 segundo (simula latência de rede)
- 70% de chance de sucesso
- Tratamento de erros adequado

## ✅ Validações

### Placa do Veículo

- **Obrigatória**: Campo não pode estar vazio
- **Formatos Aceitos**:
  - Antigo: AAA-1234 (3 letras + hífen + 4 números)
  - Novo: AAA1A23 (3 letras + 1 número + 1 letra/número + 2 números)
- **Máscara Dinâmica**: Ajusta automaticamente durante a digitação

### Responsável

- **Obrigatório**: Campo não pode estar vazio
- **Tamanho**: Mínimo 3 caracteres, máximo 100 caracteres

### Fotos

- **Mínimo**: 1 foto obrigatória
- **Máximo**: Sem limite (limitado apenas pela memória do dispositivo)

### Assinatura

- **Obrigatória**: Deve ser desenhada antes de finalizar

## 🎨 Design System

O projeto segue um Design System consistente e padronizado:

### Cores

- **Surfaces**: Elevate, Background, Fields
- **Text**: Primary, Secondary, Titles, Errors
- **Actions**: Primary, Disabled

### Tipografia

- **Fonte**: Poppins
- **Hierarquia**: Display, Headline, Title, Body, Label
- **Pesos**: Regular (400), Medium (500), SemiBold (600), Bold (700)

### Espaçamentos

- **Padding**: Small (8px), Regular (16px), Large (24px), ExtraLarge (32px)
- **Border Radius**: Small (8px), Medium (12px), Large (16px)

## 📁 Estrutura de Pastas

```
lib/
├── core/
│   ├── di/              # Dependency Injection (Flutter Modular)
│   └── extensions/      # Extensões úteis
├── constants/           # Design System (cores, tipografia, espaçamentos)
├── model/
│   ├── client/          # Clientes de API (mock)
│   ├── data/            # Modelos de dados
│   ├── repository/      # Repositórios
│   └── exception/       # Exceções customizadas
├── store/               # MobX Stores
├── view/
│   ├── components/      # Componentes reutilizáveis
│   └── pages/           # Telas da aplicação
└── utils/
    ├── database/        # SQLite helpers
    └── services/        # Serviços (câmera, sincronização)
```

## 🔒 Segurança

- **SecureLogger**: Nunca usa `print()`, sempre `SecureLogger`
- **Permissões**: Solicita permissões adequadas (câmera)
- **Validação**: Validações robustas em todos os campos
- **Tratamento de Erros**: Tratamento adequado de exceções

## 🧪 Testes

O projeto inclui uma suíte completa de testes:

### Testes Unitários
- **Validadores**: Testes para validação de placa e campos obrigatórios
- **Store**: Testes para lógica de negócio e estado reativo
- **Client**: Testes para simulação de API

### Testes de Widget
- **Componentes**: Testes para CustomButton e CustomTextFormField
- **Interações**: Testes para estados habilitado/desabilitado e loading

### Testes de Integração
- **Fluxo Completo**: Teste end-to-end do fluxo checklist → ocorrência → revisão → sucesso
- **Validações**: Testes para validação de botões em diferentes estados

Para executar os testes:

```bash
flutter test
```

Para executar apenas testes unitários:

```bash
flutter test test/unit
```

Para executar apenas testes de widget:

```bash
flutter test test/widget
```

Para executar apenas testes de integração:

```bash
flutter test test/integration
```

## 📦 Build

### Android (APK)

```bash
flutter build apk --release
```

O APK estará em: `build/app/outputs/flutter-apk/app-release.apk`

### iOS

```bash
flutter build ios --release
```

## 📝 Convenções de Código

- **Arquivos**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variáveis/Métodos**: `camelCase`
- **Constantes**: `UPPER_SNAKE_CASE`
- **Nomenclatura**: Sempre em inglês

## 🤝 Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto foi desenvolvido como parte de um desafio técnico.

---

**Desafio Técnico - Ocorrência de Transporte (Offline → Sync)**
