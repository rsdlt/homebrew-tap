class Armin < Formula
  desc "Autocomplete for zsh: a menu of your likeliest commands, ranked from history"
  homepage "https://github.com/rsdlt/armin"
  url "https://github.com/rsdlt/armin/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "01cbbe0a59725689c6ce099555945cbf8314babde459478682dfe78923714548"
  license "MIT"
  head "https://github.com/rsdlt/armin.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/armin-0.5.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0e6be585e6d8695c6ea54da899faf5be72e00c6ecf2155069ba7d5e7b1322af4"
    sha256 cellar: :any,                 x86_64_linux:  "6a27dada297424b9d6b9338cd2928e1e8e8afb6064184dcae0447fecc8b973b2"
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
