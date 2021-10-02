# flutter_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Anotações

### GestureDetector vs InkWell

InkWell é um GestureDetector que possui um ripple effect como o TouchableOpacity do React Native. 
InkWell precisa estar envolvido em um widget Material, e o widget Material precisa ter uma cor que antes pertencia ao filho do GestureDetector.

### Column
mainAxisAlignment: Alinhamento do conteúdo na horizontal.
crossAxisAlignment: Alinhamento do conteúdo na vertical.

### Row
mainAxisAlignment: Alinhamento do conteúdo na vertical.
crossAxisAlignment: Alinhamento do conteúdo na horizontal.

### SizedBox
É possível aumentar o width de um widget para 100% envolvendo em um SizedBox com width double.maxFinite.

