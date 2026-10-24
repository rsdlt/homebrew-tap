class Armin < Formula
  desc "Autocomplete for zsh: a menu of your likeliest commands, ranked from history"
  homepage "https://github.com/rsdlt/armin"
  url "https://github.com/rsdlt/armin/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "afff7a7dcde13251469da45306857229032cd9e26bbad8647a3a9a84d2d56119"
  license "MIT"
  head "https://github.com/rsdlt/armin.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/armin-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1cf02687b4333895948e3d14ff6d6e1b6a7ab029212842496ce9efe45323c299"
    sha256 cellar: :any,                 x86_64_linux:  "6ff62dc8031a5ba03c965ba4f9c51e937af77de216bccc134009af38065419fb"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Add armin to ~/.zshrc, and bring in your history once:
        eval "$(armin init zsh)"
        armin import
      Remove zsh-autosuggestions if you use it: both draw in the same place.
    EOS
  end

  test do
    assert_match "armin #{version}", shell_output("#{bin}/armin --version")
    assert_match "_armin_bin='#{bin}/armin'", shell_output("#{bin}/armin init zsh")

    ENV["ARMIN_DATA_DIR"] = testpath
    system bin/"armin", "record", "--time", "1700000000", "--duration", "5", "--exit", "0",
           "--session", "test", "--cwd", testpath, "--", "git status"
    assert_match "git status", shell_output("#{bin}/armin suggest --cwd #{testpath} -- git")
  end
end
