class FirebaseErrors {
  static String erroresFirebase(String error) {
    String errorSpanish = '';
    if (error.contains(
        'The password is invalid or the user does not have a password.')) {
      errorSpanish = 'La contraseña es incorrecta.';
    } else if (error.contains(
        'We have blocked all requests from this device due to unusual activity. Try again later.')) {
      errorSpanish =
          'Hemos bloqueado todas las solicitudes de este dispositivo debido a una actividad inusual. Inténtelo de nuevo más tarde.';
    } else if (error.contains(
        'There is no user record corresponding to this identifier. The user may have been deleted.')) {
      errorSpanish =
          'No existe una cuenta relacionada con el correo que se ingresó.';
    } else if (error.contains(
        'A network error (such as timeout, interrupted connection or unreachable host) has occurred.')) {
      errorSpanish = 'El acceso a internet se encuentra denegado.';
    } else if (error
        .contains('The email address is already in use by another account.')) {
      errorSpanish =
          'La dirección de correo electrónico ya está siendo utilizada por otra cuenta.';
    } else if (error.contains('DatabaseError: Permission denied')) {
      errorSpanish = 'Permiso denegado';
    } else {
      errorSpanish =
          'Ocurrio un error desconocido, por favor intentelo más tarde.';
    }
    return errorSpanish;
  }
}
