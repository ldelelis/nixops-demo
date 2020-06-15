{
    webserver = {
        config, pkgs, ...
    } : {
        deployment = {
            targetEnv = "virtualbox";
            virtualbox = {
                memorySize = 1024;
                vcpu = 1;
                headless = true;
                vmFlags = [
                    "--natpf1" "http,tcp,192.168.100.12,8080,,80"
                ];
            };
        };
    };
}
