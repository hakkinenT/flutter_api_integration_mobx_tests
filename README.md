# Flutter Integração com API Json Placeholeder usando Mobx e Testes
Projeto simples de integração com a API [Json Placeholder](https://jsonplaceholder.typicode.com/). 

Durante o desenvolvimento deste projeto foram feitos testes unitários, testes de widgets e testes de integração. Os testes de integração foram implementados usando o Robot Pattern.

## Status do Projeto
Em Desenvolvimento

## Funcionalidade

O projeto contém as seguintes funcionalidades:
- Criar um album

## Tecnologias
As seguintes tecnologias foram usadas neste projeto: 

> Veja o arquivo [pubspec.yaml](pubspec.yaml)

- [provider](https://pub.dev/packages/provider)
- [mobx](https://pub.dev/packages/mobx)
- [flutter_mobx](https://pub.dev/packages/flutter_mobx)
- [mobx_codegen](https://pub.dev/packages/mobx_codegen)
- [build_runner](https://pub.dev/packages/build_runner)
- [mockito](https://pub.dev/packages/mockito)
- [http](https://pub.dev/packages/http)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [json_annotation](https://pub.dev/packages/json_annotation)
- [equatable](https://pub.dev/packages/equatable)
- [get_it](https://pub.dev/packages/get_it)
- [dartz](https://pub.dev/packages/dartz)


## Conhecimentos aplicados de Flutter/Dart
- Integração com API
- Gerenciamento de Estado com Mobx
- Testes Unitários
- Testes de Widgets
- Testes de Integração
- Validação de formulário

## Padrões de projeto
Os seguintes padrões de projeto foram aplicados:
- Repository

# Passo a passo para executar o projeto

- Clone o repositório:

```shell
https://github.com/hakkinenT/flutter_api_integration_mobx_tests.git
```
- Instale as dependências

```shell
flutter pub get
```
- Rode o projeto

```shell
flutter run
```
## Executar Testes
1. Para executar todos os testes que estão dentro da pasta teste via terminal, execute o comando:

```shell
flutter test test/
```
*OBS: A pasta **test** contém tanto os testes unitários quanto os testes de widget*


2. Para executar os testes de integração via terminal, execute o comando:

```shell
flutter test integration_test/scenarios/
```
3. Execute os testes usando as ferramentas presente na IDE de sua preferência.
