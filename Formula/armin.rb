class Armin < Formula
  desc "Autocomplete for zsh: a menu of your likeliest commands, ranked from history"
  homepage "https://github.com/rsdlt/armin"
  url "https://github.com/rsdlt/armin/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "c2b08c092a2110f1f636d334def47a3ef328852192f9ec2d47e33b6637edb41e"
  license "MIT"
  head "https://github.com/rsdlt/armin.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/armin-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5d44e8f31775a678c1767f506ed6d072e2372524f6917aa20ab95dbe61553d28"
    sha256 cellar: :any,                 x86_64_linux:  "e802022d11730d454cfc00852a090e68a1cebbb1c506c3ebbad47365f600a6c0"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Add armin to ~/.zshrc, with zsh's completion system for Tab's menu,
      and bring in your history once:
        autoload -Uz compinit && compinit
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
    assert_match "theme", shell_output("#{bin}/armin config")
  end
end
