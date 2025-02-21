{pkgs, ...}: {
  # nixpkgs.config.packageOverrides = pkgs: {
  #   intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  # };
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    # intel-vaapi-driver
    intel-compute-runtime
    vpl-gpu-rt
  ];
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver
  # boot.kernelParams = ["i915.force_probe=46a6"];
}
