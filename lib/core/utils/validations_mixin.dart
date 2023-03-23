mixin ValidationsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? "Este campo é obrigatório!";

    return null;
  }

  String? isValid(String? value, [String? message]) {
    if (value!.length < 4) return message ?? "Informe um nome válido";

    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();

      if (validation != null) return validation;
    }

    return null;
  }
}
