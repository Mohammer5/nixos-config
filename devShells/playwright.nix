{ pkgs }: pkgs.mkShell {
  name = "Playwright";

  # Remember to symlink chromium!
  # target = readlink -f (which chromium)
  # link = ~/.cache/ms-playwright/chromium-1117/chrome-linux/chrome
  shellHook = ''
  	export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
  	export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
  '';
}
