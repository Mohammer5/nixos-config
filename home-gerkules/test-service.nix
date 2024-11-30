_: {
  systemd.user.services.foo = {
    installConfig = {
      wantedBy = [ "multi-user.target" ];
    };

    unitConfig = {
      description = "Test service";
      after = "network.target";
      startLimitIntervalSec = 0;
    };

    serviceConfig = {
      execStart = "node /home/gerkules/development/playground/systemd-service/service.js";
      type = "simple";
      restart = "always";
      restartSec = 1;
      user = "gerkules";
    };
  };
}
