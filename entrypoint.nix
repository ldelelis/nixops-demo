{
    network.description = "Web Server";

    webserver = {
        config, pkgs, ...
    } : {
        services.httpd = {
            enable = true;
            adminAddr = "someaddress@mail.com";
            virtualHosts.localhost.documentRoot = "${pkgs.valgrind.doc}/share/doc/valgrind/html";
        };
        networking.firewall.allowedTCPPorts = [ 80 ];
    };
}
