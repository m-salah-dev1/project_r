



enum Authstatus { 
  initial, 
  loading, 
  success, 
  error, 
  offline,
}


class Authstate{ 
  final Authstatus status; 
  final String? message; 
  Authstate({  
    this.status = Authstatus.initial, this.message});
}



