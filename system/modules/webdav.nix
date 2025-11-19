{ ... }:
{
  services.webdav = {
    enable = true;
    settings = {
      address = "10.241.75.233";
      port = 58081;
      directory = "/srv/public";
      modify = true;
      auth = true;
      # noPassword = true;
      permissions = "CRUD";
      users = [
        {
          username = "webdav";
          password = "asd";
        }
      ];
    };
  };
}
