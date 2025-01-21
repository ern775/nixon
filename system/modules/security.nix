{
  security.rtkit.enable = true;
  #Passwordless sudo
  security.sudo.extraRules= [
  {  users = [ "eren" ];
    commands = [
       { command = "ALL" ;
         options= [ "NOPASSWD" ];
      }
    ];
  }
];
}