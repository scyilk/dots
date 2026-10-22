{
  description = "NixOS config";

  nixConfig = {
    extra-experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bedrock-on-linux = {
      url = "github:Wyze3306/BedrockOnLinux";
    };
  };

  outputs = { nixpkgs, home-manager, bedrock-on-linux, ... }:
    let
      system = "x86_64-linux";
      username = "scyilk";
      hostname = "dell-g3-3500";
    in {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system username hostname; };
        modules = [
          { nixpkgs.hostPlatform = system; }
          ./hosts/dell-g3-3500
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit system username hostname bedrock-on-linux; };
            home-manager.users.${username} = import ./home;
          }
        ];
      };
    };
}
