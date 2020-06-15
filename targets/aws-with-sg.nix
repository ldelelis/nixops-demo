let
  region = "us-west-2";
  accessKeyId = "nixops-example";  # create credentials profile with this name
  instanceType = "t2.micro";

  ec2 = 
    { resources, ... }:  # Resources is an object containing all supported platforms, and its resources
    {
      deployment = {
        targetEnv = "ec2";
        ec2 = {
          inherit accessKeyId region instanceType;

          # This creates an AWS key pair and then supplies it to the instance
          keyPair = resources.ec2KeyPairs.my-key-pair;

          # You can optionally specify your own private key to supply
          # This must be a .pem file
          # privateKey = "/path/to/my-key-pair.pem";

          # Optionally, other security groups can be specified as a list
          securityGroups = [
            resources.ec2SecurityGroups.allow-http-all
            resources.ec2SecurityGroups.allow-ssh-all
          ];
        };
      };
    };
in
{
  webserver = ec2;

  # these extra resources MUST be declared down here
  resources.ec2KeyPairs.my-key-pair = { inherit region accessKeyId; };
  resources.ec2SecurityGroups.allow-http-all = {
    inherit accessKeyId region;  # This allows avoiding repetition of assigning these values

    name = "allow-http-all";
    description = "lorem ipsum";
    rules = [
      { fromPort = 80; toPort = 80; sourceIp = "0.0.0.0/0"; }
    ];
  };
  resources.ec2SecurityGroups.allow-ssh-all = {
    inherit accessKeyId region;

    name = "allow-ssh-all";
    description = "lorem ipsum";
    rules = [
      { fromPort = 22; toPort = 22; sourceIp = "0.0.0.0/0"; }
    ];
  };
}
