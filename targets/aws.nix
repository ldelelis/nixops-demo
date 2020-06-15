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
          accessKeyId = accessKeyId;
          region = region;
          instanceType = instanceType;

          # This creates an AWS key pair and then supplies it to the instance
          keyPair = resources.ec2KeyPairs.my-key-pair;

          # You can optionally specify your own private key to supply
          # This must be a .pem file
          # privateKey = "/path/to/my-key-pair.pem";

          # Optionally, other security groups can be specified as a list
          # securityGroups = [ "allow-http-all" "allow-ssh-all" ];
        };
      };
    };
in
{
  webserver = ec2;

  resources.ec2KeyPairs.my-key-pair = { inherit region accessKeyId; };
}
