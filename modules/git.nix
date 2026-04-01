{ ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "Mehmet Salih Yavuz";
        email = "salih.yavuz@proton.me";
      };
      init.defaultBranch = "main";
      credential.helper = "cache --timeout=86400";
      http = {
        postBuffer = 157286400;
        maxRequestBuffer = "100M";
      };
      core.compression = 0;
    };
  };
}
